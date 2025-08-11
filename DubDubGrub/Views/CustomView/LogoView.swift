//
//  LogoView.swift
//  DubDubGrub
//
//  Created by Дмитро Сокотнюк on 17.07.2025.
//

import SwiftUI

struct LogoView: View {
    
    var frameHeight: CGFloat
    
    var body: some View {
        Image(.ddgMapLogo)
            .resizable()
            .scaledToFit()
            .frame(height: frameHeight)
    }
}

#Preview {
    LogoView(frameHeight: 75)
}
