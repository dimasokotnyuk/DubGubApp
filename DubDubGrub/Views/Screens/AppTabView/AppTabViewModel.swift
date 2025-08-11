//
//  AppTabViewModel.swift
//  DubDubGrub
//
//  Created by Дмитро Сокотнюк on 23.07.2025.
//

import CoreLocation
import SwiftUI

extension AppTabView {
    
    final class AppTabViewModel: ObservableObject {
        
        @Published var isShowingOnboardView = false
        @AppStorage("hasSeenOnboardView") var hasSeenOnboardView = false {
            didSet {
                isShowingOnboardView = hasSeenOnboardView
            }
        }
        
        let kHasSeenOnboardView = "hasSeenOnboardView"

        
        func checkIfHasSeenOnboard() {
            if !hasSeenOnboardView {
                hasSeenOnboardView = true
            }
        }
    }
}
