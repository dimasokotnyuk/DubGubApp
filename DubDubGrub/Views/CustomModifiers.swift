//
//  CustomModifiers.swift
//  DubDubGrub
//
//  Created by Дмитро Сокотнюк on 17.07.2025.
//

import SwiftUI

struct ProfileNameText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 28, weight: .bold))
            .lineLimit(1)
            .minimumScaleFactor(0.75)
    }
}

struct ButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .bold()
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
    }
}
