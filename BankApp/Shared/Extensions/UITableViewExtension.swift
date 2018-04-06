//
//  UITableViewExtension.swift
//  BankApp
//
//  Created by Vjatseslav Pokatsalov on 03/04/2018.
//  Copyright © 2018 VPTeam. All rights reserved.
//

import UIKit


extension UITableView {
    
    func beginRefresManually() {
        if let refreshControl = self.refreshControl {
            refreshControl.beginRefreshing()
            setContentOffset(CGPoint(x: self.contentOffset.x,
                                     y: self.contentOffset.y - refreshControl.frame.size.height),
                             animated: true)
        }
    }
    
    func configureDefaultRefresh(target: Any?, actionSelector: Selector) {
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.refreshControl?.addTarget(target,
                                       action: actionSelector,
                                       for: UIControlEvents.valueChanged)
    }
}
