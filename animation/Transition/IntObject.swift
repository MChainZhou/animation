//
//  IntObject.swift
//  animation
//
//  Created by USER on 2018/10/23.
//  Copyright © 2018年 USER. All rights reserved.
//

import UIKit

class IntObject: NSObject {
    var context: UIViewControllerContextTransitioning?
    
}

extension IntObject: UIViewControllerInteractiveTransitioning {
    func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        context = transitionContext
        let toVc = transitionContext.viewController(forKey: .to)
        let fromVc = transitionContext.viewController(forKey: .from)
        if let toVc = toVc, let fromVc = fromVc {
            toVc.view.frame = transitionContext.finalFrame(for: toVc)
            transitionContext.containerView.insertSubview(toVc.view, belowSubview: fromVc.view)
        }
    }
    
}
