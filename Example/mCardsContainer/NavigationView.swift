//
//  NavigationView.swift
//  mCardsContainer_Example
//
//  Created by Jigs on 2019-09-06.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class NavigationView: UIView {
    let label =  UILabel(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)
            
        self.backgroundColor = .clear
        
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        label.topAnchor.constraint(equalTo: topAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 40)
        label.text = "CREW"
        
        label.textAlignment = .center

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

