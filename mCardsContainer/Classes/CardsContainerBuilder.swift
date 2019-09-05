//
//  CardsContainerBuilder.swift
//  mCardsContainer
//
//  Created by Alex Hmelevski on 2019-08-27.
//

import Foundation


public final class CardsContainerBuilder {
    
    public var collectionViewLayout: UICollectionViewLayout = CardsHorizontalLayout(config: LayoutConfig(isPagingEnabled: true))
    public var animator: Animator = DefaultAnimator()
    public var source: CardsContainerDataSource?
    public var menuContainerKind: String = ""
    public var menuView: UIView = UIView(frame: .zero)
    public init() {} 
    public func createContainer() -> CardsContainer {
        guard let source = self.source else { fatalError("DataSource is not set") }
        
        let config = CardsContainerConfig(collectionViewLayout: collectionViewLayout,
                                          source: source,
                                          animationProvider: animator)
        config.menuContainerKind = menuContainerKind
        config.menuView = menuView
        
        return CardsContainer(config: config)
    }
    
    
    
}
