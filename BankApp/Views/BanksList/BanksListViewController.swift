//
//  BanksListViewController.swift
//  BankApp
//
//  Created by Vjatseslav Pokatsalov on 03/04/2018.
//  Copyright © 2018 VPTeam. All rights reserved.
//

import UIKit

class BanksListViewController: UIViewController {
    
    let tableView = UITableView()
    var viewModel: BanksListViewModel! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModel.region
        configureSubviews()
        placeSubviews()
    }
    
    private func configureSubviews() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    private func placeSubviews() {
        self.view.addSubview(tableView)
        tableView.layoutInSuperView()
    }
    
}

extension BanksListViewController: UITableViewDelegate, UITableViewDataSource, TableViewModelDelegate {
    
    func didUpdateContent() {
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.banksCount
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let controller = BankDetailedViewController()
        controller.bank = viewModel.bank(atIndex: indexPath.row)
        let backItem = UIBarButtonItem()
        backItem.title = viewModel.region
        navigationItem.backBarButtonItem = backItem
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        cell.imageView?.backgroundColor = .red
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = viewModel.nameForBank(atIndex: indexPath.row)
        cell.detailTextLabel?.text = viewModel.addressForBank(atIndex: indexPath.row)
        return cell
    }
}
