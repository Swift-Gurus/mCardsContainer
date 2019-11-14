//
//  ViewController.swift
//  mCardsContainer
//
//  Created by AlexHmelevski on 08/26/2019.
//  Copyright (c) 2019 AlexHmelevski. All rights reserved.
//

import UIKit
import mCardsContainer
import AHContainer

class CardsDataSource: CardsContainerDataSource {
    var controllers: [UIViewController & CardPresentable] = [CardController(),
                                                             CardController(),
                                                             CardController(),
                                                             CardController(),
                                                             CardController(),
                                                             CardController()]
    
    
}

class ViewController: UIViewController {

    
    let menu = CardControllerMenu()
    var container: VCContainer?
    let provider = DefaultAnimationProviderFactory().provider(for: .slideLeft(size: .init(width: 1, height: 0.9)), dimmingViewType: .noDimming)
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let layoutConfig =  LayoutConfig(isPagingEnabled: true)
        let cardsMenuConfig = CardsMenuLayoutConfig(cardsLayoutConfig: layoutConfig)
        let layout = CardsMenuLayout(config: cardsMenuConfig)
        let dataSource = CardsDataSource()
        
        let builder = CardsNavigationContainerBuilder(source: dataSource)
        builder.collectionViewLayout = layout
        builder.menuContainerKind = cardsMenuConfig.menuContainerKind
        builder.menuView = menu.view
        builder.navigationView = NavigationView()
        let container = builder.createNavigationContainer()
        self.container = container
        builder.buttomView.backgroundColor = .lightGray
        present(container, animated: true, completion: {
            Thread.sleep(forTimeInterval: 2)
            let newVC = UIViewController(nibName: nil, bundle: nil)
            newVC.view.backgroundColor = .green
            self.container?.push(controller: newVC, with: self.provider, completion: nil)
        })
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

