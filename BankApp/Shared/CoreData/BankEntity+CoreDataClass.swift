//
//  BankEntity+CoreDataClass.swift
//  BankApp
//
//  Created by Vjatseslav Pokatsalov on 06/04/2018.
//  Copyright © 2018 VPTeam. All rights reserved.
//
//

import Foundation
import CoreData

@objc(BankEntity)
public class BankEntity: NSManagedObject {
    
    var typeString: String? {
        return BankType.typeWithIndex(Int(typeIndex))?.description
    }
    
    func fillFromObject(_ object: AnyObject) throws {
        let address = object.value(forKeyPath: DecodingMap.address.stringValue) as? String
        let region = object.value(forKeyPath: DecodingMap.region.stringValue) as? String
        let name = object.value(forKeyPath: DecodingMap.name.stringValue) as? String
        
        self.availability = object.value(forKeyPath: DecodingMap.availability.stringValue) as? String ?? "Not defined"
        self.info = object.value(forKeyPath: DecodingMap.info.stringValue) as? String ?? ""
        
        self.typeIndex = object.value(forKeyPath: DecodingMap.type.stringValue) as? Int16 ?? -1
        
        if address != nil, region != nil, name != nil {
            self.address = address!
            self.region = region!
            self.name = name!
        }else {
            throw NSError(domain: "Bank.init(object: AnyObject) failed for \(object)",
                code: 0, userInfo: nil)
        }
    }
    
    private enum DecodingMap: String, CodingKey {
        case address = "a"
        case region = "r"
        case name = "n"
        case type = "t"
        case availability = "av"
        case info = "i"
    }
}
