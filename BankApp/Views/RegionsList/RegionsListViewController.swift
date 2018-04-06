//
//  BankListViewController.swift
//  BankApp
//
//  Created by Vjatseslav Pokatsalov on 03/04/2018.
//  Copyright © 2018 VPTeam. All rights reserved.
//

import UIKit


class RegionsListViewController: UIViewController {
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    
    private let viewModel = RegionsListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        placeSubviews()
        viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.subscribeOnBankService()
    }
    
    private func configureViews() {
        self.title = "Regions"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50

        tableView.configureDefaultRefresh(target: self, actionSelector: #selector(onTableViewPull(_:)))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    private func placeSubviews() {
        self.view.addSubview(tableView)
        tableView.layoutInSuperView()
    }
    
    @objc func onTableViewPull(_ sender: UITableView) {
        self.tableView.refreshControl?.beginRefreshing()
        BankService.instance.loadBanksForAllCountries()
    }
    
}

extension RegionsListViewController: UITableViewDelegate, UITableViewDataSource, TableViewModelDelegate {
    
    func didUpdateContent() {
        self.tableView.refreshControl?.endRefreshing()
        self.tableView.reloadData()
    }
    
    func beginLoadinAnimation() {
        if !(tableView.refreshControl?.isRefreshing ?? true) {
            self.tableView.beginRefresManually()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfCountries
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRegionsForCountry(section)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = viewModel.countryName(forIndex: section)
        let headerView = UIView()
        headerView.backgroundColor = .lightGray
        headerView.addSubview(label)
        label.setAnchors(top: headerView.topAnchor, left: headerView.leftAnchor,
                         bottom: headerView.bottomAnchor, right: headerView.rightAnchor,
                         leftConstant: 20, rightConstant: 20)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = viewModel.regionTitle(forIndexPath: indexPath)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let banksController = BanksListViewController()
        banksController.viewModel = viewModel.prepareBankListViewModel(forSelectedIndexPath: indexPath)
        self.navigationController?.pushViewController(banksController, animated: true)
    }
}
