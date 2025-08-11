//
//  OnboardView.swift
//  DubDubGrub
//
//  Created by Дмитро Сокотнюк on 19.07.2025.
//

import SwiftUI

struct OnboardView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Button {
                    dismiss()
            } label: {
                    XDismissButton()
                }
                .padding()
            }
            
            Spacer()
            
            LogoView(frameHeight: 150)
                .padding()
            
            VStack(alignment: .leading, spacing: 32) {
                OnboardInfoView(imageString: "building.2.crop.circle", titleInfo: "Restaurant Locations", descriptionInfo: "Find places to dine around the convention center")
                
                OnboardInfoView(imageString: "checkmark.circle", titleInfo: "Check In", descriptionInfo: "Let other iOS Devs know where you are")
                
                OnboardInfoView(imageString: "person.2.circle", titleInfo: "Find Friends", descriptionInfo: "See where other iOS Devs are and join the party")
            }
            .padding(.horizontal, 32)
            
            Spacer()
            Spacer()
        }
    }
}

#Preview {
    OnboardView()
        .environmentObject(LocationManager())
}

fileprivate struct OnboardInfoView: View {
    var imageString: String
    var titleInfo: String
    var descriptionInfo: String
    
    var body: some View {
        HStack(spacing: 26) {
         Image(systemName: imageString)
                .resizable()
                .scaledToFit()
                .frame(height: 50)
                .foregroundStyle(.brandPrimary)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(titleInfo)
                    .bold()
                
                Text(descriptionInfo)
                    .foregroundStyle(.secondary)
                    .font(.headline)
                    .lineLimit(2)
                    .minimumScaleFactor(0.75)
            }
        }
    }
}
