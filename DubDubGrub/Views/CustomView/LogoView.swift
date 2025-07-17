//
//  LogoView.swift
//  DubDubGrub
//
//  Created by Дмитро Сокотнюк on 17.07.2025.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        Image(.ddgMapLogo)
            .resizable()
            .scaledToFit()
            .frame(height: 70)
    }
}

#Preview {
    LogoView()
}
