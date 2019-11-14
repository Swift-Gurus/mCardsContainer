//
//  CardsContainerBuilder.swift
//  mCardsContainer
//
//  Created by Alex Hmelevski on 2019-08-27.
//

import Foundation
import AHContainer

public class CardsContainerBuilder {
    
    public var collectionViewLayout: UICollectionViewLayout = CardsHorizontalLayout(config: LayoutConfig(isPagingEnabled: true))
    public var animator: Animator = DefaultAnimator()
    public var layoutConfig: LayoutConfig = LayoutConfig() {
        didSet {
            collectionViewLayout = CardsHorizontalLayout(config: layoutConfig)
        }
    }
    public var source: CardsContainerDataSource?
    public var menuContainerKind: String = ""
    public var menuView: UIView = UIView(frame: .zero)
    public var navigationView: UIView = UIView(frame: .zero)
    public var navigationViewHeightProportion: Float = 0.1

    public init(source: CardsContainerDataSource) {
        self.source = source
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func createContainer() -> UIViewController {
        guard let source = self.source else { fatalError("DataSource is not set") }
         
        let config = CardsContainerConfig(source: source,
                                          collectionViewController: cardsCollectionViewController,
                                          animationProvider: animator,
                                          buttomView: UIView(frame: .zero),
                                          buttomViewHeightProportion: 0)
      
        return CardsContainer(config: config)
    }
    
    var cardsCollectionViewController: CardsCollectionViewController {
        return CardsCollectionViewControllerImp(config: collectionViewControllerConfig)
    }
    
    
    var collectionViewControllerConfig: CardsCollectionViewControllerConfig {
        let collectionViewControllerConfig = CardsCollectionViewControllerConfig(collectionLayout: collectionViewLayout)
        collectionViewControllerConfig.menuContainerKind = menuContainerKind
        collectionViewControllerConfig.menuView = menuView
        collectionViewControllerConfig.topHeaderView = navigationView
        collectionViewControllerConfig.topHeaderViewHeightProportion = navigationViewHeightProportion
        return collectionViewControllerConfig
    }
}


public final class CardsNavigationContainerBuilder: CardsContainerBuilder {
    public var buttomView: UIView = UIView(frame: .zero)
    public var buttomViewHeightProportion: Float = 0.1
    public func createNavigationContainer() -> UIViewController & VCContainer {
        guard let source = self.source else { fatalError("DataSource is not set") }
               
        let config = CardsContainerConfig(source: source,
                                          collectionViewController: cardsCollectionViewController,
                                          animationProvider: animator,
                                          buttomView: buttomView,
                                          buttomViewHeightProportion: CGFloat(buttomViewHeightProportion))
        
        
        return NavigationContainerFacade(config: config)
    }
    
    
    override var collectionViewControllerConfig: CardsCollectionViewControllerConfig {
        let config = super.collectionViewControllerConfig
        config.footerHeightProportion = buttomViewHeightProportion
        config.footerView = buttomView
        return config
    }
}
