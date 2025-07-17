//
//  DetailLocationView.swift
//  DubDubGrub
//
//  Created by Дмитро Сокотнюк on 17.07.2025.
//

import SwiftUI

struct LocationDetailView: View {
    var body: some View {
        VStack {
            Image(.defaultBannerAsset)
                .resizable()
                .scaledToFit()
            
            HStack {
                Image(systemName: "mappin.and.ellipse")
                
                Text("Test 1S Street St 40")
                
                Spacer()
            }
            .font(.subheadline)
            .padding(.leading, 20)
            .padding(.top, 10)
            .foregroundStyle(.secondary)
            
            Text("It's Test. Just Test")
            
            HStack {
                IconView(iconName: "paperplane.circle.fill", color: .brandPrimary)
                IconView(iconName: "paperplane.circle.fill", color: .brandPrimary)
                IconView(iconName: "paperplane.circle.fill", color: .brandPrimary)
                IconView(iconName: "paperplane.circle.fill", color: .red)
            }
            
            Text("Who's Here?")
                .font(.title)
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    LocationDetailView()
}

struct IconView: View {
    let iconName: String
    let color: Color
    
    var body: some View {
        Image(systemName: iconName)
            .resizable()
            .scaledToFit()
            .frame(height: 50)
            .foregroundStyle(color)
    }
}
