//
//  LocationMapView.swift
//  DubDubGrub
//
//  Created by Дмитро Сокотнюк on 15.07.2025.
//

import SwiftUI
import MapKit
import CoreLocationUI

struct LocationMapView: View {
    
    @State private var viewModel = LocationMapViewModel()
    @EnvironmentObject private var locationsManager: LocationManager
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    var body: some View {
        ZStack(alignment: .top) {
            
            Map(position: $viewModel.cameraPosition) {
                UserAnnotation {
                    UserMapPinView()
                }
                
                ForEach(locationsManager.locations) { location in
                    Annotation("", coordinate: location.location.coordinate, anchor: .bottom) {
                        DDGAnnotation(location: location,
                                      count: viewModel.checkedInProfilesCount[location.id] ?? 0)
                        .onTapGesture {
                            locationsManager.selectedLocation = location
                            viewModel.isShowingDetailView = true
                        }
                    }
                }
            }
            .ignoresSafeArea(edges: .top)
            
            LogoView(frameHeight: 75)
                .shadow(radius: 10)
            
        }
        .alert(item: $viewModel.alertItem) { $0.alert }
        .sheet(isPresented: $viewModel.isShowingDetailView,) {
            if let selectedLocation = locationsManager.selectedLocation {
                NavigationStack {
                    viewModel.createLocationDetailView(for: selectedLocation, in: dynamicTypeSize)
                        .toolbar {
                            Button {
                                viewModel.isShowingDetailView = false
                            } label: {
                                Label("Back", systemImage: "arrow.uturn.backward")
                            }
                        }
                }
            }
        }
        .overlay(alignment: .bottomTrailing) {
            LocationButton(.currentLocation) {
                viewModel.requestAllowOnceLocationPermission()
            }
            .foregroundStyle(.white)
            .symbolVariant(.fill)
            .tint(.red)
            .labelStyle(.iconOnly)
            .clipShape(.circle)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 20))
        }
        .task {
            if locationsManager.locations.isEmpty {
                viewModel.getLocations(for: locationsManager)
            }
            
            viewModel.getCheckedInProfilesCount()
        }
    }
}

#Preview {
    LocationMapView()
        .environmentObject(LocationManager())
}
