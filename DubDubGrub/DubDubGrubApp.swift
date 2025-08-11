//
//  DubDubGrubApp.swift
//  DubDubGrub
//
//  Created by Дмитро Сокотнюк on 15.07.2025.
//

import SwiftUI

@main
struct DubDubGrubApp: App {
    
    let locationManager = LocationManager()
    
    var body: some Scene {
        WindowGroup {
            AppTabView()
                .environmentObject(locationManager)
        }
    }
}
