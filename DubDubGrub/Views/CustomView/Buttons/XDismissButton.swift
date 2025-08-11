//
//  XDismissButton.swift
//  DubDubGrub
//
//  Created by Дмитро Сокотнюк on 20.07.2025.
//

import SwiftUI

struct XDismissButton: View {
    
    var body: some View {
        Image(systemName: "xmark.circle.fill")
            .resizable()
            .frame(width: 32, height: 32)
            .foregroundStyle(.brandPrimary)
            .frame(width: 50, height: 50)
    }
}

#Preview {
    XDismissButton()
}
