//
//  BankType.swift
//  BankApp
//
//  Created by Vjatseslav Pokatsalov on 05/04/2018.
//  Copyright © 2018 VPTeam. All rights reserved.
//

import Foundation

enum BankType {
    
    case Branch
    case ATM
    case BNA
    
    static var array: [BankType] { return [.Branch, .ATM, .BNA] }
    
    static func typeWithIndex(_ index: Int) -> BankType? {
        return array.first(where: { $0.hashValue == index })
    }
}

extension BankType: CustomStringConvertible {
    var description: String {
        switch self {
        case .Branch:
            return "Branch"
        case .ATM:
            return "Automated Teller Machine"
        case .BNA:
            return "Bunch Note Acceptor"
        }
    }
}
