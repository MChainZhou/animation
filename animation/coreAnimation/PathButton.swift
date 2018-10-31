//
//  PathButton.swift
//  animation
//
//  Created by USER on 2018/10/23.
//  Copyright © 2018年 USER. All rights reserved.
//

import UIKit

protocol PathButtonDelegate: class {
    func pathButtonTappedAtIndex(index: Int)
}

class PathButton: UIView {

    weak var delegate: PathButtonDelegate?
    let bloomRadius: CGFloat = 100
    
    private var itemButtons: [PathItemButton] = [PathItemButton]()
    private var centerImage: UIImage?
    private var centerHighlightedImage: UIImage?
    private var foldedSize: CGSize?
    private var bloomSize: CGSize = UIScreen.main.bounds.size
    private var foldCenter: CGPoint?
    private var bloomCenter: CGPoint?
    private var isBloom: Bool = false
    private var pathCenterButtonBloomCenter: CGPoint?
    private var expandCenter:CGPoint?
    private var bottomView: UIView?
    private var pathCenterButton: PathCenterButton?
    
    
    init(centerImage: UIImage, centerHighlightedImage: UIImage) {
        super.init(frame: CGRect.zero)
        self.centerImage = centerImage
        self.centerHighlightedImage = centerHighlightedImage
        
        configureViewsLayout()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        pathCenterButtonFold()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension PathButton {
    func configureViewsLayout() {
        foldedSize = centerImage?.size
        foldCenter = CGPoint(x: bloomSize.width / 2, y: bloomSize.height - 225.5)
        bloomCenter = CGPoint(x: bloomSize.width / 2, y: bloomSize.height / 2)
        if let foldedSize = foldedSize {
            frame = CGRect(x: 0, y: 0, width: foldedSize.width, height: foldedSize.height)
        }
        if let foldCenter = foldCenter {
            center = foldCenter
        }
        
        pathCenterButton = PathCenterButton(image: centerImage, highlightedImage: centerHighlightedImage)
        pathCenterButton?.center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        pathCenterButton?.delegate = self
        if let pathCenterButton = pathCenterButton {
            addSubview(pathCenterButton)
        }
        bottomView = UIView(frame: CGRect(x: 0, y: 0, width: bloomSize.width, height: bloomSize.height))
        bottomView?.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        bottomView?.alpha = 0
    }
}

extension PathButton {
    func addPathItems(items: [PathItemButton]){
        itemButtons = items
    }
}

extension PathButton: PathCenterButtonDelegate, PathItemButtonDelegate {
    func itemButtonTapped(itemButton: PathItemButton) {
        var index = 0
        
        UIView.animate(withDuration: 0.0618 * 5) {
            itemButton.transform = CGAffineTransform.identity.scaledBy(x: 3, y: 3)
            itemButton.alpha = 0
        }
        for (i, item) in itemButtons.enumerated() {
            if itemButton == item {
                index = i
                continue
            }
            UIView.animate(withDuration: 0.0618 * 2) {
                itemButton.transform = CGAffineTransform.identity
            }
        }
        delegate?.pathButtonTappedAtIndex(index: index)
        pathCenterButtonFold()
    }
    
    func centerButtonTapped() {
        isBloom ? pathCenterButtonFold() : pathCenterButtonBloom()
    }
    
    private func pathCenterButtonFold() {
        for (index, item) in itemButtons.enumerated() {
            let currentAngel: CGFloat = CGFloat(index) / CGFloat((itemButtons.count + 1))
            let farPoint = createEndPointWithRadius(itemExpandRadius: bloomRadius + 5, angel: currentAngel)
            let animation = foldAnimation(endPoint: item.center, farPoint: farPoint)
            item.layer.add(animation, forKey: "")
            if let pathCenterButtonBloomCenter = pathCenterButtonBloomCenter {
                item.center = pathCenterButtonBloomCenter
            }
        }
        if let pathCenterButton = pathCenterButton {
            bringSubviewToFront(pathCenterButton)
        }
        
        resizeToFoldedFrame()
    }
    
    private func pathCenterButtonBloom() {
        pathCenterButtonBloomCenter = center
        frame = CGRect(x: 0, y: 0, width: bloomSize.width, height: bloomSize.height)
        center = CGPoint(x: bloomSize.width / 2, y: bloomSize.height / 2)
        if let bottomView = bottomView, let pathCenterButton = pathCenterButton  {
            insertSubview(bottomView, belowSubview: pathCenterButton)
        }
        
        UIView.animate(withDuration: 0.0618 * 3, delay: 0, options: .curveEaseIn, animations: {
            self.bottomView?.alpha = 0.618
        }, completion: nil)
        
        UIView.animate(withDuration: 0.1575) {
            self.pathCenterButton?.transform = CGAffineTransform.identity.rotated(by: -0.75 * .pi)
        }
        if let pathCenterButtonBloomCenter = pathCenterButtonBloomCenter {
            pathCenterButton?.center = pathCenterButtonBloomCenter
        }
        let basicAngel: CGFloat = CGFloat(180 / (self.itemButtons.count + 1))
        
        for (index, item) in itemButtons.enumerated() {
            item.delegate = self
            item.transform = CGAffineTransform.identity.translatedBy(x: 1, y: 1)
            item.alpha = 1
            let currentAngel: CGFloat = (basicAngel * CGFloat(index)) / 180
            if let pathCenterButtonBloomCenter = pathCenterButtonBloomCenter {
                item.center = pathCenterButtonBloomCenter
            }
            if let pathCenterButton = pathCenterButton {
                insertSubview(item, belowSubview: pathCenterButton)
            }
            let endPoint = createEndPointWithRadius(itemExpandRadius: bloomRadius, angel: currentAngel)
            let farPoint = createEndPointWithRadius(itemExpandRadius: bloomRadius + 10, angel: currentAngel)
            let nearPoint = createEndPointWithRadius(itemExpandRadius: bloomRadius - 5, angel: currentAngel)
            let animation = bloomAnimation(endPoint: endPoint, farPoint: farPoint, nearPoint: nearPoint)
            item.layer.add(animation, forKey: "bloomAnimation")
            item.center = endPoint
        }
        isBloom = true
    }
    
    
}


extension PathButton {
    private func createEndPointWithRadius(itemExpandRadius: CGFloat, angel: CGFloat) -> CGPoint {
        if let pathCenterButtonBloomCenter = pathCenterButtonBloomCenter {
            return CGPoint(x: pathCenterButtonBloomCenter.x - CGFloat(cosf(Float(angel * .pi))) * itemExpandRadius, y: pathCenterButtonBloomCenter.y - CGFloat(sinf(Float(angel * .pi))) * itemExpandRadius)
        }
        return CGPoint.zero
    }
    
    private func bloomAnimation(endPoint: CGPoint, farPoint: CGPoint, nearPoint: CGPoint) -> CAAnimationGroup {
        let rotationAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.values = [0, -CGFloat.pi, -CGFloat.pi * 1.5, -CGFloat.pi * 2]
        rotationAnimation.duration = 0.3
        rotationAnimation.keyTimes = [0, 0.3, 0.6, 1]
        
        let movingAnimation = CAKeyframeAnimation(keyPath: "position")
        let path = CGMutablePath()
        if let pathCenterButtonBloomCenter = pathCenterButtonBloomCenter {
            path.move(to: CGPoint(x: pathCenterButtonBloomCenter.x, y: pathCenterButtonBloomCenter.y))
        }
        path.addLine(to: farPoint)
        path.addLine(to: nearPoint)
        path.addLine(to: endPoint)
        
        movingAnimation.path = path
        movingAnimation.keyTimes = [0, 0.5, 0.7, 1]
        movingAnimation.duration = 0.3
        
        let animations = CAAnimationGroup()
        animations.animations = [movingAnimation, rotationAnimation]
        animations.duration = 0.3
        
        return animations
        
    }
    
    private func foldAnimation(endPoint: CGPoint, farPoint: CGPoint) -> CAAnimationGroup {
        let rotationAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.values = [0, CGFloat.pi, CGFloat.pi * 2]
        rotationAnimation.duration = 0.35
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
        
        let movingAnimation = CAKeyframeAnimation(keyPath: "position")
        let path = CGMutablePath()
        path.move(to: endPoint)
        path.addLine(to: farPoint)
        if let pathCenterButtonBloomCenter = pathCenterButtonBloomCenter {
            path.addLine(to: pathCenterButtonBloomCenter)
        }
        movingAnimation.keyTimes = [0, 0.75, 1.0]
        movingAnimation.duration = 0.35
        movingAnimation.path = path
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [movingAnimation, rotationAnimation]
        animationGroup.duration = 0.35
        return animationGroup
    }
    
    private func resizeToFoldedFrame() {
        UIView.animate(withDuration: 0.0618 * 3, delay: 0.0618 * 2, options: .curveEaseIn, animations: {
            self.pathCenterButton?.transform = CGAffineTransform.identity
        }, completion: nil)
        UIView.animate(withDuration: 0.1, delay: 0.35, options: .curveLinear, animations: {
            self.bottomView?.alpha = 0
        }, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            for item in self.itemButtons {
                item.removeFromSuperview()
            }
            self.frame = CGRect(x: 0, y: 0, width: self.foldedSize?.width ?? 0, height: self.foldedSize?.height ?? 0)
            self.center = self.foldCenter ?? CGPoint.zero
            self.pathCenterButton?.center = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
            self.bottomView?.removeFromSuperview()
        }
        isBloom = false
    }
}
