//
//  Alert.swift
//  DubDubGrub
//
//  Created by Дмитро Сокотнюк on 18.07.2025.
//

import SwiftUI

struct AlertItem: Identifiable{
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButtonText: Alert.Button
    
    var alert: Alert {
        Alert(title: title, message: message, dismissButton: dismissButtonText)
    }
}

struct AlertContext {
    //MARK: - MapView Errors
    static let unableToGetLocations             = AlertItem(title: Text("Locations Error"), message: Text("Unable to retrieve locations at this time.\n Please try again"), dismissButtonText: .default(Text("Ok")))
    
    static let locationRestricted               = AlertItem(title: Text("Locations Restricted"), message: Text("Your location is restricted. This may be due to parental controls."), dismissButtonText: .default(Text("Ok")))
    
    static let locationDenied                   = AlertItem(title: Text("Locations Denied"), message: Text("Dub Dub Grub does not have permission to access your location.\n Please go to Settings > Dub Dub Grub > Location"), dismissButtonText: .default(Text("Ok")))
    
    static let locationDisabled                 = AlertItem(title: Text("Locations Service Disabled"), message: Text("Your phone's location service is disabled.\n Please go to Settings > Privacy > Location Services"), dismissButtonText: .default(Text("Ok")))
    
    static let checkedInCount                   = AlertItem(title: Text("Server Error"), message: Text("Unable to get the number of people checked in to each location. Please check your internet connection and try again."), dismissButtonText: .default(Text("Ok")))
    
    //MARK: - ProfileView Errors
    static let invalidProfile                   = AlertItem(title: Text("Invalid Profile"), message: Text("All fields are required as a profile photo. Your bio must be < 100 characters. Please try again"), dismissButtonText: .default(Text("Ok")))
    
    static let noUserRecord                     = AlertItem(title: Text("No User Record"), message: Text("You must log into iCloud on your phone in ordre to utilize Dub Dub Grub's Profile. Please log in on your phone's settings screen."), dismissButtonText: .default(Text("Ok")))
    
    static let createProfileSuccess             = AlertItem(title: Text("Profile Created Successfully"), message: Text("Your profile has successfully been created."), dismissButtonText: .default(Text("Ok")))
    
    static let updateProfileSuccess             = AlertItem(title: Text("Profile Update Successfully"), message: Text("Your profile has successfully been Update."), dismissButtonText: .default(Text("Ok")))
    
    static let updateProfileFailure             = AlertItem(title: Text("Profile Update Failed"), message: Text("We were unable to update your profile at this time. Please try again later or contact customer support if this persists."), dismissButtonText: .default(Text("Ok")))
    
    static let createProfileFailure             = AlertItem(title: Text("Failed to Create Profile"), message: Text("We were unable to create your profile at this time. Please try again later or contact customer support if this persists."), dismissButtonText: .default(Text("Ok")))
    
    static let unableToGetProfile               = AlertItem(title: Text("Unable To Retrieve Profile"), message: Text("We were unable to retrieve your profile at this time. Please try again later or contact customer support if this persists."), dismissButtonText: .default(Text("Ok")))
    
    //MARK: - LocationDetailView Errors
    static let invalidPhoneNumber               = AlertItem(title: Text("Invalid Phone Number"), message: Text("The phone number for the location is invalid."), dismissButtonText: .default(Text("Ok")))
    
    static let unableToGetCheckInStatus         = AlertItem(title: Text("Server Error"), message: Text("Unable to retrieve checked in status of the current user. Please try again."), dismissButtonText: .default(Text("Ok")))
    
    static let unableToGetCheckedInProfiles     = AlertItem(title: Text("Server Error"), message: Text("We are unable to get users checked into this location at this time. Please try again."), dismissButtonText: .default(Text("Ok")))
    
    //MARK: - LocationListView Errors
    static let unableToGetAllCheckedInProfiles  = AlertItem(title: Text("Server Error"), message: Text("We are unable to get users checked into this location at this time. Please try again."), dismissButtonText: .default(Text("Ok")))
}
