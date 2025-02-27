//
//  CardsCollectionViewController.swift
//  mCardsContainer
//
//  Created by Alex Hmelevski on 2019-08-26.
//

import Foundation
import UIKit


enum State: Equatable {
    case expanded
    case collapsed
}

protocol CardsCollectionViewDelegate: class {
    func didTap(at index: Int, startFrame: CGRect)
    func menuShownProgress(_ progress: CGFloat)
}

class CardsCollectionViewControllerConfig {
    let collectionLayout: UICollectionViewLayout
    var menuContainerKind: String = ""
    var menuView: UIView = UIView(frame: .zero)
    var navigationView: UIView = UIView(frame: .zero)
    var navigationViewHeightProportion: Float = 0.1
    
    init(collectionLayout: UICollectionViewLayout) {
        self.collectionLayout = collectionLayout
    }
}


protocol CardsCollectionDelegatable: class {
    var delegate: CardsCollectionViewDelegate? { get set }
    var placeHolderViews: [UIView]  { get set }
}

typealias CardsCollectionViewController = UIViewController & CardsCollectionDelegatable

class CardsCollectionViewControllerImp: CardsCollectionViewController {
    
    let collectionView: UICollectionView
    var state: State = .collapsed
    var placeHolderViews: [UIView] = []
    let menuContainerKind: String
    let menuView: UIView
    let navigationView: UIView
    
    weak var delegate: CardsCollectionViewDelegate?
    private let navigationViewHeightProportion: CGFloat
    init(config: CardsCollectionViewControllerConfig) {
        self.menuContainerKind = config.menuContainerKind
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: config.collectionLayout)
        self.menuView = config.menuView
        self.navigationView  = config.navigationView
        self.navigationViewHeightProportion =  CGFloat(config.navigationViewHeightProportion)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: collectionView.topAnchor).isActive = true
        view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor).isActive = true
        view.leftAnchor.constraint(equalTo: collectionView.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: collectionView.rightAnchor).isActive = true
        
        navigationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(navigationView)
        
        navigationView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        navigationView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        navigationView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        navigationView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: navigationViewHeightProportion).isActive = true

        collectionView.backgroundColor = .red
        collectionView.register(CardsContentCell.self, forCellWithReuseIdentifier: "\(CardsContentCell.self)")
        if !menuContainerKind.isEmpty {
            collectionView.register(CardsMenuContainer.self,
                                    forSupplementaryViewOfKind: menuContainerKind,
                                    withReuseIdentifier: menuContainerKind)
        }
     
        collectionView.dataSource = self
        collectionView.delegate = self

    }
}


extension CardsCollectionViewControllerImp: UICollectionViewDataSource  {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return placeHolderViews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CardsContentCell.self)", for: indexPath) as? CardsContentCell else {
            fatalError()
        }
        cell.addContentView(view: placeHolderViews[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: menuContainerKind,
                                                                         withReuseIdentifier: menuContainerKind,
                                                                         for: indexPath) as? CardsMenuContainer else {
                                                                        fatalError()
        }
        
        view.addContentView(view: menuView)
        return view
    }
}

extension CardsCollectionViewControllerImp: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let menuViewWidth = collectionView.visibleSupplementaryViews(ofKind: menuContainerKind)
                                                .first
                                                .map({ $0.frame.size.width }) else {
            return
        }
        
        let currentOffsetX = scrollView.contentOffset.x
        let progress = (menuViewWidth - currentOffsetX) / menuViewWidth
        let finalProgress = max(progress, 0)
        navigationView.alpha = 1 - finalProgress

    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let frame = collectionView.layoutAttributesForItem(at: indexPath)?.frame else { return }
        
        let newFrame = CGRect(x: frame.origin.x - collectionView.contentOffset.x,
                              y: frame.origin.y - collectionView.contentOffset.y,
                              width: frame.size.width,
                              height: frame.size.height)
        delegate?.didTap(at: indexPath.row, startFrame: newFrame)
    }
}
