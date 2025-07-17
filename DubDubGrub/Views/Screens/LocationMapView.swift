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
    }
}

#Preview {
    LocationMapView()
}
