//
//  PlaceHolderView.swift
//  mCardsContainer_Example
//
//  Created by Alex Hmelevski on 2019-08-27.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class PlaceHolderView: UIView {
    let imageView = UIImageView(image: UIImage(imageLiteralResourceName: "store-logo-aldo-1"))
    let label =  UILabel(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        
        imageView.contentMode = .scaleAspectFill
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1, constant: 0).isActive = true
        
        
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        label.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        
        label.text = "Whatever"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
