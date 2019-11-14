//
//  CardsCollectionViewDecorator.swift
//  AHContainer
//
//  Created by Alex Hmelevski on 2019-11-12.
//

import Foundation
import AHContainer

final class CardsCollectionViewDecorator: CardsCollectionViewController, VCContainer {
    var delegate: CardsCollectionViewDelegate? {
        get { cardsContainer.delegate }
        set { cardsContainer.delegate = newValue }
    }
    
    var placeHolderViews: [UIView] {
        get { cardsContainer.placeHolderViews}
        set { cardsContainer.placeHolderViews = newValue }
    }
    
    let navigationContainer: ALViewControllerContainer
    let cardsContainer: CardsCollectionViewController
    init(cardsContainer: CardsCollectionViewController) {
        self.cardsContainer = cardsContainer
        navigationContainer = ALViewControllerContainer(initialVC: cardsContainer)
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        snapCardsContainer()
    }
    
    private func snapCardsContainer() {
        view.addSubview(navigationContainer.view)
        navigationContainer.view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: navigationContainer.view.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: navigationContainer.view.bottomAnchor).isActive = true
        view.leftAnchor.constraint(equalTo: navigationContainer.view.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: navigationContainer.view.rightAnchor).isActive = true
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func show(_ vc: UIViewController,
                     using provider: TransitionProvider,
                     completion: ((Bool) -> Void)?) {
        navigationContainer.show(vc, using: provider, completion: completion)
    }
    
    public func push(controller vc: UIViewController,
                     with provider: TransitionProvider,
                     completion: ((Bool) -> Void)?) {
        navigationContainer.push(controller: vc, with: provider, completion: completion)
    }
    
    public func pop(using provider: AnimationTransitionProvider,
                    completion: ((Bool) -> Void)?) -> UIViewController? {
        return navigationContainer.pop(using: provider, completion: completion)
    }
    
    public func pop(to vc: UIViewController,
                    using provider: AnimationTransitionProvider,
                    completion: ((Bool) -> Void)?) -> [UIViewController] {
        return navigationContainer.pop(to: vc, using: provider, completion: completion)
    }

}
