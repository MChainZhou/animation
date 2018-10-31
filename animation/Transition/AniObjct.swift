//
//  AniObjct.swift
//  animation
//
//  Created by USER on 2018/10/23.
//  Copyright © 2018年 USER. All rights reserved.
//

import UIKit

class AniObjct: NSObject {

}

extension AniObjct: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let formVc = transitionContext.viewController(forKey: .from), let toVc = transitionContext.viewController(forKey: .to) else {
            return
        }
        
        let duration = transitionDuration(using: transitionContext)
        if let toView = toVc.view, let fromView = formVc.view {
            if toVc.isBeingPresented {
                containerView.addSubview(toView)
                let toViewWidth = containerView.frame.width * 2 / 3, toViewHeight = containerView.frame.height * 2 / 3
                toView.center = containerView.center
                toView.bounds = CGRect(x: 0, y: 0, width: 1, height: toViewHeight)
                
                UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
                    toView.bounds = CGRect(x: 0, y: 0, width: toViewWidth, height: toViewHeight)
                }) { _ in
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                }
            }
            if formVc.isBeingDismissed {
                let fromViewHeight = fromView.frame.height
                UIView.animate(withDuration: duration, animations: {
                    fromView.bounds = CGRect(x: 0, y: 0, width: 1, height: fromViewHeight)
                }, completion: { _ in
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                })
            }
        }
        
        
        
        
        
        
        
//        //跳转的界面
//        let toVc = transitionContext.viewController(forKey: .to)
//        let fromVc = transitionContext.viewController(forKey: .from)
//        let duration = transitionDuration(using: transitionContext)
//        
//        if let toVc = toVc, let fromVc = fromVc {
//            if toVc.isBeingPresented {
//                //最终的位置
//                let finalRect = transitionContext.finalFrame(for: toVc)
//                //起始位置
//                toVc.view.frame = finalRect.offsetBy(dx: UIScreen.main.bounds.width, dy: 0)
//                //添加到内容视图
//                transitionContext.containerView.addSubview(toVc.view)
//                UIView.animate(withDuration: duration, animations: {
//                    toVc.view.frame = finalRect
//                }) { _ in
//                    transitionContext.completeTransition(true)
//                }
//            }
//            if fromVc.isBeingDismissed {
////                transitionContext.containerView.insertSubview(toVc.view, belowSubview: fromVc.view)
////                UIView.animate(withDuration: duration, animations: {
////                    fromVc.view.frame = CGRect(x: UIScreen.main.bounds.width, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
////                }) { _ in
////                    transitionContext.completeTransition(true)
////                }
//            }
//        }
        
        
        
        
    }
    
    
}
