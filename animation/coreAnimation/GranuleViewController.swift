//
//  GranuleViewController.swift
//  animation
//
//  Created by USER on 2018/10/23.
//  Copyright © 2018年 USER. All rights reserved.
//

import UIKit

class GranuleViewController: UIViewController {
    
    var fireEmitter: CAEmitterLayer?
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        setupSnow()
        setupUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let fireEmitter = fireEmitter {
            fireEmitter.birthRate = 0
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        if let fireEmitter = fireEmitter {
            fireEmitter.birthRate = 0
        }
        fireEmitter?.removeFromSuperlayer()
    }
    
    deinit {
        if let fireEmitter = fireEmitter {
            fireEmitter.birthRate = 0
        }
        fireEmitter?.removeFromSuperlayer()
    }
}

extension GranuleViewController {
    
    private func setupSnow() {
        let emitter = CAEmitterLayer()
        emitter.emitterPosition = CGPoint(x: 0, y: 0) // 发射粒子的位置
        emitter.emitterSize = view.bounds.size // 范围
        emitter.emitterShape = .rectangle // 粒子形状
        
        let emitterCell = CAEmitterCell() // 创建粒子
        let image:UIImage = #imageLiteral(resourceName: "chooser-moment-button")
        emitterCell.contents = image.cgImage // 载入粒子图片
        emitterCell.birthRate = 100 // 每秒释放多少个粒子
        emitterCell.lifetime = 3.5 // 每个粒子的生命周期
        emitterCell.color = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor // 粒子的颜色
        emitterCell.redRange = 0.0 // RGBA设置
        emitterCell.blueRange = 0.1
        emitterCell.greenRange = 0.0
        emitterCell.alphaRange = 0.5
        emitterCell.velocity = 9.8 // 重力加速度也就是物理里面G
        emitterCell.velocityRange = 550 // 加速范围
        emitterCell.emissionRange = CGFloat.pi * 0.5 // 下落是旋转的角度
        emitterCell.emissionLongitude = -CGFloat.pi //
        emitterCell.yAcceleration = 70
        emitterCell.xAcceleration = 0
        emitterCell.scale = 0.33 // 发射比例
        emitterCell.scaleRange = 1.25
        emitterCell.scaleSpeed = -0.25
        emitterCell.alphaRange = 0.5 // 透明度调整
        emitterCell.alphaSpeed = -0.15
        
        emitter.emitterCells = [emitterCell] // 载入
        view.layer.addSublayer(emitter)
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.black

        let fireEmitter = CAEmitterLayer()
        // 粒子发射位置
        fireEmitter.emitterPosition = CGPoint(x: view.bounds.width / 2, y: view.bounds.height / 2 - 20)
        // 发射源的尺寸大小
        fireEmitter.emitterSize = CGSize(width: view.bounds.width - 100, height: 20)
        // 发射模式
        fireEmitter.renderMode = .additive

        let fire = CAEmitterCell()
        // 粒子参数的速度乘数因子
        fire.birthRate = 800
        fire.lifetime = 2.0
        fire.lifetimeRange = 1.5
        fire.color = #colorLiteral(red: 0.8, green: 0.4, blue: 0.2, alpha: 1).cgColor
        let image: UIImage = #imageLiteral(resourceName: "chooser-moment-icon-music-highlighted")
        fire.contents = image.cgImage
        fire.velocity = 160
        fire.velocityRange = 80
        fire.emissionLongitude = CGFloat.pi + CGFloat.pi * 0.5
        fire.emissionRange = CGFloat.pi * 0.5
        fire.scale = 0.3
        fire.spin = 0.2
        
        let smoke = CAEmitterCell()
        smoke.birthRate = 400
        smoke.lifetime = 3.0
        smoke.lifetimeRange = 1.5
        smoke.color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5).cgColor
        smoke.contents = image.cgImage
        smoke.velocity = 250
        smoke.velocityRange = 100
        smoke.emissionLongitude = CGFloat.pi + CGFloat.pi * 0.5
        smoke.emissionRange = CGFloat.pi * 0.5
        fireEmitter.emitterCells = [fire, smoke]
        view.layer.addSublayer(fireEmitter)

        self.fireEmitter = fireEmitter
    }
}
