//
//  PresentViewController.swift
//  animation
//
//  Created by USER on 2018/10/23.
//  Copyright © 2018年 USER. All rights reserved.
//

import UIKit

///1.modalTransitionStyle 属性
/**
 typedef NS_ENUM(NSInteger, UIModalTransitionStyle) {
 UIModalTransitionStyleCoverVertical = 0,  //从下向上弹起  默认项
 UIModalTransitionStyleFlipHorizontal __TVOS_PROHIBITED, //水平翻转
 UIModalTransitionStyleCrossDissolve,    //渐隐渐现
 UIModalTransitionStylePartialCurl NS_ENUM_AVAILABLE_IOS(3_2) __TVOS_PROHIBITED, //翻页
 }
 */

class PresentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}


extension PresentViewController {
    @IBAction func clickBtn(_ sender: UIButton) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DismissViewController") as? DismissViewController {
            let transition = Transition()
            vc.transitioningDelegate = transition
            vc.modalPresentationStyle = .custom
            present(vc, animated: true, completion: nil)
        }
    }
}
