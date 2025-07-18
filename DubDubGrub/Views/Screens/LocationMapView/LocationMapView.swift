//
//  LocationMapView.swift
//  DubDubGrub
//
//  Created by Дмитро Сокотнюк on 15.07.2025.
//

import SwiftUI
import MapKit

struct LocationMapView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.331516, longitude: -121.891054), span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.0))
    @State private var alertItem: AlertItem?
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $region)
                .ignoresSafeArea(edges: .top)
            
            VStack {
                LogoView()
                    .shadow(radius: 10)
                
                Spacer()
            }
        }
        .alert(item: $alertItem) { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButtonText)
        }
        .onAppear {
            CloudKitManager.getLocations { result in
                switch result {
                case .success(let locations): print(locations)
                case .failure(_): alertItem = AlertContext.unableToGetLocations
                }
            }
        }
    }
}

#Preview {
    LocationMapView()
}
