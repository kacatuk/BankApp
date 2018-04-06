//
//  BankListViewModel.swift
//  BankApp
//
//  Created by Vjatseslav Pokatsalov on 03/04/2018.
//  Copyright © 2018 VPTeam. All rights reserved.
//

import Foundation

protocol TableViewModelDelegate: class {
    func didUpdateContent()
    func beginLoadinAnimation()
}
extension TableViewModelDelegate {
    func beginLoadinAnimation() {}
}

class RegionsListViewModel {
    
    weak var delegate: TableViewModelDelegate?
    
    private var regionsByCountries: [Country: [String]]  = [:] {
        didSet {
            delegate?.didUpdateContent()
        }
    }
    
    var numberOfCountries: Int { return regionsByCountries.count }
    
    func numberOfRegionsForCountry(_ countryIndex: Int) -> Int {
        return regionsByCountries[Country.array[countryIndex]]?.count ?? 0
    }
    
    func countryName(forIndex index: Int) -> String {
        return Country.array[index].rawValue
    }
    
    func regionTitle(forIndexPath indexPath: IndexPath) -> String {
        let country = Country.array[indexPath.section]
        return regionsByCountries[country]?[indexPath.row] ?? "Not found"
    }
    
    func subscribeOnBankService() {
        BankService.instance.delegate = self
        updateRegionsByCountriesList()
        delegate?.didUpdateContent()
    }
    
    func prepareBankListViewModel(forSelectedIndexPath indexPath: IndexPath) -> BanksListViewModel{
        let country = Country.array[indexPath.section]
        let region = regionTitle(forIndexPath: indexPath)
        return BanksListViewModel(country: country, region: region)
    }
    
    private func updateRegionsByCountriesList() {
        var regionsByCoutries: [Country: [String]] = [:]
        for country in Country.array {
            regionsByCoutries[country] = BankService.instance.listForCountry(country)?.regions ?? []
        }
        self.regionsByCountries = regionsByCoutries
    }
    
}

extension RegionsListViewModel: BankServiceDelegate {
    func banksListDidUpdate() {
        self.updateRegionsByCountriesList()
    }
    
    func didBeginDataLoading() {
        delegate?.beginLoadinAnimation()
    }
}
