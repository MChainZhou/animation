//
//  PathItemButton.swift
//  animation
//
//  Created by USER on 2018/10/23.
//  Copyright © 2018年 USER. All rights reserved.
//

import UIKit


protocol PathItemButtonDelegate: class {
    func itemButtonTapped(itemButton: PathItemButton)
}

class PathItemButton: UIImageView {

    var index: Int?
    weak var delegate: PathItemButtonDelegate?
    var backgroundImageView: UIImageView?
    
    
    init(image: UIImage, hightImage: UIImage, backgroundImage: UIImage, backgroundHighlightedImage: UIImage) {
        super.init(image: backgroundImage, highlightedImage: backgroundHighlightedImage)
        let itemFrame = CGRect(x: 0, y: 0, width: backgroundImage.size.width, height: backgroundImage.size.height)
        frame = itemFrame
        self.image = backgroundImage
        self.highlightedImage = backgroundHighlightedImage
        self.isUserInteractionEnabled = true
        backgroundImageView = UIImageView(image: image, highlightedImage: hightImage)
        backgroundImageView?.center = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isHighlighted = true
        backgroundImageView?.isHighlighted = true
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        isHighlighted = true
        backgroundImageView?.isHighlighted = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        delegate?.itemButtonTapped(itemButton: self)
        
        isHighlighted = false
        backgroundImageView?.isHighlighted = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
