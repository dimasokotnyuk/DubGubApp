//
//  LocationDetailViewModel.swift
//  DubDubGrub
//
//  Created by Дмитро Сокотнюк on 21.07.2025.
//

import SwiftUI
import MapKit
import CloudKit
import Observation

enum CheckInStatus {
    case checkedIn, checkedOut
}

extension LocationDetailView {
    
    @MainActor @Observable
    final class LocationDetailViewModel {
        
        var alertItem: AlertItem?
        var isShowingProfileModel            = false
        var isShowingProfileSheet            = false
        var checkedInProfiles: [DDGProfile]  = []
        var isCheckedIn                      = false
        var isLoading                        = false
        
        @ObservationIgnored var location: DDGLocation
        @ObservationIgnored var selectedProfile: DDGProfile?
        var buttonColor: Color {
            isCheckedIn ? .red : .brandPrimary
        }
        var buttonImageTitile: String{
            isCheckedIn ? "person.fill.xmark" : "person.fill.checkmark"
        }
        
        init(location: DDGLocation) {
            self.location = location
        }
        
        
        func determineColumns(for dynamicTypeSize: DynamicTypeSize) -> [GridItem] {
            let numberOfColumns = dynamicTypeSize > .xxxLarge ? 1 : 3
            return Array(repeating: GridItem(.flexible()), count: numberOfColumns)
        }
        
        
        func getDirectionsToLocation() {
            let placemark   = MKPlacemark(coordinate: location.location.coordinate)
            let mapItem     = MKMapItem(placemark: placemark)
            mapItem.name    = location.name
            
            mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking])
        }
        
        
        func callLocation() {
            guard let url = URL(string: "tel://+1\(location.phoneNumber)") else {
                alertItem = AlertContext.invalidPhoneNumber
                return
            }
            
            UIApplication.shared.open(url)
        }
        
        
        func getCheckedInStatus() {
            guard let profileRecordID = CloudKitManager.shared.profileRecordID else {
                return
            }
            
            Task {
                do {
                    let record = try await CloudKitManager.shared.fetchRecord(with: profileRecordID)
                    if let reference = record[DDGProfile.kIsCheckedIn] as? CKRecord.Reference {
                        isCheckedIn = reference.recordID == location.id
                    } else {
                        isCheckedIn = false
                    }
                } catch {
                    alertItem = AlertContext.unableToGetCheckInStatus
                }
            }
        }
        
        
        func updateCheckInStatus(to checkInStatus: CheckInStatus) {
            // retrieve  the DDGProfile
            guard let profileRecordID = CloudKitManager.shared.profileRecordID else {
                alertItem = AlertContext.unableToGetProfile
                return
            }
            
            showLoadingView()
            
            Task {
                do {
                    let record = try await CloudKitManager.shared.fetchRecord(with: profileRecordID)
                    switch checkInStatus {
                    case .checkedIn:
                        record[DDGProfile.kIsCheckedIn] = CKRecord.Reference(recordID: location.id, action: .none)
                        record[DDGProfile.kIsCheckedInNilCheck] = 1
                    case .checkedOut:
                        record[DDGProfile.kIsCheckedIn] = nil
                        record[DDGProfile.kIsCheckedInNilCheck] = nil
                    }
                    
                    let savedRecord = try await CloudKitManager.shared.save(record: record)
                    HapticManager.playSuccess()
                    let profile = DDGProfile(record: savedRecord)
                    switch checkInStatus {
                    case .checkedIn:
                        // update our checkedInProfiles array
                        checkedInProfiles.append(profile)
                    case .checkedOut:
                        checkedInProfiles.removeAll(where: {$0.id == profile.id})
                    }
                    
                    isCheckedIn.toggle()
                    hideLoadingView()
                } catch {
                    hideLoadingView()
                    alertItem = AlertContext.unableToGetProfile
                }
            }
        }
        
        
        func getCheckedInProfiles() {
            showLoadingView()
            Task {
                do {
                    checkedInProfiles = try await CloudKitManager.shared.getCheckedInProfiles(for: location.id)
                    hideLoadingView()
                } catch {
                    alertItem = AlertContext.unableToGetCheckedInProfiles
                    hideLoadingView()
                }
            }
        }
        
        
        func show(_ profile: DDGProfile, in dynamicTypeSize: DynamicTypeSize) {
            selectedProfile = profile
            if dynamicTypeSize > .xxxLarge {
                isShowingProfileSheet = true
            } else {
                isShowingProfileModel = true
            }
        }
        
        
        private func showLoadingView() {
            isLoading = true
        }
        
        
        private func hideLoadingView() {
            isLoading = false
        }
    }
    
}
