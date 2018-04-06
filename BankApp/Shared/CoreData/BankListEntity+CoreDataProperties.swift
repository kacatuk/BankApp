//
//  BankListEntity+CoreDataProperties.swift
//  BankApp
//
//  Created by Vjatseslav Pokatsalov on 06/04/2018.
//  Copyright © 2018 VPTeam. All rights reserved.
//
//

import Foundation
import CoreData


extension BankListEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BankListEntity> {
        return NSFetchRequest<BankListEntity>(entityName: "BankListEntity")
    }

    @NSManaged public var country: String?
    @NSManaged public var banksEntity: NSOrderedSet?

}

// MARK: Generated accessors for banksEntity
extension BankListEntity {

    @objc(insertObject:inBanksEntityAtIndex:)
    @NSManaged public func insertIntoBanksEntity(_ value: BankEntity, at idx: Int)

    @objc(removeObjectFromBanksEntityAtIndex:)
    @NSManaged public func removeFromBanksEntity(at idx: Int)

    @objc(insertBanksEntity:atIndexes:)
    @NSManaged public func insertIntoBanksEntity(_ values: [BankEntity], at indexes: NSIndexSet)

    @objc(removeBanksEntityAtIndexes:)
    @NSManaged public func removeFromBanksEntity(at indexes: NSIndexSet)

    @objc(replaceObjectInBanksEntityAtIndex:withObject:)
    @NSManaged public func replaceBanksEntity(at idx: Int, with value: BankEntity)

    @objc(replaceBanksEntityAtIndexes:withBanksEntity:)
    @NSManaged public func replaceBanksEntity(at indexes: NSIndexSet, with values: [BankEntity])

    @objc(addBanksEntityObject:)
    @NSManaged public func addToBanksEntity(_ value: BankEntity)

    @objc(removeBanksEntityObject:)
    @NSManaged public func removeFromBanksEntity(_ value: BankEntity)

    @objc(addBanksEntity:)
    @NSManaged public func addToBanksEntity(_ values: NSOrderedSet)

    @objc(removeBanksEntity:)
    @NSManaged public func removeFromBanksEntity(_ values: NSOrderedSet)

}
