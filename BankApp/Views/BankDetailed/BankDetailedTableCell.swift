//
//  BankDetailedTableCell.swift
//  BankApp
//
//  Created by Vjatseslav Pokatsalov on 05/04/2018.
//  Copyright © 2018 VPTeam. All rights reserved.
//

import UIKit

class BankDetailedTableViewCell: UITableViewCell {
    
    var separatorMultiplier: CGFloat = 0.95
    var separatorHeight: CGFloat = 2.0
    let separator: UIView = UIView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .value2, reuseIdentifier: reuseIdentifier)
        textLabel?.textColor = .lightGray
        detailTextLabel?.textColor = .darkGray
        detailTextLabel?.numberOfLines = 0
        
        separator.backgroundColor = .black
        addSubview(separator)
        
    }
    
    override func draw(_ rect: CGRect) {
        separator.constraints.forEach({ $0.isActive = false })
        separator.setAnchors(bottom: bottomAnchor, right: rightAnchor, heightConstant: 2)
        separator.widthAnchor.constraint(equalTo: widthAnchor, multiplier: separatorMultiplier).isActive = true
        self.layoutSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
