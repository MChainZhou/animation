//
//  ImageMaskAnimator.swift
//  animation
//
//  Created by USER on 2018/10/25.
//  Copyright © 2018年 USER. All rights reserved.
//

import UIKit

enum ImageMaskTransitionType {
    case present
    case dismiss
}

class ImageMaskAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var transitionConfig: TransitionConfig
    var type: ImageMaskTransitionType = .present
    var imageView: UIImageView?
    var maskContentView: UIImageView?
    
    init(config: TransitionConfig) {
        transitionConfig = config
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return type == .present ? TimeInterval(transitionConfig.presentDuration) : TimeInterval(transitionConfig.dismissDuration)
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let toView = transitionContext.view(forKey: .to), let fromView = transitionContext.view(forKey: .from) else {
            return
        }
        let frame = UIScreen.main.bounds
        maskContentView = UIImageView(frame: frame)
        maskContentView?.backgroundColor = UIColor.lightGray
        
        if type == .present {
            let fromImageView = transitionConfig.fromImageView
            fromImageView.isHidden = true
            let adjustFromRect = fromImageView.convert(fromImageView.bounds, to: containerView)
            let toImageView = transitionConfig.toImageView
            toImageView.isHidden = true
            
            maskContentView?.frame = containerView.bounds
            if let maskContentView = maskContentView {
                containerView.addSubview(maskContentView)
            }
            
            let adjustToRect = toImageView.convert(toImageView.bounds, to: containerView)
            imageView = UIImageView(frame: adjustFromRect)
            imageView?.image = fromImageView.image
            if let imageView = imageView {
                containerView.addSubview(imageView)
                imageView.layer.shadowColor = UIColor.black.cgColor
                imageView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
                imageView.layer.shadowRadius = 10.0
                imageView.layer.shadowOpacity = 0.8
            }
            UIView.animate(withDuration: TimeInterval(0.5 / 1.6 * transitionConfig.presentDuration), animations: {
                self.imageView?.frame = adjustToRect
                self.imageView?.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            }) { _ in
                UIView.animate(withDuration: TimeInterval(0.3 / 1.6 * self.transitionConfig.presentDuration), animations: {
                    self.imageView?.transform = CGAffineTransform.identity
                    self.imageView?.layer.shadowOpacity = 0.0
                }) { (finished) in
                    containerView.addSubview(toView)
                    if let imageView = self.imageView {
                        containerView.bringSubviewToFront(imageView)
                        let adjustFrame = imageView.convert(imageView.bounds, to: self.maskContentView)
                        toView.maskFrom(adjustFrame, duration: TimeInterval(0.8 / 1.6 * self.transitionConfig.presentDuration),complete: {
                            self.maskContentView?.removeFromSuperview()
                            self.imageView?.removeFromSuperview()
                            self.maskContentView = nil
                            self.imageView = nil
                            transitionContext.completeTransition(true)
                            toImageView.isHidden = false
                            fromImageView.isHidden = false
                        })
                    }
                }
            }
        } else {
            maskContentView?.frame = containerView.bounds
            if let maskContentView = maskContentView {
                containerView.addSubview(maskContentView)
            }
            let fromImageView = transitionConfig.fromImageView
            let toImageView = transitionConfig.toImageView
            fromImageView.isHidden = true
            toImageView.isHidden = true
            let adjustFromRect = fromImageView.convert(fromImageView.bounds, to: containerView)
            let adjustToRect = toImageView.convert(toImageView.bounds, to: containerView)
            imageView = UIImageView(frame:adjustToRect)
            if let imageView = imageView, let maskContentView = maskContentView {
                imageView.image = fromImageView.image
                containerView.addSubview(imageView)
                containerView.bringSubviewToFront(imageView)
                containerView.sendSubviewToBack(maskContentView)
                let adjustFrame = imageView.convert(imageView.bounds, to: maskContentView)
                fromView.maskTo(adjustFrame, duration: TimeInterval(0.8 / 1.3 * transitionConfig.dismissDuration),complete: {
                    imageView.layer.shadowColor = UIColor.black.cgColor
                    imageView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
                    imageView.layer.shadowRadius = 10.0
                    imageView.layer.shadowOpacity = 0.8
                    UIView.animate(withDuration: TimeInterval(0.5 / 1.3 * self.transitionConfig.dismissDuration), animations: {
                        imageView.frame = adjustFromRect
                    }) { (finished) in
                        maskContentView.removeFromSuperview()
                        imageView.removeFromSuperview()
                        containerView.addSubview(toView)
                        transitionContext.completeTransition(true)
                        toImageView.isHidden = false
                        fromImageView.isHidden = false
                    }
                })
            }
        }
    }
}
