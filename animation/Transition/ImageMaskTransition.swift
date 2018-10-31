//
//  ImageMaskTransition.swift
//  animation
//
//  Created by USER on 2018/10/25.
//  Copyright © 2018年 USER. All rights reserved.
//

import UIKit

struct TransitionConfig {
    var fromImageView: UIImageView
    var toImageView: UIImageView
    var blurRadius: CGFloat
    var presentDuration: CGFloat
    var dismissDuration: CGFloat
}

class ImageMaskTransition: NSObject, UINavigationControllerDelegate, UIViewControllerTransitioningDelegate {
    let animator: ImageMaskAnimator
    
    init(fromImageView: UIImageView, toImageView: UIImageView) {
        let config = TransitionConfig(fromImageView: fromImageView, toImageView: toImageView, blurRadius: 3.0, presentDuration: 1.6, dismissDuration: 1.3)
        animator = ImageMaskAnimator(config: config)
        super.init()
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.type = operation == .push ? .present : .dismiss
        return animator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.type = .dismiss
        return animator
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.type = .present
        return animator
    }
}


