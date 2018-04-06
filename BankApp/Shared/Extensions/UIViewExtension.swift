//
//  UIViewExtension.swift
//  BankApp
//
//  Created by Vjatseslav Pokatsalov on 03/04/2018.
//  Copyright © 2018 VPTeam. All rights reserved.
//

import UIKit


extension UIView {
    
    func layoutInSuperView() {
        if let view = self.superview {
            setAnchors(top: view.topAnchor, left: view.leftAnchor,
                       bottom: view.bottomAnchor, right: view.rightAnchor)
        }
    }
    
    func setAnchors(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil,
                    bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil,
                    centerX: NSLayoutXAxisAnchor? = nil, centerY: NSLayoutYAxisAnchor? = nil,
                    topConstant: CGFloat = 0, leftConstant: CGFloat = 0,
                    bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0,
                    widthConstant: CGFloat? = nil, heightConstant: CGFloat? = nil) {
        _ = setAnchorsAndGetThemBack(top: top, left: left, bottom: bottom, right: right,
                                     centerX: centerX, centerY: centerY,
                                     topConstant: topConstant, leftConstant: leftConstant,
                                     bottomConstant: bottomConstant, rightConstant: rightConstant,
                                     widthConstant: widthConstant, heightConstant: heightConstant)
    }
    
    func setAnchorsAndGetThemBack(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil,
                                  bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil,
                                  centerX: NSLayoutXAxisAnchor? = nil, centerY: NSLayoutYAxisAnchor? = nil,
                                  topConstant: CGFloat = 0, leftConstant: CGFloat = 0,
                                  bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0,
                                  widthConstant: CGFloat? = nil, heightConstant: CGFloat? = nil) -> [NSLayoutConstraint]{
        self.translatesAutoresizingMaskIntoConstraints = false
        var constraints: [NSLayoutConstraint] = []
        if let top = top {
            constraints.append(self.topAnchor.constraint(equalTo: top, constant: topConstant))
        }
        if let left = left {
            constraints.append(self.leftAnchor.constraint(equalTo: left, constant: leftConstant))
        }
        if let bottom = bottom {
            constraints.append(self.bottomAnchor.constraint(equalTo: bottom, constant: bottomConstant))
        }
        if let right = right {
            constraints.append(self.rightAnchor.constraint(equalTo: right, constant: rightConstant))
        }
        if let width = widthConstant {
            constraints.append(self.widthAnchor.constraint(equalToConstant: width))
        }
        if let height = heightConstant {
            constraints.append(self.heightAnchor.constraint(equalToConstant: height))
        }
        if let centerX = centerX {
            constraints.append(self.centerXAnchor.constraint(equalTo: centerX))
        }
        if let centerY = centerY {
            constraints.append(self.centerYAnchor.constraint(equalTo: centerY))
        }
        constraints.forEach({ $0.isActive = true})
        return constraints
    }
    
}
