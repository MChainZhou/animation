//
//  PopViewController.swift
//  animation
//
//  Created by USER on 2018/10/24.
//  Copyright © 2018年 USER. All rights reserved.
//

import UIKit

class PopViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
//        let delegate = NavigationDelegate()
//        navigationController?.delegate = delegate
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
