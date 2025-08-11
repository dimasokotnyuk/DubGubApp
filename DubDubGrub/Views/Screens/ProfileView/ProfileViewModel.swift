//
//  ProfileViewModel.swift
//  DubDubGrub
//
//  Created by Дмитро Сокотнюк on 20.07.2025.
//

import CloudKit
import PhotosUI
import SwiftUI
import Observation

enum ProfileContext {
    case create, update
}

extension ProfileView {
    
    @MainActor @Observable
    final class ProfileViewModel {
        var firstName: String    = ""
        var lastName: String     = ""
        var companyName: String  = ""
        var bio: String          = ""
        var avatar               = PlaceHolderImage.avatar
        var isLoading: Bool      = false
        var isCheckedIn: Bool    = false
        
        var alertItem: AlertItem?
        var selectedImage: PhotosPickerItem?
        
        let limitBio = 100
    
        var bioStrokeColor: Color {
            bio.isEmpty ? .secondary : .green
        }
        var titleButton: String {
            profileContext == .create ? "Create Profile" : "Update Profile"
        }
        
        @ObservationIgnored
        private var existingProfileRecord: CKRecord? {
            didSet {
                profileContext = .update
            }
        }
        @ObservationIgnored
        var profileContext = ProfileContext.create
        
        
        func isValidProfile() -> Bool {
            guard !firstName.isEmpty,
                  !lastName.isEmpty,
                  !companyName.isEmpty,
                  !bio.isEmpty,
                  avatar != PlaceHolderImage.avatar,
                  bio.count <= limitBio else {
                return false
            }
            
            return true
        }
        
        
        func getCheckedInStatus() {
            guard let profileRecordID = CloudKitManager.shared.profileRecordID else {
                return
            }
            
            Task {
                do {
                    let record = try await CloudKitManager.shared.fetchRecord(with: profileRecordID)
                    if let _ = record[DDGProfile.kIsCheckedIn] as? CKRecord.Reference {
                        isCheckedIn = true
                    } else {
                        isCheckedIn = false
                    }
                } catch {
                    print("Unable to get checked in status")
                }
            }
        }
        
        
        func checkOut() {
            guard let profileID = CloudKitManager.shared.profileRecordID else {
                alertItem = AlertContext.unableToGetProfile
                return
            }
            
            showLoadingView()
            
            Task {
                do {
                    let record = try await CloudKitManager.shared.fetchRecord(with: profileID)
                    record[DDGProfile.kIsCheckedIn] = nil
                    record[DDGProfile.kIsCheckedInNilCheck] = nil
                    
                    _ = try await CloudKitManager.shared.save(record: record)
                    HapticManager.playSuccess()
                    isCheckedIn = false
                    
                    hideLoadingView()
                } catch {
                    hideLoadingView()
                    alertItem = AlertContext.unableToGetCheckInStatus
                }
            }
        }
        
        
        func determineButtonAction() {
            profileContext == .create ? createProfile() : updateProfile()
        }
        
        
        private func createProfile() {
            guard isValidProfile() else {
                alertItem = AlertContext.invalidProfile
                return
            }
            
            let profileRecord = createProfileRecord()
            
            guard let userRecord = CloudKitManager.shared.userRecord else {
                alertItem = AlertContext.noUserRecord
                return
            }
            
            //Create reference on UserRecord to the DDGProfile we created
            userRecord["userProfile"] = CKRecord.Reference(recordID: profileRecord.recordID, action: .none)
            
            showLoadingView()
            
            Task {
                do {
                    let records = try await CloudKitManager.shared.batchSave(records: [userRecord, profileRecord])
                    for record in records where record.recordType == RecordType.profile {
                        existingProfileRecord = record
                        CloudKitManager.shared.profileRecordID = record.recordID
                    }
                    hideLoadingView()
                    alertItem = AlertContext.createProfileSuccess
                } catch {
                    hideLoadingView()
                    alertItem = AlertContext.createProfileFailure
                }
            }
        }
        
        
        func getProfile() {
            
            guard let userRecord = CloudKitManager.shared.userRecord else {
                alertItem = AlertContext.noUserRecord
                return
            }
            
            guard let profileReference = userRecord["userProfile"] as? CKRecord.Reference else {
                return
            }
            let profileRecordID = profileReference.recordID
            
            showLoadingView()
            
            Task {
                do {
                    let record = try await CloudKitManager.shared.fetchRecord(with: profileRecordID)
                    existingProfileRecord = record
                    profileContext = .update
                    
                    let profile = DDGProfile(record: record)
                    firstName = profile.firstName
                    lastName = profile.lastName
                    companyName = profile.companyName
                    bio = profile.bio
                    avatar = profile.avatarImage
                    
                    hideLoadingView()
                } catch {
                    hideLoadingView()
                    alertItem = AlertContext.unableToGetProfile
                }
            }
        }
        
        
        private func updateProfile() {
            guard isValidProfile() else {
                alertItem = AlertContext.invalidProfile
                return
            }
            
            guard let profileRecord = existingProfileRecord else {
                alertItem = AlertContext.unableToGetProfile
                return
            }
            
            profileRecord[DDGProfile.kFirstName] = firstName
            profileRecord[DDGProfile.kLastName] = lastName
            profileRecord[DDGProfile.kCompanyName] = companyName
            profileRecord[DDGProfile.kBio] = bio
            profileRecord[DDGProfile.kAvatar] = avatar.convertToCKAsset()
            
            showLoadingView()
            
            Task {
                do {
                    let _ = try await CloudKitManager.shared.save(record: profileRecord)
                    hideLoadingView()
                    alertItem = AlertContext.updateProfileSuccess
                } catch {
                    hideLoadingView()
                    alertItem = AlertContext.updateProfileFailure
                }
            }
        }
        
        
        func createProfileRecord() -> CKRecord {
            let profileRecord = CKRecord(recordType: RecordType.profile)
            profileRecord[DDGProfile.kFirstName] = firstName
            profileRecord[DDGProfile.kLastName] = lastName
            profileRecord[DDGProfile.kCompanyName] = companyName
            profileRecord[DDGProfile.kBio] = bio
            profileRecord[DDGProfile.kAvatar] = avatar.convertToCKAsset()
            return profileRecord
        }
        
        
        private func showLoadingView() {
            isLoading = true
        }
        
        
        private func hideLoadingView() {
            isLoading = false
        }
    }
}
