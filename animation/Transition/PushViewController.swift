//
//  PushViewController.swift
//  animation
//
//  Created by USER on 2018/10/24.
//  Copyright © 2018年 USER. All rights reserved.
//

import UIKit

class PushViewController: UIViewController {

    let delegate = NavigationDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let popVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopViewController") as? PopViewController {
            navigationController?.delegate = delegate
            navigationController?.pushViewController(popVc, animated: true)
        }
    }

}
