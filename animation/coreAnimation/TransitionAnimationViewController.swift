//
//  TransitionAnimationViewController.swift
//  animation
//
//  Created by USER on 2018/10/22.
//  Copyright © 2018年 USER. All rights reserved.
//

import UIKit

class TransitionAnimationViewController: BaseViewController {
    
    var index = 0
    lazy var label: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: redView.bounds.width / 2 - 10, y: redView.bounds.height / 2 - 20, width: 20, height: 40)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupRedView()
    }
}

// MARK: UI
extension TransitionAnimationViewController {
    private func setupRedView() {
        redView.frame = CGRect(x: view.bounds.width / 2 - 90, y: view.bounds.height / 2 - 130, width: 180, height: 260)
        redView.addSubview(label)
    }
}

// MARK:
extension TransitionAnimationViewController {
    @objc override func operateTitleArray() -> [String] {
        return ["fade", "moveIn", "push", "reveal", "cube", "suck", "oglFlip", "ripple", "Curl", "UnCurl", "caOpen", "caClose"]
    }
    
    @objc override func clickBtn(btn: UIButton) {
        switch btn.tag {
        case 0:
          fadeAnimation()
        case 1:
            moveInAnimation()
        case 2:
            pushAnimation()
        case 3:
            revealAnimation()
        case 4:
            cubeAnimation()
        case 5:
            suckAnimation()
        case 6:
            oglFlipAnimation()
        case 7:
            rippleAnimation()
        case 8:
            curlAnimation()
        case 9:
            unCurlAnimation()
        case 10:
            caOpenAnimation()
        case 11:
            caCloseAnimation()
        default:
            break
        }
    }
}

// MARK: 动画
extension TransitionAnimationViewController {
    private func fadeAnimation() {
        animation(type: .fade)
    }
    
    private func moveInAnimation() {
        animation(type: .moveIn)
    }
    
    private func pushAnimation() {
        animation(type: .push)
    }
    
    private func revealAnimation() {
        animation(type: .reveal)
    }
    
    private func cubeAnimation() {
        changeView(isUp: true)
        animation(type: CATransitionType(rawValue: "cube"))
    }
    
    private func suckAnimation() {
        animation(type: CATransitionType(rawValue: "suckEffect"))
    }
    
    private func oglFlipAnimation() {
        animation(type: CATransitionType(rawValue: "oglFlip"))
    }
    
    private func rippleAnimation() {
        animation(type: CATransitionType(rawValue: "rippleEffect"))
    }
    
    private func curlAnimation() {
        animation(type: CATransitionType(rawValue: "pageCurl"))
    }
    
    private func unCurlAnimation() {
        animation(type: CATransitionType(rawValue: "pageUnCurl"))
    }
    
    private func caOpenAnimation() {
        animation(type: CATransitionType(rawValue: "cameraIrisHollowOpen"))
    }
    
    private func caCloseAnimation() {
        animation(type: CATransitionType(rawValue: "cameraIrisHollowClose"))
    }
    
    private func animation(type: CATransitionType, subType: CATransitionSubtype = CATransitionSubtype.fromRight, duration: CFTimeInterval = 1.0) {
        changeView(isUp: true)
        let animation = CATransition()
        //设置动画的类型
        animation.type = type
        //设置动画的方向
        animation.subtype = subType
        animation.duration = duration
        redView.layer.add(animation, forKey: "")
    }
}

// MARK: 私有方法
extension TransitionAnimationViewController {
    private func changeView(isUp: Bool) {
        if index > 3 {
            index = 0
        }
        if index < 0 {
            index = 3
        }
        
        let colors = [#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1), #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)]
        let titles = ["1", "2", "3", "4"]
        redView.backgroundColor = colors[index]
        label.text = titles[index]
        
        isUp ? (index += 1) : (index -= 1)
        
    }
}

