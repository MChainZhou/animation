//
//  TabBarViewController.swift
//  animation
//
//  Created by USER on 2018/10/24.
//  Copyright © 2018年 USER. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    private var panGesture: UIPanGestureRecognizer = UIPanGestureRecognizer()
    let tabBarDelegate = TabBarVCDelegate()
    private var subViewControllerCount: Int {
        let count = viewControllers != nil ? viewControllers!.count : 0
        return count
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = tabBarDelegate
        
        panGesture.addTarget(self, action: #selector(TabBarViewController.handlePan(panGesture:)))
        view.addGestureRecognizer(panGesture)
    }
    

   
    @objc func handlePan(panGesture: UIPanGestureRecognizer){
        let translationX =  panGesture.translation(in: view).x
        let translationAbs = translationX > 0 ? translationX : -translationX
        let progress = translationAbs / view.frame.width
        switch panGesture.state {
        case .began:
            tabBarDelegate.interactive = true
            let velocityX = panGesture.velocity(in: view).x
            if velocityX < 0 {
                if selectedIndex < subViewControllerCount - 1 {
                    selectedIndex += 1
                }
            } else {
                if selectedIndex > 0 {
                    selectedIndex -= 1
                }
            }
        case .changed:
            tabBarDelegate.interactionController.update(progress)
        case .cancelled, .ended:
            if progress > 0.3 {
                tabBarDelegate.interactionController.completionSpeed = 0.99
                tabBarDelegate.interactionController.finish()
            } else {
                //转场取消后，UITabBarController 自动恢复了 selectedIndex 的值，不需要我们手动恢复。
                tabBarDelegate.interactionController.completionSpeed = 0.99
                tabBarDelegate.interactionController.cancel()
            }
            tabBarDelegate.interactive = false
        default: break
        }
    }

}
