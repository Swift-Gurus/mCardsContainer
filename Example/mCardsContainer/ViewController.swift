//
//  ViewController.swift
//  mCardsContainer
//
//  Created by AlexHmelevski on 08/26/2019.
//  Copyright (c) 2019 AlexHmelevski. All rights reserved.
//

import UIKit
import mCardsContainer

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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let layoutConfig =  LayoutConfig(isPagingEnabled: true)
        let cardsMenuConfig = CardsMenuLayoutConfig(cardsLayoutConfig: layoutConfig)
        let layout = CardsMenuLayout(config: cardsMenuConfig)
        let builder = CardsContainerBuilder()
        builder.collectionViewLayout = layout
        builder.menuContainerKind = cardsMenuConfig.menuContainerKind
        builder.source = CardsDataSource()
        builder.menuView = menu.view
        let container = builder.createContainer()
        present(container, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

