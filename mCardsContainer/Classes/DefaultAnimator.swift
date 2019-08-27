//
//  DefaultAnimator.swift
//  mCardsContainer
//
//  Created by Alex Hmelevski on 2019-08-27.
//

import Foundation


public final class DefaultAnimator: Animator {
    public func expandAnimation(animationBlock: @escaping () -> Void,
                                completion: @escaping () -> Void) {
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.2,
                                                       delay: 0,
                                                       options: [],
                                                       animations: animationBlock,
                                                       completion: { _ in completion() })
        
    }
    
    public func collapseAnimation(animationBlock: @escaping () -> Void,
                                  completion: @escaping () -> Void) {
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.2,
                                                       delay: 0,
                                                       options: [],
                                                       animations: animationBlock,
                                                       completion: { _ in completion() })
    }
    
    
}
