//
//  TransitionViewController.swift
//  animation
//
//  Created by USER on 2018/10/19.
//  Copyright © 2018年 USER. All rights reserved.
//

import UIKit

class TransitionViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            if let vc = UIStoryboard(name: "Slide", bundle: nil).instantiateInitialViewController() {
                present(vc, animated: true, completion: nil)
            }
        }
    }
}
