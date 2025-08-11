//
//  MockData.swift
//  DubDubGrub
//
//  Created by Дмитро Сокотнюк on 18.07.2025.
//

import Foundation
import CloudKit

struct MockData {
    static var location: CKRecord {
        let record = CKRecord(recordType: RecordType.location)
        record[DDGLocation.kName]           = "Dmytro's Bar and Grill"
        record[DDGLocation.kAddress]        = "123 Main St, Anytown, USA"
        record[DDGLocation.kDescription]    = "The best bar in town!"
        record[DDGLocation.kWebsiteURL]     = "https://www.google.com"
        record[DDGLocation.kLocation]       = CLLocation(latitude: 33.3315165, longitude: -121.891054)
        record[DDGLocation.kPhoneNumber]    = "123-456-7890"
        return record
    }
    
    static var profile: CKRecord {
        let record = CKRecord(recordType: RecordType.profile)
        record[DDGProfile.kFirstName]   = "Dmytro"
        record[DDGProfile.kLastName]    = "Sokotniuk"
        record[DDGProfile.kBio]         = "It's my test bio. Just kidding... I'm a developer."
        record[DDGProfile.kCompanyName] = "Test Company Name"
        return record
    }
}
