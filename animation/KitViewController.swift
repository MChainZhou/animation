//
//  KitViewController.swift
//  animation
//
//  Created by USER on 2018/10/19.
//  Copyright © 2018年 USER. All rights reserved.
//

import UIKit

class MyView: UIView {
    var reverse = false
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let frame = bounds.insetBy(dx: 10, dy: 10)
        let content = UIGraphicsGetCurrentContext()
        
        if reverse {
            content?.strokeEllipse(in: frame)
        } else {
            content?.stroke(frame)
        }
    }
    
}

class KitViewController: BaseViewController {
    
    lazy var animationView: MyView = {
        let animationView = MyView(frame: CGRect(x: 50, y: 100, width: 50, height: 50))
        animationView.backgroundColor = UIColor.green
        return animationView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension KitViewController {
    private func setupUI() {
        redView.isHidden = true
        view.addSubview(animationView)
    }
}

extension KitViewController {
    override func operateTitleArray() -> [String]? {
        return ["动画", "关键帧", "阻尼", "过度", "还原"]
    }
    
    override func clickBtn(btn: UIButton) {
        switch btn.tag {
        case 0:
            animation()
        case 1:
            animationKeyframes()
        case 2:
            animationUsingSpringWithDamping()
        case 3:
            transitonsAnimation()
        case 4:
            restore()
        default: break
        }
    }
}


extension KitViewController {
    private func restore() {
        UIView.animate(withDuration: 1) {
            self.animationView.transform = CGAffineTransform.identity
            self.animationView.frame = CGRect(x: 50, y: 100, width: 50, height: 50)
        }
    }
    
    //基本动画
    private func animation() {
        ///transform的缩放、平移、旋转
        UIView.animate(withDuration: 2) {
            self.animationView.transform = CGAffineTransform.identity
                .translatedBy(x: 100, y: 0)
                .rotated(by: CGFloat(Double.pi/4))
                .scaledBy(x: 0.5, y: 0.5)
        }
    }
    
    //关键帧动画
    private func animationKeyframes() {
        UIView.animateKeyframes(withDuration: 3, delay: 0, options: .calculationModePaced, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2, animations: {
                self.animationView.frame.origin.y = 500
            })
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.5, animations: {
                self.animationView.frame.origin.x = 300
            })
            UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.3, animations: {
                self.animationView.frame.origin.y = 300
            })
        }, completion: nil)
    }
    
    //弹簧的阻尼动画
    private func animationUsingSpringWithDamping() {
        UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.animationView.frame.origin.x = 300
        }, completion: nil)
    }
    
    //Transitions过度动画
    private func transitonsAnimation() {
        animationView.reverse = !animationView.reverse
        UIView.transition(with: animationView, duration: 0.5, options: .transitionFlipFromLeft, animations: {
            self.animationView.setNeedsDisplay()
        }, completion: nil)
    }
}






//UIView.beginAnimations("", context: nil)
//UIView.setAnimationDelegate(self)
//UIView.commitAnimations()

///基本使用
///withDuration:动画执行的时间
///animations:动画执行的block
//        UIView.animate(withDuration: <#T##TimeInterval#>, animations: <#T##() -> Void#>)

///withDuration:动画执行的时间
///animations:动画执行的block
///completion:动画完成的回调
//        UIView.animate(withDuration: <#T##TimeInterval#>, animations: <#T##() -> Void#>, completion: <#T##((Bool) -> Void)?##((Bool) -> Void)?##(Bool) -> Void#>)

///withDuration:动画执行的时间
///delay:在开始动画执行的时间
///options:动画执行方式选项
///animations:动画执行的block
///completion:动画完成的回调
//        UIView.animate(withDuration: <#T##TimeInterval#>, delay: <#T##TimeInterval#>, options: <#T##UIView.AnimationOptions#>, animations: <#T##() -> Void#>, completion: <#T##((Bool) -> Void)?##((Bool) -> Void)?##(Bool) -> Void#>)

/// 下面两个方法成组使用
/**
 *  添加关键帧方法
 *
 *  @param duration   动画时长
 *  @param delay      动画延迟
 *  @param options    动画效果选项
 *  @param animations 动画执行代码
 *  @param completion 动画结束执行代码
 */
//        UIView.animateKeyframes(withDuration: <#T##TimeInterval#>, delay: <#T##TimeInterval#>, options: <#T##UIView.KeyframeAnimationOptions#>, animations: <#T##() -> Void#>, completion: <#T##((Bool) -> Void)?##((Bool) -> Void)?##(Bool) -> Void#>)
/**
 *  添加关键帧
 *
 *  @param frameStartTime 动画相对开始时间，取值为0-1.0
 *  @param frameDuration  动画相对持续时间，取值为0-1.0
 *  @param animations     动画执行代码
 */
//        UIView.addKeyframe(withRelativeStartTime: <#T##Double#>, relativeDuration: <#T##Double#>, animations: <#T##() -> Void#>)


///withDuration:动画时间
///delay:开始执行动画的时间
///usingSpringWithDamping:当弹簧动画接近静止状态时的阻尼比
///initialSpringVelocity:初始弹簧速度
//        UIView.animate(withDuration: <#T##TimeInterval#>, delay: <#T##TimeInterval#>, usingSpringWithDamping: <#T##CGFloat#>, initialSpringVelocity: <#T##CGFloat#>, options: <#T##UIView.AnimationOptions#>, animations: <#T##() -> Void#>, completion: <#T##((Bool) -> Void)?##((Bool) -> Void)?##(Bool) -> Void#>)
///在动画过程中，首先将 fromView 从父视图中删除，然后将 toView 添加，就是做了一个替换操作。
//UIView.transition(from: , to: , duration: , options: , completion: )
