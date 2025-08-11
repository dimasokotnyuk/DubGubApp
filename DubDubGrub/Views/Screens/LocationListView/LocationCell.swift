//
//  LocationCell.swift
//  DubDubGrub
//
//  Created by Дмитро Сокотнюк on 17.07.2025.
//

import SwiftUI

struct LocationCell: View {
    
    var location: DDGLocation
    var profiles: [DDGProfile]
    
    var body: some View {
        HStack {
            Image(uiImage: location.squareImage)
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
                
                if profiles.isEmpty {
                    Text("Nobody's Checked In")
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)
                        .padding(.top, 0.5)
                } else {
                    HStack {
                        ForEach(profiles.indices, id: \.self) { index in
                            if index <= 3 || (index == 4 && profiles.count == 5){
                                AvatarView(image: profiles[index].avatarImage, size: 35)
                            } else if index == 4 {
                                AdditionalProfilesView(number: min(profiles.count - 4, 99))
                            }
                        }
                    }
                }
            }
            .padding(.leading, 8)
        }
    }
}

#Preview {
    LocationCell(location: DDGLocation(record: MockData.location), profiles: [])
        .environmentObject(LocationManager()) 
}

fileprivate struct AdditionalProfilesView: View {
    
    var number: Int
    
    var body: some View {
        Text("+\(number)")
            .font(.system(size: 14, weight: .semibold))
            .frame(width: 35, height: 35)
            .foregroundColor(.white)
            .background(.brandPrimary)
            .clipShape(.circle)
    }
}
