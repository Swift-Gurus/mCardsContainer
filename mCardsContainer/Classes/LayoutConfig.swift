//
//  LayoutConfig.swift
//  mCardsContainer
//
//  Created by Alex Hmelevski on 2019-09-04.
//

import Foundation

public struct LayoutConfig {
    let hightProportion: Double
    let widthProportion: Double
    let scrollingEnabled: Bool
    let isPagingEnabled: Bool
    
    public init(hightProportion: Double = 0.7,
                widthProportion: Double = 0.8,
                scrollingEnabled: Bool = true,
                isPagingEnabled: Bool = false) {
        self.hightProportion = hightProportion
        self.widthProportion = widthProportion
        self.scrollingEnabled = scrollingEnabled
        self.isPagingEnabled = isPagingEnabled
    }
}
   
