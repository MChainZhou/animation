//
//  ComprehensiveCaseController.swift
//  animation
//
//  Created by USER on 2018/10/22.
//  Copyright © 2018年 USER. All rights reserved.
//

import UIKit

class ComprehensiveCaseController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupRedView()
        configureDCPathButton()
    }
}

extension ComprehensiveCaseController {
    private func setupRedView() {
        redView.isHidden = true
    }
    
    private func configureDCPathButton() {
        let pathButton = PathButton(centerImage: #imageLiteral(resourceName: "chooser-button-input"), centerHighlightedImage: #imageLiteral(resourceName: "chooser-button-input-highlighted"))
        pathButton.delegate = self
        let item1 = PathItemButton(image: #imageLiteral(resourceName: "chooser-moment-icon-music"), hightImage: #imageLiteral(resourceName: "chooser-moment-icon-music-highlighted"), backgroundImage: #imageLiteral(resourceName: "chooser-moment-icon-music"), backgroundHighlightedImage: #imageLiteral(resourceName: "chooser-moment-icon-music-highlighted"))
        let item2 = PathItemButton(image: #imageLiteral(resourceName: "chooser-moment-icon-place"), hightImage: #imageLiteral(resourceName: "chooser-moment-icon-place-highlighted"), backgroundImage: #imageLiteral(resourceName: "chooser-moment-icon-place"), backgroundHighlightedImage: #imageLiteral(resourceName: "chooser-moment-icon-place-highlighted"))
        let item3 = PathItemButton(image: #imageLiteral(resourceName: "chooser-moment-icon-camera"), hightImage: #imageLiteral(resourceName: "chooser-moment-icon-camera-highlighted"), backgroundImage: #imageLiteral(resourceName: "chooser-moment-icon-camera"), backgroundHighlightedImage: #imageLiteral(resourceName: "chooser-moment-icon-camera-highlighted"))
        let item4 = PathItemButton(image: #imageLiteral(resourceName: "chooser-moment-icon-thought"), hightImage: #imageLiteral(resourceName: "chooser-moment-icon-thought-highlighted"), backgroundImage: #imageLiteral(resourceName: "chooser-moment-icon-thought"), backgroundHighlightedImage: #imageLiteral(resourceName: "chooser-moment-icon-thought-highlighted"))
        let item5 = PathItemButton(image: #imageLiteral(resourceName: "chooser-moment-icon-sleep"), hightImage: #imageLiteral(resourceName: "chooser-moment-icon-sleep-highlighted"), backgroundImage: #imageLiteral(resourceName: "chooser-moment-icon-sleep"), backgroundHighlightedImage: #imageLiteral(resourceName: "chooser-moment-icon-sleep-highlighted"))
        pathButton.addPathItems(items: [item1, item2, item3, item4, item5])
        view.addSubview(pathButton)
    }
}

extension ComprehensiveCaseController: PathButtonDelegate {
    func pathButtonTappedAtIndex(index: Int) {
        print("click index:\(index)")
    }    
}

