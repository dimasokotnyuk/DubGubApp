//
//  DetailLocationView.swift
//  DubDubGrub
//
//  Created by Дмитро Сокотнюк on 17.07.2025.
//

import SwiftUI

struct LocationDetailView: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack(spacing: 16) {
            BannerImageView(imageName: .defaultBannerAsset)
            
            HStack {
                AddressView(address: "123 Main Street, Anytown, USA")
                
                Spacer()
            }
            .padding(.leading, 20)
            
            DescriptionView(description: "This is a test description. This is a test description. This is a test description. This is a test description. This is a test description.")
            
            ZStack {
                Capsule()
                    .frame(height: 80)
                    .foregroundStyle(Color(.secondarySystemBackground))
                HStack(spacing: 20) {
                    Button {
                        
                    } label: {
                        LocationActionButton(iconName: "location.fill", color: .brandPrimary)
                    }
                    
                    Link(destination: URL(string: "https://www.apple.com")!, label: {
                        LocationActionButton(iconName: "network", color: .brandPrimary)
                    })
                    
                    Button {
                        
                    } label: {
                        LocationActionButton(iconName: "phone.fill", color: .brandPrimary)
                    }
                    
                    Button {
                        
                    } label: {
                        LocationActionButton(iconName: "person.fill.checkmark", color: .red)
                    }
                }
            }
            .padding(.horizontal)
            
            Text("Who's Here?")
                .bold()
                .font(.title2)
            
            ScrollView {
                LazyVGrid(columns: columns, content: {
                    FirstNameAvatarView(name: "Name")
                    FirstNameAvatarView(name: "Name")
                    FirstNameAvatarView(name: "Name")
                    FirstNameAvatarView(name: "Name")
                    FirstNameAvatarView(name: "Name")
                    FirstNameAvatarView(name: "Name")
                    FirstNameAvatarView(name: "Name")
                    FirstNameAvatarView(name: "Name")
                })
            }
            
            Spacer()
        }
        .navigationTitle("Location Name")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        LocationDetailView()
            .navigationTitle("Location name")
    }
}

struct BannerImageView: View {
    let imageName: ImageResource
    
    var body: some View {
        Image(.defaultBannerAsset)
            .resizable()
            .scaledToFill()
            .frame(height: 120)
    }
}

struct AddressView: View {
    let address: String
    
    var body: some View {
        Label(address, systemImage: "mappin.and.ellipse")
            .font(.caption)
            .foregroundStyle(.secondary)
    }
}

struct DescriptionView: View {
    
    let description: String
    
    var body: some View {
        Text(description)
            .lineLimit(3)
            .minimumScaleFactor(0.75)
            .padding(.horizontal)
    }
}
