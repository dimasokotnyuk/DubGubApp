//
//  ProfileSheetView.swift
//  DubDubGrub
//
//  Created by Дмитро Сокотнюк on 29.07.2025.
//

import SwiftUI

// Alternative Profile Modal View for larger dynamic type sizes
// We present this as a sheet instead of a small pop up

struct ProfileSheetView: View {
    
    var profile: DDGProfile
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                AvatarView(image: profile.avatarImage, size: 90)
                    .shadow(radius: 4)
                
                Text(profile.firstName)
                    .bold()
                    .font(.title2)
                    .minimumScaleFactor(0.9)
                
                Text(profile.lastName)
                    .bold()
                    .font(.title2)
                    .minimumScaleFactor(0.9)
                
                Text(profile.companyName)
                    .fontWeight(.semibold)
                    .foregroundStyle(.secondary)
                    .minimumScaleFactor(0.9)
                
                Text(profile.bio)
                    .padding()
            }
            .padding()
        }
    }
}

#Preview {
    ProfileSheetView(profile: DDGProfile(record: MockData.profile))
}
