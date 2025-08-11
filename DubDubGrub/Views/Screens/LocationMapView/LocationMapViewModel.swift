//
//  LocationMapViewModel.swift
//  DubDubGrub
//
//  Created by Дмитро Сокотнюк on 18.07.2025.
//

import SwiftUI
import CloudKit
import MapKit

extension LocationMapView {
    
    @Observable
    final class LocationMapViewModel: NSObject, CLLocationManagerDelegate {
        
        var isShowingDetailView = false
        var alertItem: AlertItem?
        var cameraPosition = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.331516, longitude: -121.891054), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)))
        var checkedInProfilesCount: [CKRecord.ID: Int] = [:]
        
        let deviceLocationManager = CLLocationManager()
        
        override init() {
            super.init()
            deviceLocationManager.delegate = self
        }
        
        func requestAllowOnceLocationPermission() {
            deviceLocationManager.requestLocation()
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let currentLocation = locations.last else {
                return
            }
            
            withAnimation {
                cameraPosition = MapCameraPosition.region(MKCoordinateRegion(center: currentLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)))
            }
        }
        
        func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
            print("Did fail with error")
        }
        
        
        @MainActor
        func getCheckedInProfilesCount() {
            Task {
                do {
                    checkedInProfilesCount = try await CloudKitManager.shared.getCheckedInProfilesCount()
                } catch {
                    alertItem = AlertContext.checkedInCount
                }
            }
        }
        
        
        @MainActor
        func getLocations(for locationManager: LocationManager) {
            Task {
                do {
                    locationManager.locations = try await CloudKitManager.shared.getLocations()
                } catch {
                    alertItem = AlertContext.unableToGetLocations
                }
            }
        }
        
        
        @MainActor
        @ViewBuilder func createLocationDetailView(for location: DDGLocation, in dynamicTypeSize: DynamicTypeSize) -> some View {
            if dynamicTypeSize > .xxxLarge {
                LocationDetailView(viewModel: LocationDetailView.LocationDetailViewModel(location: location)).embedInScrollView()
            } else {
                LocationDetailView(viewModel: LocationDetailView.LocationDetailViewModel(location: location))
            }
        }
    }
    
}
