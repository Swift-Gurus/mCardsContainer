    //
    //  CardsHorizontalLayout.swift
    //  CardsLayout
    //
    //  Created by Alex Hmelevski on 2019-08-22.
    //  Copyright © 2019 ALDO Inc. All rights reserved.
    //

import Foundation
import UIKit

public class CardsHorizontalLayout: BasicCollectionViewLayout {
    
    private let config: LayoutConfig
    
    
    private var currentItemIndex = 1
    
    private var widthProportion: CGFloat {
        return CGFloat(config.widthProportion)
    }
    
    private var hightProportion: CGFloat {
        return CGFloat(config.hightProportion)
    }

    
    var itemHight: CGFloat {
        return _collectionView.bounds.height * hightProportion
    }
    
    var itemWidth: CGFloat {
        return _collectionView.bounds.width * widthProportion
    }
    
     var basicOffset: CGFloat {
        return  (_collectionView.bounds.width - itemWidth) / 2
    }
    
    private var stopPoint: CGPoint {
        guard let attributes = cachedAttributes.first else { return .zero }
        
        return CGPoint(x: attributes.frame.origin.x + attributes.frame.size.width, y: 0)
    }
    
    public init(config: LayoutConfig) {
        self.config = config
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var cachedAttributes: [CardsLayoutAttributes] = []
    
    override public func prepare() {
        _collectionView.isScrollEnabled = config.scrollingEnabled
        
        // Enable paging UI while scrolling set decelerationRate .fast
        _collectionView.decelerationRate = config.isPagingEnabled ? .fast : .normal
        cachedAttributes = stride(from: 0, to: _collectionView.numberOfSections, by: 1).map(getAttributesFor)
                                                                                       .flatMap({ $0 })
    
    }
    
    override public var collectionViewContentSize: CGSize {
      let lastFrame = cachedAttributes.last?.frame ?? .zero
      let width = lastFrame.origin.x + lastFrame.width
       
      return CGSize(width: width + basicOffset, height: lastFrame.width)
    }

    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cachedAttributes.filter({ $0.frame.intersects(rect) })
    }
    

    override public func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cachedAttributes[indexPath.row]
    }
    
    func getAttributesFor(section: Int) -> [CardsLayoutAttributes] {
        let numberOfItems =  _collectionView.numberOfItems(inSection: section)
        return stride(from: 0, to: numberOfItems, by: 1).map({ IndexPath(row: $0, section: section)})
                                                        .map(getAttributes)
    }
    
    func getAttributes(for indexPath: IndexPath) -> CardsLayoutAttributes {
        let attributes = CardsLayoutAttributes(forCellWith: indexPath)
        let cvBounds = _collectionView.bounds
        attributes.frame = cvBounds
        attributes.cornerRadius = config.widthProportion == 1 ? 0 : 0.1
        let yCoordinate = getYCoordinates(using: itemHight, cvHight: cvBounds.height)
        let xCoordinate = getXCoordinates(using: itemWidth,
                                          cvWidth: cvBounds.width,
                                          index: indexPath.row)
        attributes.frame = CGRect(x: xCoordinate,
                                  y: yCoordinate,
                                  width: itemWidth,
                                  height: itemHight)
    
        return attributes
    }
    
    
    func getYCoordinates(using itemHight: CGFloat, cvHight: CGFloat) -> CGFloat {
        return (cvHight - itemHight) / CGFloat(2)
    }
    
    func getXCoordinates(using itemWidth: CGFloat,
                         cvWidth: CGFloat,
                         index: Int) -> CGFloat {
        let cgIndex = CGFloat(index)
        return basicOffset + basicOffset * cgIndex * 0.8 + itemWidth * cgIndex
    }
    
    
    override public func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint,
                                             withScrollingVelocity velocity: CGPoint) -> CGPoint {
       let frame = currentAttributes(for: velocity).frame
       let newSuggestedOffset = CGPoint(x: frame.origin.x - basicOffset,
                                        y: proposedContentOffset.y)
        return newSuggestedOffset
    }
    
    override public func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        
        return super.targetContentOffset(forProposedContentOffset: proposedContentOffset)
    }
    

    private func currentAttributes(for velocity: CGPoint) -> CardsLayoutAttributes {
        guard velocity.x != 0 else { return cachedAttributes[currentItemIndex] }
        velocity.x > 0 ? increaseCurrentIndex() : decreaseCurrentIndex()
        return cachedAttributes[currentItemIndex]
    }
    
    
    private func increaseCurrentIndex() {
        guard currentItemIndex + 1 < cachedAttributes.count else { return }
        currentItemIndex += 1
    }
    
    private func decreaseCurrentIndex() {
        guard currentItemIndex - 1 >= 0 else { return }
        currentItemIndex -= 1
    }
}
