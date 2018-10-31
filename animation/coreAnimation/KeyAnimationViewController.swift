//
//  KeyAnimationViewController.swift
//  animation
//
//  Created by USER on 2018/10/22.
//  Copyright © 2018年 USER. All rights reserved.
//

import UIKit

class KeyAnimationViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupRedView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        redView.layer.removeAllAnimations()
    }
}

extension KeyAnimationViewController {
    private func setupRedView() {
        redView.frame = CGRect(x: view.bounds.width / 2 - 25, y: view.bounds.height / 2 - 25, width: 50, height: 50)
    }
}


extension KeyAnimationViewController {
    @objc override func operateTitleArray() -> [String] {
        return ["关键帧", "路径", "抖动"]
    }
    
    @objc override func clickBtn(btn: UIButton) {
        switch btn.tag {
        case 0:
            keyFrameAnimation()
        case 1:
            pathAnimation()
        case 2:
            shakeAniamtion()
        default:
            break
        }
    }
}

extension KeyAnimationViewController {
    private func keyFrameAnimation() {
        let animation = CAKeyframeAnimation(keyPath: "position")
        let value0 = CGPoint(x: 0, y: view.bounds.height / 2 - 50)
        let value1 = CGPoint(x: view.bounds.width / 3, y: view.bounds.height / 2 - 50)
        let value2 = CGPoint(x: view.bounds.width / 3, y: view.bounds.height / 2 + 50)
        let value3 = CGPoint(x: view.bounds.width * 2 / 3, y: view.bounds.height / 2 + 50)
        let value4 = CGPoint(x: view.bounds.width * 2 / 3, y: view.bounds.height / 2 - 50)
        let value5 = CGPoint(x: view.bounds.width * 2 / 3, y: view.bounds.height / 2 + 50)
        animation.values = [value0, value1, value2, value3, value4, value5]
        animation.duration = 2
        //定义动画的节奏
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        redView.layer.add(animation, forKey: "")
    }
    
    private func pathAnimation() {
        let animation = CAKeyframeAnimation(keyPath: "position")
        let path = UIBezierPath(ovalIn: CGRect(x: view.bounds.width / 2 - 100, y: view.bounds.height / 2 - 100, width: 200, height: 200))
        animation.path = path.cgPath
        animation.duration = 2.0
        redView.layer.add(animation, forKey: "")
    }
    
    private func shakeAniamtion() {
        let animation = CAKeyframeAnimation(keyPath: "transform.rotation")
        let value0 = -CGFloat.pi/180*4
        let value1 = CGFloat.pi/180*4
        let value2 = -CGFloat.pi/180*4
        animation.values = [value0, value1, value2]
        animation.repeatCount = MAXFLOAT
        redView.layer.add(animation, forKey: "")
    }
}

