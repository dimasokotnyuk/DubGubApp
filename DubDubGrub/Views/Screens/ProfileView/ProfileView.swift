//
//  ProfileView.swift
//  DubDubGrub
//
//  Created by Дмитро Сокотнюк on 15.07.2025.
//

import SwiftUI
import PhotosUI
import CloudKit

struct ProfileView: View {
    @State private var firstName: String    = ""
    @State private var lastName: String     = ""
    @State private var companyName: String  = ""
    @State private var bio: String          = ""
    @State private var avatar               = PlaceHolderImage.avatar
    @State private var alertItem: AlertItem?
    let limitBio = 100
    @FocusState private var nameIsFocused: Bool
    
    var body: some View {
        VStack {
            ZStack {
                NameBackgroundView()
                
                HStack() {
                    ProfileImageView(avatar: $avatar)
                    
                    VStack(spacing: 1) {
                        TextField("First Name", text: $firstName)
                            .modifier(ProfileNameText())
                            .focused($nameIsFocused)
                            .padding(.trailing, 28)
                            .overlay(alignment: .trailing) {
                                if !firstName.isEmpty {
                                    Image(systemName: "checkmark.circle")
                                        .foregroundStyle(.green)
                                        .padding(.trailing, 6)
                                }
                            }
                        
                        TextField("Last Name", text: $lastName)
                            .modifier(ProfileNameText())
                            .focused($nameIsFocused)
                            .padding(.trailing, 28)
                            .overlay(alignment: .trailing) {
                                if !lastName.isEmpty {
                                    Image(systemName: "checkmark.circle")
                                        .foregroundStyle(.green)
                                        .padding(.trailing, 6)
                                }
                            }
                        
                        TextField("Company Name", text: $companyName)
                            .focused($nameIsFocused)
                            .padding(.trailing, 28)
                            .overlay(alignment: .trailing) {
                                if !companyName.isEmpty {
                                    Image(systemName: "checkmark.circle")
                                        .foregroundStyle(.green)
                                        .padding(.trailing, 6)
                                }
                            }
                    }
                    .padding(.trailing, 16)
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
            
            VStack(alignment: .leading) {
                CharactersRemainView(currentCount: bio.count, limitBio: limitBio)
                
                TextEditor(text: $bio)
                    .focused($nameIsFocused)
                    .onChange(of: bio) {
                        if bio.count > limitBio {
                            bio = String(bio.prefix(limitBio))
                        }
                    }
                    .frame(height: 100)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(!bio.isEmpty ? Color.green : Color.secondary, lineWidth: 1))
                
            }
            .padding()
            
            Spacer()
            
            Button {
//                createProfile()
            } label: {
                Text("Create Profile")
            }
            .modifier(ButtonStyle())
            .padding(.bottom, 20)
            .disabled(!isValidProfile())
        }
        .navigationTitle("Profile")
        .onAppear {
            getProfile()
        }
        .alert(item: $alertItem) { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButtonText)
        }
        .toolbar {
            if nameIsFocused {
                Button {
                    //                dismissKeyboard()
                    nameIsFocused = false
                } label: {
                    Image(systemName: "keyboard.chevron.compact.down")
                }
            }
        }
    }
    
    func isValidProfile() -> Bool {
        guard !firstName.isEmpty,
              !lastName.isEmpty,
              !companyName.isEmpty,
              !bio.isEmpty,
              avatar != PlaceHolderImage.avatar,
              bio.count < limitBio else {
            return false
        }
        
        return true
    }
    
    func createProfile() {
        guard isValidProfile() else {
            return
        }
        
        let profileRecord = CKRecord(recordType: RecordType.profile)
        profileRecord[DDGProfile.kFirstName] = firstName
        profileRecord[DDGProfile.kLastName] = lastName
        profileRecord[DDGProfile.kCompanyName] = companyName
        profileRecord[DDGProfile.kBio] = bio
        profileRecord[DDGProfile.kAvatar] = avatar.convertToCKAsset()
        
        CKContainer.default().fetchUserRecordID { recordID, error in
            guard let recordID, error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            CKContainer.default().publicCloudDatabase.fetch(withRecordID: recordID) { userRecord, error in
                guard let userRecord, error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                
                userRecord["userProfile"] = CKRecord.Reference(recordID: profileRecord.recordID, action: .none)
                
                let operation = CKModifyRecordsOperation(recordsToSave: [userRecord, profileRecord])
                operation.modifyRecordsCompletionBlock = { savedRecords, _, error in
                    guard let savedRecords, error == nil else {
                        print(error!.localizedDescription)
                        return
                    }
                    
                    print(savedRecords)
                }
                
                CKContainer.default().publicCloudDatabase.add(operation)
            }
        }
    }
    
    func getProfile() {
        CKContainer.default().fetchUserRecordID { recordID, error in
            guard let recordID, error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            CKContainer.default().publicCloudDatabase.fetch(withRecordID: recordID) { userRecord, error in
                guard let userRecord, error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                
                let profileReference = userRecord["userProfile"] as! CKRecord.Reference
                let profileRecordID = profileReference.recordID
                
                CKContainer.default().publicCloudDatabase.fetch(withRecordID: profileRecordID) { profileRecord, error in
                    guard let profileRecord, error == nil else {
                        print(error!.localizedDescription)
                        return
                    }
                    
                    DispatchQueue.main.async {
                        let profile = DDGProfile(record: profileRecord)
                        firstName = profile.firstName
                        lastName = profile.lastName
                        companyName = profile.companyName
                        bio = profile.bio
                        avatar = profile.createAvatarImage()
                    }
                }
            }
        }
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

struct ProfileImageView: View {
    @Binding var avatar: UIImage
    @State private var selectedImage: PhotosPickerItem?
    
    var body: some View {
        ZStack(alignment: .bottom) {
            AvatarView(image: avatar, size: 84)
                .padding(.horizontal, 4)
            
            PhotosPicker(selection: $selectedImage, matching: .images) {
                Image(systemName: "square.and.pencil")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 14)
                    .foregroundStyle(.white)
                    .padding(.bottom, 6)
            }
        }
        .padding(.leading, 12)
        .onChange(of: selectedImage) {
            Task {
                if let pickerItem = selectedImage, let data = try? await pickerItem.loadTransferable(type: Data.self) {
                    if let image = UIImage(data: data) {
                        self.avatar = image
                    }
                }
            }
        }
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
