//
//  CoreViewController.swift
//  animation
//
//  Created by USER on 2018/10/19.
//  Copyright © 2018年 USER. All rights reserved.
//

import UIKit

class CoreViewController: UITableViewController {
    
    lazy var emitterLayer: CAEmitterLayer = {
        let emitterLayer = CAEmitterLayer()
        emitterLayer.frame = view.bounds
        emitterLayer.masksToBounds = true
        emitterLayer.emitterShape = .line
        emitterLayer.emitterMode = .surface
        emitterLayer.emitterSize = view.bounds.size
        emitterLayer.emitterPosition = CGPoint(x: view.bounds.size.width / 2.0, y: -20)
        
        let rainflake = CAEmitterCell()
        rainflake.birthRate = 5
        rainflake.speed = 10
        rainflake.velocity = 10
        rainflake.velocityRange = 10
        rainflake.yAcceleration = 1000.0
        rainflake.contents = UIImage(named: "")
        rainflake.color = UIColor.white.cgColor
        rainflake.lifetime = 160
        rainflake.scale = 0.2
        rainflake.scaleRange = 0
        
        let snowflake = CAEmitterCell()
        snowflake.birthRate = 1
        snowflake.speed = 10
        snowflake.velocity = 2
        snowflake.velocityRange = 10
        snowflake.yAcceleration = 10
        snowflake.emissionRange = 0.5 * .pi
        snowflake.spinRange = 0.25 * .pi
        snowflake.contents = UIImage(named: "")
        snowflake.color = UIColor.cyan.cgColor
        rainflake.lifetime = 160
        snowflake.scale = 0.5
        snowflake.scaleRange = 0.3
        
        emitterLayer.emitterCells = [snowflake, rainflake]
        return emitterLayer
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        startCAEmitterLayer()
    }
    

}

extension CoreViewController {
    private func aniamtion() {
        let dashLineShapeLayer = CAShapeLayer()
        let dashLinePath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 200, height: 100), cornerRadius: 20)
        dashLineShapeLayer.path = dashLinePath.cgPath
        dashLineShapeLayer.position = CGPoint(x: 100, y: 100)
        dashLineShapeLayer.fillColor = UIColor.clear.cgColor
        dashLineShapeLayer.strokeColor = UIColor.orange.cgColor
        dashLineShapeLayer.lineWidth = 3
        dashLineShapeLayer.lineDashPattern = [6,6]
        dashLineShapeLayer.strokeStart = 0
        dashLineShapeLayer.strokeEnd = 1
        dashLineShapeLayer.zPosition = 999
        view.layer.addSublayer(dashLineShapeLayer)
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) {_ in
            let add:CGFloat = 3
            dashLineShapeLayer.lineDashPhase -= add
        }
    }
    
    private func startCAEmitterLayer() {
        let showRect = view.bounds
        let maskView = UIView(frame: showRect)
        maskView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.addSubview(maskView)
        maskView.layer.addSublayer(emitterLayer)
    }
    
}
