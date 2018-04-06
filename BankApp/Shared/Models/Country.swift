//
//  Country.swift
//  BankApp
//
//  Created by Vjatseslav Pokatsalov on 04/04/2018.
//  Copyright © 2018 VPTeam. All rights reserved.
//

import Foundation


enum Country: String {
    case Estonia = "Estonia"
    case Latvia = "Latvia"
    case Lithuania = "Lithuania"
    
    func getUrl() -> String {
        switch self {
        case .Estonia: return "https://www.swedbank.ee/finder.json"
        case .Latvia: return "https://ib.swedbank.lv/finder.json"
        case .Lithuania: return "https://ib.swedbank.lt/finder.json"
        }
    }
    
    static var array: [Country] {
        return [.Estonia, .Latvia, .Lithuania].sorted(by: { $0.rawValue < $1.rawValue })
    }
}
