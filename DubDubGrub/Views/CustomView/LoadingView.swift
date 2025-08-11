//
//  LoadingView.swift
//  DubDubGrub
//
//  Created by Дмитро Сокотнюк on 21.07.2025.
//

import SwiftUI

struct LoadingView: View {
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .opacity(0.9)
                .ignoresSafeArea()
            
            ProgressView()
                .tint(Color.brandPrimary)
        }
    }
}

#Preview {
    LoadingView()
}
