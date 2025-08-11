//
//  LocationListView.swift
//  DubDubGrub
//
//  Created by Дмитро Сокотнюк on 15.07.2025.
//

import SwiftUI

struct LocationListView: View {
    
    @EnvironmentObject private var locationManager: LocationManager
    @State private var viewModel = LocationListViewModel()
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(locationManager.locations) { location in
                    NavigationLink(value: location) {
                        LocationCell(location: location,
                                     profiles: viewModel.checkedInProfiles[location.id, default: []])
                    }
                }
            }
            .navigationTitle("Grub Spots")
            .navigationDestination(for: DDGLocation.self, destination: { location in
                viewModel.createLocationDetailView(for: location, in: dynamicTypeSize)
            })
            .task {
                await viewModel.getCheckedInProfilesDictionary()
            }
            .alert(item: $viewModel.alertItem) { $0.alert }
            .listStyle(.plain)
            .refreshable {
                await viewModel.getCheckedInProfilesDictionary()
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


#Preview {
    LocationListView()
        .environmentObject(LocationManager()) 
}


