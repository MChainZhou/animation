//
//  GroupAnimationViewController.swift
//  animation
//
//  Created by USER on 2018/10/22.
//  Copyright © 2018年 USER. All rights reserved.
//

import UIKit

class GroupAnimationViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupRedView()
    }
}

extension GroupAnimationViewController {
    private func setupRedView(){
        redView.frame = CGRect(x: view.bounds.width / 2 - 25, y: view.bounds.height / 2 - 25, width: 50, height: 50)
    }
}

extension GroupAnimationViewController {
    @objc override func operateTitleArray() -> [String] {
        return ["同时", "连续"]
    }
    
    @objc override func clickBtn(btn: UIButton) {
        switch btn.tag {
        case 0:
            meanwhileGroupAniamtion()
        case 1:
            continuousGroupAnimation()
        default:
            break
        }
    }
}

extension GroupAnimationViewController {
    private func meanwhileGroupAniamtion() {
        let positionAnimation = CAKeyframeAnimation(keyPath: "position")
        let value0 = CGPoint(x: 0, y: view.bounds.width / 2 - 50)
        let value1 = CGPoint(x: view.bounds.width / 3, y: view.bounds.width / 2 - 50)
        let value2 = CGPoint(x: view.bounds.width / 3, y: view.bounds.width / 2 + 50)
        let value3 = CGPoint(x: view.bounds.width * 2 / 3, y: view.bounds.width / 2 - 50)
        let value4 = CGPoint(x: view.bounds.width * 2 / 3, y: view.bounds.width / 2 + 50)
        let value5 = CGPoint(x: view.bounds.width, y: view.bounds.width / 2 - 50)
        positionAnimation.values = [value0, value1, value2, value3, value4, value5]
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 0.8
        scaleAnimation.toValue = 2
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.toValue = CGFloat.pi * 4
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [positionAnimation, scaleAnimation, rotationAnimation]
        groupAnimation.duration = 4
        redView.layer.add(groupAnimation, forKey: "")
    }
    
    private func continuousGroupAnimation() {
        
        let positionAnimation = CABasicAnimation(keyPath: "position")
        positionAnimation.fromValue = CGPoint(x: 0, y: view.bounds.height / 2 - 75)
        positionAnimation.toValue = CGPoint(x: view.bounds.width / 2, y: view.bounds.height / 2 - 75)
        positionAnimation.beginTime = 0
        positionAnimation.duration = 1.0
        positionAnimation.fillMode = .forwards
        positionAnimation.isRemovedOnCompletion = false
//        redView.layer.add(positionAnimation, forKey: nil)
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 0.8
        scaleAnimation.toValue = 2
        scaleAnimation.beginTime = 1
        scaleAnimation.duration = 1
        scaleAnimation.fillMode = .forwards
        scaleAnimation.isRemovedOnCompletion = false
//        redView.layer.add(scaleAnimation, forKey: nil)
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.beginTime = 2
        rotationAnimation.toValue = CGFloat.pi * 4
        rotationAnimation.fillMode = .forwards
        rotationAnimation.duration = 2.0
        rotationAnimation.isRemovedOnCompletion = false
//        redView.layer.add(rotationAnimation, forKey: nil)
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [positionAnimation, scaleAnimation, rotationAnimation]
        groupAnimation.duration = 3
        redView.layer.add(groupAnimation, forKey: "")
    }
}
