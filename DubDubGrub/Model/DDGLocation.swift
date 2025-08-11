//
//  DDGLocation.swift
//  DubDubGrub
//
//  Created by Дмитро Сокотнюк on 18.07.2025.
//

import Foundation
import CloudKit
import UIKit

struct DDGLocation: Identifiable, Hashable {
    
    static let kName        = "name"
    static let kDescription = "description"
    static let kSquareAsset = "squareAsset"
    static let kBannerAsset = "bannerAsset"
    static let kAddress     = "address"
    static let kPhoneNumber = "phoneNumber"
    static let kLocation    = "location"
    static let kWebsiteURL  = "websiteURL"
    
    let id: CKRecord.ID
    let name: String
    let description: String
    let squareAsset: CKAsset!
    let bannerAsset: CKAsset!
    let address: String
    let phoneNumber: String
    let location: CLLocation
    let websiteURL: String
    
    init(record: CKRecord) {
        id  = record.recordID
        name        = record[DDGLocation.kName] as? String ?? "N/A"
        description = record[DDGLocation.kDescription] as? String ?? "N/A"
        squareAsset = record[DDGLocation.kSquareAsset] as? CKAsset
        bannerAsset = record[DDGLocation.kBannerAsset] as? CKAsset
        address     = record[DDGLocation.kAddress] as? String ?? "N/A"
        phoneNumber = record[DDGLocation.kPhoneNumber] as? String ?? "N/A"
        location    = record[DDGLocation.kLocation] as? CLLocation ?? CLLocation(latitude: 0, longitude: 0)
        websiteURL  = record[DDGLocation.kWebsiteURL] as? String ?? "N/A"
    }
    
    
    var squareImage: UIImage {
        guard let asset = squareAsset else { return PlaceHolderImage.square }
        return asset.convertToUIImage(in: .square)
    }
    
    
    var bannerImage: UIImage {
        guard let asset = bannerAsset else { return PlaceHolderImage.banner }
        return asset.convertToUIImage(in: .banner)
    }
}
