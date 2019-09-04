//
//  CardsLayoutAttributes.swift
//  mCardsContainer
//
//  Created by Alex Hmelevski on 2019-09-04.
//

import Foundation


class CardsLayoutAttributes: UICollectionViewLayoutAttributes {
    var cornerRadius: CGFloat = 0
    override init() {
        super.init()
    }
    
    
    override func copy(with zone: NSZone? = nil) -> Any {
        let copyAttr = super.copy(with: zone) as? CardsLayoutAttributes ?? CardsLayoutAttributes()
        copyAttr.cornerRadius = self.cornerRadius
        return copyAttr
    }
    
}
