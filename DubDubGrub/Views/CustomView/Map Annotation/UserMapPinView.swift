//
//  UserMapPinView.swift
//  DubDubGrub
//
//  Created by Дмитро Сокотнюк on 23.07.2025.
//

import SwiftUI

struct UserMapPinView: View {
    
    var body: some View {
        Image(.userMap)
            .resizable()
            .scaledToFill()
            .frame(width: 42, height: 42)
            .phaseAnimator([true, false]) { content, phase in
                content
                    .scaleEffect(phase ? 1.2 : 1)
                    .offset(y: phase ? -10 : 0)
            } animation: { phase in
                switch phase {
                case true:
                    return .easeInOut(duration: 1)
                case false:
                    return .easeInOut(duration: 1)
                }
            }
    }
}

#Preview {
    UserMapPinView()
}
