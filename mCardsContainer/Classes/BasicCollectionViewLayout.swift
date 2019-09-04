//
//  BasicCollectionViewLayout.swift
//  mCardsContainer
//
//  Created by Alex Hmelevski on 2019-09-04.
//

import Foundation


public class BasicCollectionViewLayout: UICollectionViewLayout {
    var _collectionView: UICollectionView {
        guard let cv = collectionView else { fatalError() }
        return cv
    }
}
