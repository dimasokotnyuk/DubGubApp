//
//  AvatarView.swift
//  DubDubGrub
//
//  Created by Дмитро Сокотнюк on 17.07.2025.
//

import SwiftUI

struct AvatarView: View {
    let size: CGFloat
    
    var body: some View {
        Image(.defaultAvatar)
            .resizable()
            .scaledToFit()
            .frame(height: size)
            .clipShape(.circle)
    }
}

#Preview {
    AvatarView(size: 35)
}
