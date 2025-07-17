//
//  ProfileView.swift
//  DubDubGrub
//
//  Created by Дмитро Сокотнюк on 15.07.2025.
//

import SwiftUI

struct ProfileView: View {
    @State var firstName: String    = ""
    @State var lastName: String     = ""
    @State var companyName: String  = ""
    @State var bio: String          = ""
    let limitBio = 100
    
    var body: some View {
        VStack {
            ZStack {
                NameBackgroundView()
                
                HStack() {
                    ZStack {
                        AvatarView(size: 84)
                        EditImage()
                    }
                    .padding(.horizontal, 12)
                    
                    VStack(spacing: 1) {
                        TextField("First Name", text: $firstName)
                            .modifier(ProfileNameText())
                        
                        TextField("Last Name", text: $lastName)
                            .modifier(ProfileNameText())
                        
                        TextField("Company Name", text: $companyName)
                    }
                    .padding(.trailing, 16)
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
            
            VStack(alignment: .leading) {
                CharactersRemainView(currentCount: bio.count, limitBio: limitBio)
                
                TextEditor(text: $bio)
                    .onChange(of: bio) {
                        if bio.count > limitBio {
                            bio = String(bio.prefix(limitBio))
                        }
                    }
                    .frame(height: 100)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(.secondary, lineWidth: 1))
            }
            .padding()
            
            Spacer()
            
            Button {
                
            } label: {
                Text("Create Profile")
            }
            .modifier(ButtonStyle())
            .padding(.bottom, 20)
        }
        .navigationTitle("Profile")
    }
}

#Preview {
    NavigationStack {
        ProfileView()
    }
}

struct NameBackgroundView: View {
    var body: some View {
        Color(.secondarySystemBackground)
            .frame(height: 120)
            .cornerRadius(12)
            .padding(.horizontal)
    }
}

struct EditImage: View {
    var body: some View {
        Image(systemName: "square.and.pencil")
            .resizable()
            .scaledToFit()
            .frame(height: 14)
            .foregroundStyle(.white)
            .offset(y: 30)
    }
}

struct CharactersRemainView: View {
    var currentCount: Int
    let limitBio: Int
    
    var body: some View {
        Text("Bio: ")
            .font(.caption)
            .foregroundStyle(.secondary)
        +
        Text("\(limitBio - currentCount)")
            .font(.caption)
            .foregroundStyle(currentCount == limitBio ? .red : .brandPrimary)
            .fontWeight(.bold)
        +
        Text(" characters remain")
            .font(.caption)
            .foregroundStyle(.secondary)
    }
}
