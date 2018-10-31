//
//  BaseViewController.swift
//  animation
//
//  Created by USER on 2018/10/22.
//  Copyright © 2018年 USER. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    lazy var redView: UIView = {
        let redView = UIView()
        redView.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        return redView
    }()
    
    var operateTitles:[String]?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupUI()
    }

}


// MARK: 初始化数据和UI
extension BaseViewController {
    private func setupData() {
        operateTitles = operateTitleArray()
    }
    
    private func setupUI() {
        view.addSubview(redView)
        
        let maxColumnNum = 4
        let columnMargin = 20
        let rowMargin = 20
        
        if let operateTitles = operateTitles, !operateTitles.compactMap({$0}).isEmpty {
            let row = operateTitles.count % maxColumnNum == 0 ? operateTitles.count / maxColumnNum : operateTitles.count / maxColumnNum + 1
            let operateView = UIView()
            operateView.frame = CGRect(x: 0, y: view.bounds.height - (CGFloat(row) * 50 + 20), width: view.bounds.width, height: CGFloat(row) * 50 + 20)
            view.addSubview(operateView)
            let btnX: CGFloat = CGFloat(columnMargin)
            let btnY: CGFloat = CGFloat(rowMargin)
            let btnH: CGFloat = 30
            let btnW: CGFloat = (view.bounds.width - CGFloat((maxColumnNum + 1) * columnMargin)) / CGFloat(maxColumnNum)
            
            
            for (index, title) in operateTitles.enumerated() {
                let btn = UIButton()
                btn.setTitle(title, for: .normal)
                btn.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                btn.tag = index
                btn.frame = CGRect(x: btnX + CGFloat(index%maxColumnNum) * (btnW + CGFloat(columnMargin)), y: btnY + CGFloat(index/maxColumnNum) * (btnH + CGFloat(rowMargin)), width: btnW, height: btnH)
                operateView.addSubview(btn)
                btn.addTarget(self, action: #selector(clickBtn(btn:)), for: .touchUpInside)
            }
        }
    }
}


// MARK: 外部公开方法
extension BaseViewController {
    @objc func operateTitleArray() -> [String]? {
        return nil
    }
    
    @objc func clickBtn(btn: UIButton) {
        
    }
}
