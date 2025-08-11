//
//  LocationCell.swift
//  DubDubGrub
//
//  Created by Дмитро Сокотнюк on 17.07.2025.
//

import SwiftUI

struct LocationCell: View {
    
    var location: DDGLocation
    
    var body: some View {
        HStack {
            Image(uiImage: location.createSquareImage())
                .resizable()
                .scaledToFit()
                .frame(height: 80)
                .clipShape(.circle)
                .padding(.vertical, 8)
            
            VStack(alignment: .leading){
                Text(location.name)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
                
                HStack {
                    AvatarView(image: PlaceHolderImage.avatar, size: 35)
                    AvatarView(image: PlaceHolderImage.avatar, size: 35)
                    AvatarView(image: PlaceHolderImage.avatar, size: 35)
                    AvatarView(image: PlaceHolderImage.avatar, size: 35)
                    AvatarView(image: PlaceHolderImage.avatar, size: 35)
                }
            }
            .padding(.leading, 8)
        }
    }
}

#Preview {
    LocationCell(location: DDGLocation(record: MockData.location))
}
