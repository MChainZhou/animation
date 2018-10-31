//
//  TransitionCollectionViewController.swift
//  animation
//
//  Created by USER on 2018/10/25.
//  Copyright © 2018年 USER. All rights reserved.
//

import UIKit

class TransitionCollectionViewControllerCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
}

class TransitionCollectionViewController: UICollectionViewController {

    var delegate: ImageMaskTransition?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        delegate = nil
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as? TransitionCollectionViewControllerCell {
            return cell
        }
        return UICollectionViewCell()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detail = DetailViewController()
        if let cell = collectionView.cellForItem(at: indexPath) as? TransitionCollectionViewControllerCell {
            delegate = ImageMaskTransition(fromImageView: cell.imageView, toImageView: detail.imageView)
            detail.transitioningDelegate = delegate
            present(detail, animated: true, completion: nil)
//            navigationController?.delegate = delegate
        }
//        navigationController?.pushViewController(detail, animated: true)
        
    }

}
