//
//  LocationListView.swift
//  DubDubGrub
//
//  Created by Дмитро Сокотнюк on 15.07.2025.
//

import SwiftUI

struct LocationListView: View {
    
    @EnvironmentObject private var locationManager: LocationManager
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(locationManager.locations) { location in
                    NavigationLink(destination: LocationDetailView(viewModel: LocationDetailViewModel(location: location))) {
                        LocationCell(location: location)
                    }
                }
            }
            .onAppear {
                CloudKitManager.shared.getCheckedInProfilesDictionary { result in
                        switch result {
                        case .success(let checkedInProfiles):
                            print(checkedInProfiles)
                        case .failure(_):
                            print("Error getting back dictionary")
                        }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Grub Spots")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


#Preview {
    LocationListView()
        .environmentObject(LocationManager()) 
}


