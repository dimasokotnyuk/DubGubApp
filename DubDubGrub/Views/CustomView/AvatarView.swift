//
//  AvatarView.swift
//  DubDubGrub
//
//  Created by Дмитро Сокотнюк on 17.07.2025.
//

import SwiftUI

struct AvatarView: View {
    
    var image: UIImage
    let size: CGFloat
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFill()
            .frame(width: size, height: size)
            .clipShape(.circle)
    }
}

#Preview {
    AvatarView(image: PlaceHolderImage.avatar, size: 35)
}
