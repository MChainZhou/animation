//
//  PushPopTransition.swift
//  animation
//
//  Created by USER on 2018/10/24.
//  Copyright © 2018年 USER. All rights reserved.
//

import UIKit

class PushPopTransition: NSObject, UIViewControllerAnimatedTransitioning {
    var isPush: Bool = true
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.8
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let formVc = transitionContext.viewController(forKey: .from)
        let toVc = transitionContext.viewController(forKey: .to)
        let containerView = transitionContext.containerView
        let duration = transitionDuration(using: transitionContext)
        
        if let formVc = formVc, let toVc = toVc {
            let finalFrameForVc = transitionContext.finalFrame(for: toVc)
            let bounds = UIScreen.main.bounds
            let offSetY = isPush ? bounds.size.height : -bounds.size.height
            
            toVc.view.frame = finalFrameForVc.offsetBy(dx: 0, dy: offSetY)
            containerView.addSubview(toVc.view)
            
            UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveLinear, animations: {
                formVc.view.alpha = 0.8
                toVc.view.frame = finalFrameForVc
            }) { _ in
                transitionContext.completeTransition(true)
                formVc.view.alpha = 1.0
            }
            
        }
        
    }
    
    
    
}
