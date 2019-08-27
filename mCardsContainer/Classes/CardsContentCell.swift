//
//  CardsContentCell.swift
//  mCardsContainer
//
//  Created by Alex Hmelevski on 2019-08-26.
//

import Foundation
import UIKit

class CardsContentCell: UICollectionViewCell {
    let label = UILabel(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = .white
        contentView.clipsToBounds = true
        
    }
    
    
    func addContentView(view: UIView) {
        view.tag = 9999
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        view.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        view.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
    }
    
    
    override func prepareForReuse() {
        viewWithTag(9999)?.removeFromSuperview()
    }
    
    override func layoutSubviews() {
        contentView.layer.cornerRadius = contentView.layer.frame.width * 0.1
        super.layoutSubviews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
