//
//  BankEntity+CoreDataProperties.swift
//  BankApp
//
//  Created by Vjatseslav Pokatsalov on 06/04/2018.
//  Copyright © 2018 VPTeam. All rights reserved.
//
//

import Foundation
import CoreData


extension BankEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BankEntity> {
        return NSFetchRequest<BankEntity>(entityName: "BankEntity")
    }

    @NSManaged public var address: String?
    @NSManaged public var availability: String?
    @NSManaged public var info: String?
    @NSManaged public var name: String?
    @NSManaged public var region: String?
    @NSManaged public var typeIndex: Int16

}
