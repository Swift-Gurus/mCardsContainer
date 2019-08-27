//
//  CardController.swift
//  mCardsContainer_Example
//
//  Created by Alex Hmelevski on 2019-08-27.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import mCardsContainer

class CardController: UIViewController, CardPresentable {
    func setCloseClosure(_ closure: @escaping () -> Void) {
        self.closure = closure
    }
    
    var placeholderView: UIView = PlaceHolderView(frame: .zero)
    
    var mainView: UIView = PlaceHolderView(frame: .zero)
    
    var button = UIButton(frame: .zero)
    var closure:  (() -> Void)?
    override func viewDidLoad() {
        view.addSubview(mainView)
        
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mainView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mainView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
        view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        button.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        view.backgroundColor = .yellow
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @objc func didTap() {
        closure?()
    }
    
}
