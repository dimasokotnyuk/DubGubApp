//
//  Constants.swift
//  DubDubGrub
//
//  Created by Дмитро Сокотнюк on 18.07.2025.
//

import Foundation
import UIKit

enum RecordType {
    static let location = "DDGLocation"
    static let profile = "DDGProfile"
}

enum PlaceHolderImage {
    static let avatar = UIImage(resource: .defaultAvatar)
    static let square = UIImage(resource: .defaultSquareAsset)
    static let banner = UIImage(resource: .defaultBannerAsset)
}

enum ImageDimension {
    case square, banner
    
    var placeholder: UIImage {
        switch self {
        case .square:
            return PlaceHolderImage.square
        case .banner:
            return PlaceHolderImage.banner
        }
    }
}

enum DeviceType {
    enum ScreenSize {
        static let width        = UIScreen.main.bounds.size.width
        static let height       = UIScreen.main.bounds.size.height
        static let maxLength    = max(ScreenSize.width, ScreenSize.height)
    }
    
    static let idiom            = UIDevice.current.userInterfaceIdiom
    static let nativeScale      = UIScreen.main.nativeScale
    static let scale            = UIScreen.main.scale
    
    static let isiPhone12Mini   = idiom == .phone && ScreenSize.maxLength == 812
}

