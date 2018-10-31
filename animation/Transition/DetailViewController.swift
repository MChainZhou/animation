//
//  DetailViewController.swift
//  animation
//
//  Created by USER on 2018/10/25.
//  Copyright © 2018年 USER. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    lazy var imageView: UIImageView = {
        let itemImageView = UIImageView()
        itemImageView.image = UIImage(named: "movie.jpg")
        itemImageView.frame = CGRect(x: 0, y: 0, width: 80, height: 124)
        itemImageView.center = CGPoint(x: 60, y: 200)
        return itemImageView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.frame = view.bounds
        scroll.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        scroll.contentSize = CGSize(width: view.bounds.size.width , height: view.bounds.size.height * 2)
        scroll.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(back))
        scroll.addGestureRecognizer(tap)
        return scroll
    }()
    
    lazy var topImageView: UIImageView = {
        let topImageView = UIImageView()
        topImageView.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width,height: 200)
        topImageView.image = UIImage(named: "topImage.jpg")
        return topImageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    deinit {
        navigationController?.delegate = nil
    }
}

extension DetailViewController {
    func setupUI() {
        
        if #available(iOS 11, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        }
        
        view.addSubview(scrollView)
        scrollView.addSubview(topImageView)
        scrollView.addSubview(imageView)
    }
    
    @objc func back() {
        dismiss(animated: true, completion: nil)
    }
}
