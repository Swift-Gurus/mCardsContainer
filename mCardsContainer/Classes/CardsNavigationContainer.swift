//
//  CardsNavigationContainer.swift
//  mCardsContainer
//
//  Created by Alex Hmelevski on 2019-11-12.
//

import Foundation
import AHContainer

final class CardsNavigationContainer: UIViewController, VCContainer {
    
    let cardsContainer: CardsContainer
    let collectionViewControllerWrapper: VCContainer
    
    init(config: CardsContainerConfig) {
        let collectionView = CardsCollectionViewContainer(cardsContainer: config.collectionViewController)
        collectionViewControllerWrapper = collectionView
        let newConfig = CardsContainerConfig(source: config.source,
                                             collectionViewController: collectionView,
                                             animationProvider: config.animationProvider,
                                             buttomView: config.bottomView,
                                             buttomViewHeightProportion: config.bottomViewHeightProportion)
        cardsContainer = CardsContainer(config: newConfig)
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(cardsContainer)
        view.addSubview(cardsContainer.view)
        cardsContainer.view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: cardsContainer.view.safeAreaLayoutGuide.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: cardsContainer.view.bottomAnchor).isActive = true
        view.leftAnchor.constraint(equalTo: cardsContainer.view.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: cardsContainer.view.safeAreaLayoutGuide.rightAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show(_ vc: UIViewController, using provider: TransitionProvider, completion: ((Bool) -> Void)?) {
        collectionViewControllerWrapper.show(vc, using: provider, completion: completion)
    }
    
    func push(controller vc: UIViewController, with provider: TransitionProvider, completion: ((Bool) -> Void)?) {
        collectionViewControllerWrapper.push(controller: vc, with: provider, completion: completion)
    }
    
    func pop(using provider: AnimationTransitionProvider, completion: ((Bool) -> Void)?) -> UIViewController? {
        return collectionViewControllerWrapper.pop(using: provider, completion: completion)
    }
    
    func pop(to vc: UIViewController, using provider: AnimationTransitionProvider, completion: ((Bool) -> Void)?) -> [UIViewController] {
        return collectionViewControllerWrapper.pop(to: vc, using: provider, completion: completion)
    }
    
    
}
