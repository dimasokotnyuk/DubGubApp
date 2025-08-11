//
//  ProfileModalView.swift
//  DubDubGrub
//
//  Created by Дмитро Сокотнюк on 22.07.2025.
//

import SwiftUI

struct ProfileModalView: View {
    
    var profile: DDGProfile
    @Binding var isShowingProfileModal: Bool
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                    .frame(height: 60)
                
                Text(profile.firstName + " " + profile.lastName)
                    .bold()
                    .font(.title2)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
                    .padding(.horizontal)
                
                Text(profile.companyName)
                    .fontWeight(.semibold)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
                    .padding(.horizontal)
                
                Text(profile.bio)
                    .lineLimit(3)
                    .padding()
            }
            .frame(width: 300, height: 230)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(16)
            .overlay(alignment: .topTrailing) {
                Button {
                    withAnimation {
                        isShowingProfileModal = false
                    }
                } label: {
                    XDismissButton()
                }
            }
            
            AvatarView(image: profile.avatarImage, size: 90)
                .shadow(radius: 4)
                .offset(y: -110)
        }
        
    }
}

#Preview {
    ProfileModalView(profile: DDGProfile(record: MockData.profile), isShowingProfileModal: .constant(true))
}
