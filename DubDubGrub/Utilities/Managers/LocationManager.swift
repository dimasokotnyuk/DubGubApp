//
//  LocationManager.swift
//  DubDubGrub
//
//  Created by Дмитро Сокотнюк on 19.07.2025.
//

import SwiftUI
import MapKit

final class LocationManager: ObservableObject {
    @Published var locations: [DDGLocation] = []
    var selectedLocation: DDGLocation?
}
