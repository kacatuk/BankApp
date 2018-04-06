//
//  BanksListViewModel.swift
//  BankApp
//
//  Created by Vjatseslav Pokatsalov on 03/04/2018.
//  Copyright © 2018 VPTeam. All rights reserved.
//

import Foundation


class BanksListViewModel {
    
    let country: Country 
    let region: String
    var banksCount: Int { return banks.count }
    weak var delegate: TableViewModelDelegate?
    
    private var banks: [BankEntity]
    
    init(country: Country, region: String) {
        self.country = country
        self.region = region
        self.banks = []
        self.getBanks()
    }
    
    func addressForBank(atIndex index: Int) -> String {
        return banks[index].address ?? "Not defined"
    }
    
    func nameForBank(atIndex index: Int) -> String{
        return banks[index].name ?? "Not defined"
    }
    
    func bank(atIndex index: Int) -> BankEntity {
        return banks[index]
    }
    
    private func getBanks() {
        self.banks = BankService.instance.listForCountry(country)?.getBanksForRegion(region) ?? []
        delegate?.didUpdateContent()
    }
}

