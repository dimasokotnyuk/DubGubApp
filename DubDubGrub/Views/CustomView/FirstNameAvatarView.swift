//
//  FirstNameAvatarView.swift
//  DubDubGrub
//
//  Created by Дмитро Сокотнюк on 17.07.2025.
//

import SwiftUI

struct FirstNameAvatarView: View {
    let name: String
    
    var body: some View {
        VStack {
            AvatarView(size: 64)
            
            Text(name)
                .bold()
                .lineLimit(1)
                .minimumScaleFactor(0.75)
        }
    }
}

#Preview {
    FirstNameAvatarView(name: "Name")
}
