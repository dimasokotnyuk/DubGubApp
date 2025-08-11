//
//  HapticManager.swift
//  DubDubGrub
//
//  Created by Дмитро Сокотнюк on 30.07.2025.
//

import UIKit

struct HapticManager {
    
    static func playSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}
