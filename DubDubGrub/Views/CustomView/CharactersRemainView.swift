//
//  CharactersRemainView.swift
//  DubDubGrub
//
//  Created by Дмитро Сокотнюк on 30.07.2025.
//

import SwiftUI

struct CharactersRemainView: View {
    var currentCount: Int
    let limitBio: Int
    
    var body: some View {
        Text("Bio: ")
            .font(.caption)
            .foregroundStyle(.secondary)
        +
        Text("\(limitBio - currentCount)")
            .font(.caption)
            .foregroundStyle(currentCount >= limitBio ? .red : .brandPrimary)
            .fontWeight(.bold)
        +
        Text(" characters remain")
            .font(.caption)
            .foregroundStyle(.secondary)
    }
}

#Preview {
    CharactersRemainView(currentCount: 20, limitBio: 100)
}
