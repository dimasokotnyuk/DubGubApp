//
//  LocationActionButton.swift
//  DubDubGrub
//
//  Created by Дмитро Сокотнюк on 17.07.2025.
//

import SwiftUI

struct LocationActionButton: View {
    let iconName: String
    let color: Color
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 60, height: 60)
                .foregroundStyle(color)
            
            Image(systemName: iconName)
                .resizable()
                .scaledToFit()
                .foregroundStyle(.white)
                .frame(width: 24, height: 24)
        }
    }
}

#Preview {
    LocationActionButton(iconName: "location.fill", color: .brandPrimary)
}
