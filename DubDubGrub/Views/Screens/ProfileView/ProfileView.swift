//
//  ProfileView.swift
//  DubDubGrub
//
//  Created by Дмитро Сокотнюк on 15.07.2025.
//

import SwiftUI
import PhotosUI
import CloudKit

enum ProfileTextField {
    case firstName, lastName, companyName, bio
}

struct ProfileView: View {
    
    @State private var viewModel = ProfileViewModel()
    @FocusState private var focusedTextField: ProfileTextField?
    
    var body: some View {
        ZStack {
            VStack {
                HStack() {
                    ProfileImageView(avatar: $viewModel.avatar, selectedImage: $viewModel.selectedImage)
                    
                    VStack(spacing: 1) {
                        TextField("First Name", text: $viewModel.firstName)
                            .modifier(ProfileNameText())
                            .focused($focusedTextField, equals: .firstName)
                            .onSubmit {
                                focusedTextField = .lastName
                            }
                            .submitLabel(.next)
                            .padding(.trailing, 28)
                            .overlay(alignment: .trailing) {
                                if !viewModel.firstName.isEmpty {
                                    Image(systemName: "checkmark.circle")
                                        .foregroundStyle(.green)
                                        .padding(.trailing, 6)
                                }
                            }
                        
                        TextField("Last Name", text: $viewModel.lastName)
                            .modifier(ProfileNameText())
                            .focused($focusedTextField, equals: .lastName)
                            .onSubmit {
                                focusedTextField = .companyName
                            }
                            .submitLabel(.next)
                            .padding(.trailing, 28)
                            .overlay(alignment: .trailing) {
                                if !viewModel.lastName.isEmpty {
                                    Image(systemName: "checkmark.circle")
                                        .foregroundStyle(.green)
                                        .padding(.trailing, 6)
                                }
                            }
                        
                        TextField("Company Name", text: $viewModel.companyName)
                            .focused($focusedTextField, equals: .companyName)
                            .onSubmit {
                                focusedTextField = .bio
                            }
                            .submitLabel(.next)
                            .padding(.trailing, 28)
                            .overlay(alignment: .trailing) {
                                if !viewModel.companyName.isEmpty {
                                    Image(systemName: "checkmark.circle")
                                        .foregroundStyle(.green)
                                        .padding(.trailing, 6)
                                }
                            }
                    }
                    .padding(.trailing, 16)
                    
                    Spacer()
                }
                .padding(.vertical)
                .background(Color(.secondarySystemBackground))
                .clipShape(.rect(cornerRadius: 12))
                .padding(.horizontal)
                
                VStack(alignment: .leading) {
                    HStack {
                        CharactersRemainView(currentCount: viewModel.bio.count, limitBio: viewModel.limitBio)
                        
                        Spacer()
                        
                        if viewModel.isCheckedIn {
                            Button {
                                viewModel.checkOut()
                            } label: {
                                CheckOutButton()
                            }
                            .disabled(viewModel.isLoading)
                        }
                    }
                    
                    TextField("", text: $viewModel.bio, axis: .vertical).focused($focusedTextField, equals: .bio)
                    //                        .frame(height: 100)
                        .padding()
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(viewModel.bioStrokeColor, lineWidth: 1)
                        }
                }
                .padding()
                
                Spacer()
                
                Button {
                    viewModel.determineButtonAction()
                } label: {
                    Text(viewModel.titleButton)
                }
                .padding(.bottom, 20)
                .modifier(ButtonStyle())
                .disabled(!viewModel.isValidProfile())
            }
            
            if viewModel.isLoading { LoadingView() }
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(DeviceType.isiPhone12Mini ? .inline : .automatic)
        .ignoresSafeArea(.keyboard)
        .task {
            viewModel.getProfile()
            viewModel.getCheckedInStatus()
        }
        .alert(item: $viewModel.alertItem) { $0.alert }
        .toolbar {
            if focusedTextField != nil {
                Button {
                    focusedTextField = nil
                } label: {
                    Image(systemName: "keyboard.chevron.compact.down")
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


fileprivate struct ProfileImageView: View {
    @Binding var avatar: UIImage
    @Binding var selectedImage: PhotosPickerItem?
    
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

fileprivate struct CheckOutButton: View {
    var body: some View {
        Label("Check out", systemImage: "mappin.and.ellipse")
            .font(.system(size: 12, weight: .semibold))
            .foregroundStyle(.white)
            .padding(10)
            .frame(height: 28)
            .background(.red)
            .cornerRadius(8)
    }
}
