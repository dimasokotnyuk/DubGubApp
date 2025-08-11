//
//  UIImage+Ext.swift
//  DubDubGrub
//
//  Created by Дмитро Сокотнюк on 20.07.2025.
//

import CloudKit
import UIKit

extension UIImage {
    
    func convertToCKAsset() -> CKAsset? {
        
        guard let urlPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        let fileURl = urlPath.appendingPathComponent("selectedAvatarImage")
        
        guard let imageData = jpegData(compressionQuality: 0.25) else {
            return nil
        }
        
        do {
            try imageData.write(to: fileURl)
            return CKAsset(fileURL: fileURl)
        } catch {
            return nil
        }
    }
}
