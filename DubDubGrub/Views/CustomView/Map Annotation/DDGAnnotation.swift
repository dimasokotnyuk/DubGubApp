//
//  DDGAnnotation.swift
//  DubDubGrub
//
//  Created by Дмитро Сокотнюк on 23.07.2025.
//

import SwiftUI

struct DDGAnnotation: View {
    
    var location: DDGLocation
    var count: Int
    
    var body: some View {
        VStack {
            ZStack {
                MapBalloon()
                    .fill(.brandPrimary.gradient)
                    .frame(width: 100, height: 70)
                
                Image(uiImage: location.squareImage)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(.circle)
                    .offset(y: -10)
                
                if count != 0 {
                    Text("\(min(count, 99))")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 26, height: 18)
                        .background(.red)
                        .clipShape(.capsule)
                        .offset(x: 20, y: -25)
                }
            }
            
            Text(location.name)
                .font(.caption)
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    DDGAnnotation(location: DDGLocation(record: MockData.location), count: 1220)
}
