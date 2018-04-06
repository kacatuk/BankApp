//
//  BankDetailedViewController.swift
//  BankApp
//
//  Created by Vjatseslav Pokatsalov on 05/04/2018.
//  Copyright © 2018 VPTeam. All rights reserved.
//

import UIKit

class BankDetailedViewController: UIViewController {
    
    var bank: BankEntity!
    
    fileprivate let titlesAndKeypaths: [[(title: String, keyPath: KeyPath<BankEntity, String?>) ]] = [
        [("Type", \.typeString), ("Name", \.name), ("Address", \.address), ("Region", \.region)],
        [("Availability", \.availability), ("Info", \.info)]
    ]

    let tableView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = bank.name
        self.view.addSubview(tableView)
        self.view.backgroundColor = .lightGray
        configureTableView()
        placeSubviews()
        
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(BankDetailedTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.allowsSelection = false
        tableView.bounces = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.layer.shadowColor = UIColor.darkGray.cgColor
        tableView.layer.shadowOpacity = 1.0
        tableView.layer.shadowOffset = .zero
    }

    private func placeSubviews() {
        tableView.layoutInSuperView()
    }
}

extension BankDetailedViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return titlesAndKeypaths.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titlesAndKeypaths[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! BankDetailedTableViewCell
        let titleAndKeypath = titlesAndKeypaths[indexPath.section][indexPath.row]
        let title = titleAndKeypath.title
        cell.textLabel?.text = title.uppercased()
        let value = bank[keyPath: titleAndKeypath.keyPath]
        cell.detailTextLabel?.text = value ?? "Not defined"
        cell.separator.backgroundColor = .lightGray
        let cellIsLast = tableView.numberOfRows(inSection: indexPath.section) - 1 == indexPath.item
        if cellIsLast {
            cell.separatorMultiplier = 0.0
        }else {
            cell.separatorMultiplier = 0.95
        }
        
        return cell
    }
}
