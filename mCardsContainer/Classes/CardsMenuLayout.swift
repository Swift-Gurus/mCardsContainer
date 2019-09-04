//
//  CardsMenuLayout.swift
//  mCardsContainer
//
//  Created by Alex Hmelevski on 2019-09-04.
//

import Foundation


public struct CardsMenuLayoutConfig {
    public let supplementaryViewKind: String
    let cardsLayoutConfig: LayoutConfig
    public init(kind: String = "CardsMenuKind",
                cardsLayoutConfig: LayoutConfig) {
        self.supplementaryViewKind = kind
        self.cardsLayoutConfig = cardsLayoutConfig
    }
}

public final class  CardsMenuLayout:  CardsHorizontalLayout {
    
    private let config: CardsMenuLayoutConfig
    
    private var menuAttributes: UICollectionViewLayoutAttributes
    private var menuState: Bool = false
    public init(config: CardsMenuLayoutConfig) {
        self.config = config
        menuAttributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: config.supplementaryViewKind,
                                                          with: IndexPath(row: 0, section: 0))
        super.init(config: config.cardsLayoutConfig)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var stopPoint: CGPoint  = {
        guard let attributes = cachedAttributes.first else { return .zero }
        
        return CGPoint(x: attributes.frame.origin.x  - basicOffset, y: 0)
    }()
    
    public override var collectionViewContentSize: CGSize {
        let size = super.collectionViewContentSize
        
        return CGSize(width: size.width + menuAttributes.frame.size.width,
                      height: size.height)
    }
    public override func prepare() {
        let height = _collectionView.bounds.size.height
        menuAttributes.frame = CGRect(x: 0,
                                      y: 0,
                                      width: itemWidth,
                                      height: height)
        super.prepare()
        _collectionView.setContentOffset(stopPoint, animated: false)
    }
    
    
    override func getXCoordinates(using itemWidth: CGFloat,
                                  cvWidth: CGFloat,
                                  index: Int) -> CGFloat {
        let superX = super.getXCoordinates(using: itemWidth,
                                           cvWidth: cvWidth,
                                           index: index)
        return superX + self.itemWidth
    }
    
    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributes = super.layoutAttributesForElements(in: rect) ?? []
        if menuAttributes.frame.intersects(rect) {
            attributes.append(menuAttributes)
        }
        return attributes
    }
 
    
    public override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return menuAttributes
    }
    
    public override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
      return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
    }
}
