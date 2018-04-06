//
//  BankListEntity+CoreDataClass.swift
//  BankApp
//
//  Created by Vjatseslav Pokatsalov on 06/04/2018.
//  Copyright © 2018 VPTeam. All rights reserved.
//
//

import Foundation
import CoreData

@objc(BankListEntity)
public class BankListEntity: NSManagedObject {
    
    var banks: [BankEntity] {
        get {
            if let banksEntities = self.banksEntity {
                return (Array(banksEntities) as? [BankEntity]) ?? []
            }else {
                return []
            }
        }
        set {
            self.banksEntity = NSOrderedSet(array: newValue)
        }
    }
    
    var regions: [String] {
        return Array(Set(banks.map({ $0.region}).filter({ $0 != nil }) as! [String])).sorted()
    }
    
    var regionsCoutnt: Int { return regions.count }
    
    func getBanksForRegion(_ region: String) -> [BankEntity] {
        return banks.filter({ $0.region == region })
    }
    
}
