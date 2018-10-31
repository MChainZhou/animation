//
//  NavigationDelegate.swift
//  animation
//
//  Created by USER on 2018/10/24.
//  Copyright © 2018年 USER. All rights reserved.
//

import UIKit

class NavigationDelegate: NSObject, UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let transition = PushPopTransition()
        transition.isPush = operation == .push
        return transition
    }
}

