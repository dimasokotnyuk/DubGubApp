//
//  DetailLocationView.swift
//  DubDubGrub
//
//  Created by Дмитро Сокотнюк on 17.07.2025.
//

import SwiftUI

struct LocationDetailView: View {
    
    @Bindable var viewModel: LocationDetailViewModel
    
    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                BannerImageView(image: viewModel.location.bannerImage)
                AddressView(address: viewModel.location.address)
                DescriptionView(description: viewModel.location.description)
                ActionButtonHStack(viewModel: viewModel)
                
                Text("Who's Here?")
                    .bold()
                    .font(.title2)
                
                AvatarGridView(viewModel: viewModel)
            }
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity,
                   alignment: .top)
            
            if viewModel.isShowingProfileModel {
                FullScreenBlackTransparencyView()
                
                ProfileModalView(profile: viewModel.selectedProfile ?? DDGProfile(record: MockData.profile), isShowingProfileModal: $viewModel.isShowingProfileModel)
                    .id(UUID())
                    .transition(.asymmetric(
                        insertion: .move(edge: .leading).combined(with: .opacity),
                        removal: .move(edge: .trailing).combined(with: .opacity))
                    )
                    .zIndex(2)
            }
        }
        .task {
            viewModel.getCheckedInProfiles()
            viewModel.getCheckedInStatus()
        }
        .sheet(isPresented: $viewModel.isShowingProfileSheet) {
            if let profile = viewModel.selectedProfile {
                NavigationStack {
                    ProfileSheetView(profile: profile)
                        .toolbar {
                            Button {
                                viewModel.isShowingProfileSheet = false
                            } label: {
                                Label("Back", systemImage: "arrow.uturn.backward")
                            }
                        }
                }
            }
        }
        .alert(item: $viewModel.alertItem) { $0.alert }
        .navigationTitle(viewModel.location.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        LocationDetailView(viewModel: LocationDetailView.LocationDetailViewModel(location: DDGLocation.init(record: MockData.location)))
            .navigationTitle("Location name")
    }
}

fileprivate struct BannerImageView: View {
    let image: UIImage
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFill()
            .frame(height: 120)
    }
}

fileprivate struct AddressView: View {
    let address: String
    
    var body: some View {
        HStack {
            Label(address, systemImage: "mappin.and.ellipse")
                .font(.caption)
                .foregroundStyle(.secondary)
         
            Spacer()
        }
        .padding(.leading, 20)
    }
}

fileprivate struct DescriptionView: View {
    
    let description: String
    
    var body: some View {
        Text(description)
            .minimumScaleFactor(0.75)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.horizontal)
    }
}

fileprivate struct ActionButtonHStack: View {
    
    var viewModel: LocationDetailView.LocationDetailViewModel
    
    var body: some View {
        HStack(spacing: 20) {
            Button {
                viewModel.getDirectionsToLocation()
            } label: {
                LocationActionButton(iconName: "location.fill", color: .brandPrimary)
            }
            
            Link(destination: URL(string: viewModel.location.websiteURL)!, label: {
                LocationActionButton(iconName: "network", color: .brandPrimary)
            })
            
            Button {
                viewModel.callLocation()
            } label: {
                LocationActionButton(iconName: "phone.fill", color: .brandPrimary)
            }
            
            if let _ = CloudKitManager.shared.profileRecordID {
                Button {
                    viewModel.updateCheckInStatus(to: viewModel.isCheckedIn ? .checkedOut : .checkedIn)
                } label: {
                    LocationActionButton(iconName: viewModel.buttonImageTitile, color: viewModel.buttonColor)
                }
                .disabled(viewModel.isLoading)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .background(Color(.secondarySystemBackground))
        .clipShape(.capsule)
    }
}

fileprivate struct FullScreenBlackTransparencyView: View {
    var body: some View {
        Color(.systemBackground)
            .ignoresSafeArea()
            .opacity(0.8)
            .transition(AnyTransition.opacity.animation(.easeOut(duration: 0.35)))
            .zIndex(1)
    }
}

struct AvatarGridView: View {
    
    var viewModel: LocationDetailView.LocationDetailViewModel
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    var body: some View {
        ZStack {
            if viewModel.checkedInProfiles.isEmpty {
                ContentUnavailableView("Nobody's Here", systemImage: "person.slash", description: Text("Nobody has checked in yet."))
            } else {
                ScrollView {
                    LazyVGrid(columns: viewModel.determineColumns(for: dynamicTypeSize), content: {
                        ForEach(viewModel.checkedInProfiles) { profile in
                            FirstNameAvatarView(profile: profile)
                                .onTapGesture {
                                    withAnimation {
                                        viewModel.show(profile, in: dynamicTypeSize)
                                    }
                                }
                        }
                    })
                }
            }
            
            if viewModel.isLoading {
                LoadingView()
            }
        }
    }
}
