//
//  LocationListViewModel.swift
//  DubDubGrub
//
//  Created by Дмитро Сокотнюк on 23.07.2025.
//

import CloudKit
import SwiftUI
import Observation

extension LocationListView {
    
    @MainActor @Observable
    final class LocationListViewModel {
        var checkedInProfiles: [CKRecord.ID: [DDGProfile]] = [:]
        var alertItem: AlertItem?
        
        func getCheckedInProfilesDictionary() async {
            do {
                checkedInProfiles  = try await CloudKitManager.shared.getCheckedInProfilesDictionary()
            } catch {
                alertItem = AlertContext.unableToGetAllCheckedInProfiles
            }
        }
        
        
        @ViewBuilder func createLocationDetailView(for location: DDGLocation, in dynamicTypeSize: DynamicTypeSize) -> some View {
            if dynamicTypeSize > .xxxLarge {
                LocationDetailView(viewModel: LocationDetailView.LocationDetailViewModel(location: location)).embedInScrollView()
            } else {
                LocationDetailView(viewModel: LocationDetailView.LocationDetailViewModel(location: location))
            }
        }
    }
    
}
