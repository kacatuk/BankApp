//
//  BankService.swift
//  BankApp
//
//  Created by Vjatseslav Pokatsalov on 03/04/2018.
//  Copyright © 2018 VPTeam. All rights reserved.
//

import Foundation
import CoreData
import UIKit

protocol BankServiceDelegate: class {
    func banksListDidUpdate()
    func didBeginDataLoading()
}
extension BankServiceDelegate {
    func didBeginDataLoading(){}
}

class BankService {
    
    private(set) var bankListEntities: [BankListEntity] = [] {
        didSet {
            print(bankListEntities.count)
            delegate?.banksListDidUpdate()
        }
    }
    
    static let instance = BankService()
    
    weak var delegate: BankServiceDelegate?
    
    
    func loadBanksForAllCountries() {
        Country.array.forEach({ requestBankList(forCountry: $0) })
    }
    
    func listForCountry(_ country: Country) -> BankListEntity? {
        return bankListEntities.first(where: { ($0.country ?? "") == country.rawValue})
    }
    
    private var managedObjectContext: NSManagedObjectContext? {
        let persistance = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
        return persistance?.viewContext
    }
    
    
    private init() {
        fetchBankLists()
        Timer.scheduledTimer(withTimeInterval: (60 * 60), repeats: true, block: { [weak self] timer in
            if self == nil {
                timer.invalidate()
            }else {
                self!.loadBanksForAllCountries()
            }
        })
    }
    
    private func requestBankList(forCountry country: Country) {
        guard let url = URL(string: country.getUrl()) else { return }
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.setValue("Swedbank-Embedded=iphone-app", forHTTPHeaderField: "Cookie")
        let task = session.dataTask(with: request) {[weak self] data, response, error in
            if let error = error {
                print("Error caught: \(error)")
                return
            }
            guard let response = response as? HTTPURLResponse else {
                return
            }
            guard response.statusCode >= 200 && response.statusCode <= 299 else {
                print("Status code is note in 2**")
                return
            }
            guard let data = data else {
                print("Data is nil")
                return
            }
            var bankEntities: [BankEntity] = []
            DispatchQueue.main.async {
                if let objectsArray = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [AnyObject] {
                    bankEntities = self?.bankEntitiesFromAnyobjects(objectsArray) ?? []
                }else {
                    bankEntities = []
                }
                self?.exportBanksToCoredata(bankEntities, forCountry: country)
            }
        }
        delegate?.didBeginDataLoading()
        task.resume()
    }
    
    private func exportBanksToCoredata(_ banks: [BankEntity], forCountry country: Country) {
        if let listEntity = self.bankListEntities.first(where: { $0.country == country.rawValue }){
            listEntity.banks = banks
        }else {
            guard let moc = managedObjectContext else { return }
            guard let entity = NSEntityDescription.entity(forEntityName: "BankListEntity", in: moc) else { return }
            let bankList = BankListEntity(entity: entity, insertInto: moc)
            bankList.country = country.rawValue
            bankList.banks = banks
            self.bankListEntities.append(bankList)
        }
        do {
            try managedObjectContext?.save()
        }catch {
            print("Can't save changes in context")
        }
    }
    
    private func fetchBankLists() {
        guard let context = managedObjectContext else { return }
        let fetchRequest = NSFetchRequest<BankListEntity>.init(entityName: "BankListEntity")
        self.bankListEntities = []
        if let bankListEntities = try? context.fetch(fetchRequest) {
            for listEntity in bankListEntities {
                if !Country.array.map({ $0.rawValue }).contains(listEntity.country ?? "") {
                    context.delete(listEntity)
                }else {
                    self.bankListEntities.append(listEntity)
                }
            }
            do {
                try context.save()
            }catch {
                print("BankService.fetchBankLists() can't save context")
            }
        }
    }
    
    
    private func bankEntitiesFromAnyobjects(_ anyObjectArray: [AnyObject]) -> [BankEntity]{
        guard let context = managedObjectContext else { return []}
        guard let entity = NSEntityDescription.entity(forEntityName: "BankEntity", in: context) else {
            return []
        }
        var banks: [BankEntity] = []
        for object in anyObjectArray {
            let bank = BankEntity(entity: entity, insertInto: context)
            do {
                try bank.fillFromObject(object)
                banks.append(bank)
            }catch {
                context.delete(bank)
                print("Unable to fill entity", error)
            }
        }
        print("Banks array: \(banks.count)")
        return banks
    }
    
}
