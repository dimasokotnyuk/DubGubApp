//
//  LocationCell.swift
//  DubDubGrub
//
//  Created by Дмитро Сокотнюк on 17.07.2025.
//

import SwiftUI

struct LocationCell: View {
    var body: some View {
        HStack {
            Image(.defaultSquareAsset)
                .resizable()
                .scaledToFit()
                .frame(height: 80)
                .clipShape(.circle)
                .padding(.vertical, 8)
            
            VStack(alignment: .leading){
                Text("Test Location Name")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
                
                HStack {
                    AvatarView(size: 35)
                    AvatarView(size: 35)
                    AvatarView(size: 35)
                    AvatarView(size: 35)
                    AvatarView(size: 35)
                }
            }
            .padding(.leading, 8)
        }
    }
}

#Preview {
    LocationCell()
}
