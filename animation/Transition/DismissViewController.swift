//
//  DismissViewController.swift
//  animation
//
//  Created by USER on 2018/10/23.
//  Copyright © 2018年 USER. All rights reserved.
//

import UIKit

class DismissViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let transition = Transition()
        transitioningDelegate = transition
        dismiss(animated: true, completion: nil)
    }
    
}

