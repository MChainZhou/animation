//
//  OverlayPresentationController.swift
//  animation
//
//  Created by USER on 2018/10/23.
//  Copyright © 2018年 USER. All rights reserved.
//

import UIKit

class OverlayPresentationController: UIPresentationController {
    let dimmingView = UIView()
    
    override func presentationTransitionWillBegin() {
        containerView?.addSubview(dimmingView)
        if let containerView = containerView {
            let dimmingViewInitailW = containerView.frame.width * 2 / 3, dimmingViewInitailH = containerView.frame.height * 2 / 3
            dimmingView.center = containerView.center
            dimmingView.backgroundColor = UIColor.black
            dimmingView.alpha = 0.5
            dimmingView.bounds = CGRect(x: 0, y: 0, width: dimmingViewInitailW, height: dimmingViewInitailH)
            presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
                self.dimmingView.bounds = containerView.bounds
            }, completion: nil)
        }
    }
    
    override func dismissalTransitionWillBegin() {
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 0
        }, completion: nil)
    }
    
    override func containerViewWillLayoutSubviews() {
        if let containerView = containerView {
            dimmingView.center = containerView.center
            dimmingView.bounds = containerView.bounds
            let width = containerView.frame.width * 2 / 3, height = containerView.frame.height * 2 / 3
            presentedView?.center = containerView.center
            presentedView?.bounds = CGRect(x: 0, y: 0, width: width, height: height)
        }
    }
}
