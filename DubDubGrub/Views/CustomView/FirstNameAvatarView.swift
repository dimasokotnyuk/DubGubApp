//
//  FirstNameAvatarView.swift
//  DubDubGrub
//
//  Created by Дмитро Сокотнюк on 17.07.2025.
//

import SwiftUI

struct FirstNameAvatarView: View {
    
    var profile: DDGProfile
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    var body: some View {
        VStack {
            AvatarView(image: profile.avatarImage, size: dynamicTypeSize > .xxxLarge ? 100 : 64)
            
            Text(profile.firstName)
                .bold()
                .lineLimit(1)
                .minimumScaleFactor(0.75)
        }
    }
}

#Preview {
    FirstNameAvatarView(profile: DDGProfile(record: MockData.profile))
}
