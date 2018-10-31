//
//  BasicAnimationViewController.swift
//  animation
//
//  Created by USER on 2018/10/22.
//  Copyright © 2018年 USER. All rights reserved.
//

import UIKit

class BasicAnimationViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupRedView()
    }
}


// MARK: 搭建UI
extension BasicAnimationViewController {
    private func setupRedView() {
        redView.frame = CGRect(x: view.bounds.width / 2 - 50, y: view.bounds.height / 2 - 100, width: 100, height: 100)
    }
}

extension BasicAnimationViewController {
    @objc override func operateTitleArray() -> [String] {
        return ["位移", "透明度", "缩放", "旋转", "背景色"]
    }
    
    @objc override func clickBtn(btn: UIButton) {
        switch btn.tag {
        case 0:
            positionAnimation()
        case 1:
            opacityAniamtion()
        case 2:
            scaleAnimation()
        case 3:
            rotateAnimation()
        case 4:
            backgroundAnimation()
        default:
            break
        }
    }
}

// MARK: 基础动画
extension BasicAnimationViewController {
    private func positionAnimation() {
        let basicAnimation = CABasicAnimation(keyPath: "position")
        basicAnimation.fromValue = CGPoint(x: 0, y: view.bounds.height / 2.0 - 75)
        basicAnimation.toValue = CGPoint(x: view.bounds.width, y: view.bounds.height / 2.0 - 75)
        basicAnimation.duration = 1.0
        // 两个属性联合使用，才能始动画完成结束后保持结束时的状态
//        basicAnimation.isRemovedOnCompletion = false
//        basicAnimation.fillMode = .forwards
//        basicAnimation.autoreverses = false
        
        //定义动画的节奏
        basicAnimation.timingFunction = CAMediaTimingFunction(name: .easeIn)
        redView.layer.add(basicAnimation, forKey: "")
    }
    
    private func opacityAniamtion() {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 1.0
        animation.toValue = 0.2
        animation.duration = 1.0
        redView.layer.add(animation, forKey: "")
    }
    
    private func scaleAnimation() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = 2.0
        animation.duration = 1.0
        redView.layer.add(animation, forKey: "")
    }
    
    private func rotateAnimation() {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.toValue = CGFloat.pi
        animation.duration = 1.0
        redView.layer.add(animation, forKey: "")
    }
    
    private func backgroundAnimation() {
        let animation = CABasicAnimation(keyPath: "backgroundColor")
        animation.toValue = UIColor.green.cgColor
        animation.duration = 1.0
        redView.layer.add(animation, forKey: "")
    }
}
