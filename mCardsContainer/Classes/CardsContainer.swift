//
//  CardsContainer.swift
//  mCardsContainer
//
//  Created by Alex Hmelevski on 2019-08-26.
//

import Foundation
import UIKit


public protocol CardPresentable {
    var placeholderView: UIView { get }
    var mainView: UIView { get }
    func setCloseClosure(_ closure: @escaping () -> Void)
}

public protocol CardsContainerDataSource: class {
    var controllers: [UIViewController & CardPresentable] { get }
}


public protocol Animator {
    func expandAnimation(animationBlock: @escaping () -> Void,
                        completion: @escaping () -> Void)
    
    func collapseAnimation(animationBlock: @escaping () -> Void,
                          completion: @escaping () -> Void)
}

public class CardsContainer: UIViewController {
    
    private let collectionViewController: CardsCollectionViewController
    private let source: CardsContainerDataSource
    private let animationProvider: Animator
    
    private var collectionView: UIView {
        return collectionViewController.view
    }
    
    public init(collectionViewLayout: UICollectionViewLayout,
                source: CardsContainerDataSource,
                animationProvider: Animator) {
        collectionViewController = CardsCollectionViewController(collectionLayout: collectionViewLayout)
        self.source = source
        collectionViewController.placeHolderViews = source.controllers.map({ $0.placeholderView })
        self.animationProvider = animationProvider
        super.init(nibName: nil, bundle: nil)
        self.collectionViewController.delegate = self
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: collectionView.topAnchor).isActive = true
        view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor).isActive = true
        view.leftAnchor.constraint(equalTo: collectionView.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: collectionView.rightAnchor).isActive = true
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension CardsContainer: CardsCollectionViewDelegate {
    func didTap(at index: Int, startFrame: CGRect) {
        let vc = source.controllers[index]
        let point = collectionView.convert(startFrame.origin, to: view)
        let initialFrame = CGRect(origin: point, size: startFrame.size)
        prepareAnimation(for: vc, using: initialFrame)
        
        animationProvider.expandAnimation(animationBlock: { [weak self] in self?.performExpandAnimation(for: vc)},
                                          completion: { [weak self] in self?.completeAnimation(for: vc, finalFrame: initialFrame)} )
    }
    
    
    private func prepareAnimation(for vc: UIViewController, using startFrame: CGRect) {
        view.addSubview(vc.view)
        vc.view.frame = startFrame
        vc.view.layoutIfNeeded()
        vc.view.layer.cornerRadius = vc.view.frame.width * 0.1
        vc.view.clipsToBounds = true
    }
    
    private func performExpandAnimation(for vc: UIViewController) {
        vc.view.frame = self.view.bounds
        vc.view.layoutIfNeeded()
        vc.view.layer.cornerRadius = 0
    }
    
    private func completeAnimation(for vc: UIViewController & CardPresentable, finalFrame: CGRect) {
        vc.setCloseClosure { [weak self, weak vc] in
            guard let `self` = self, let vc = vc else { return }
            self.collapse(vc: vc, endFrame: finalFrame)
        }
    }
    
    private func collapse(vc: UIViewController, endFrame: CGRect) {
        animationProvider.collapseAnimation(animationBlock: { [weak self] in self?.performCollapseAnimation(vc: vc, endFrame: endFrame)},
                                            completion: {[weak self] in self?.completeCollapseAnimation(vc: vc) })
    }
    
    private func performCollapseAnimation(vc: UIViewController, endFrame: CGRect) {
        vc.view.frame = endFrame
        vc.view.layoutIfNeeded()
        vc.view.layer.cornerRadius = endFrame.width * 0.1
    }
    private func completeCollapseAnimation(vc: UIViewController) {
        vc.view.removeFromSuperview()
    }
}
