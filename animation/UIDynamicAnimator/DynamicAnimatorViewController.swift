//
//  DynamicAnimatorViewController.swift
//  animation
//
//  Created by USER on 2018/10/31.
//  Copyright © 2018 USER. All rights reserved.
//

import UIKit

class DynamicAnimatorViewController: BaseViewController {
    
    var animator: UIDynamicAnimator?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        redView.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        animator = UIDynamicAnimator(referenceView: view)
    }

}


extension DynamicAnimatorViewController {
    override func operateTitleArray() -> [String]? {
        return ["重力", "弹力", "吸附力", "推力", "甩行力"]
    }
    override func clickBtn(btn: UIButton) {
        switch btn.tag {
        case 0:
            gravityAnimator()
        case 1:
            collisionAnimator()
        case 2:
            attachmentAnimator()
//        case 3:
//        case 4:
        default:
            break
        }
    }
    
    private func gravityAnimator() {
        let gravity = UIGravityBehavior(items: [redView])
        gravity.setAngle(CGFloat.pi / 2, magnitude: 0.5)
        animator?.addBehavior(gravity)
    }
    
    private func collisionAnimator() {
        let collision = UICollisionBehavior(items: [redView])
//        collision.addBoundary(withIdentifier: "123ß" as NSCopying, from: CGPoint(x: 0, y: 300), to: CGPoint(x: 300, y: 600))
        collision.collisionMode = .everything
        collision.translatesReferenceBoundsIntoBoundary = true
        animator?.addBehavior(collision)
    }
    
    private func attachmentAnimator() {
        let attachment = UIAttachmentBehavior(item: view, attachedToAnchor: CGPoint(x: 100, y: 200))
        attachment.length = 100
        animator?.addBehavior(attachment)
    }
}
