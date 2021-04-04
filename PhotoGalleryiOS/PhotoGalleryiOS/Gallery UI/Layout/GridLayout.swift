//
//  GridLayout.swift
//  PhotoGalleryiOS
//
//  Created by Hashem Aboonajmi on 4/4/21.
//

import UIKit

class GridLayout: UICollectionViewFlowLayout {
   
    override func prepare() {
        
        super.prepare()
        
        guard let collectionView = collectionView else {
            return
        }
        
        minimumInteritemSpacing = 2
        minimumLineSpacing = 2
        sectionInset = UIEdgeInsets(top: minimumLineSpacing, left: 0, bottom: 0, right: 0)
        // each row has 3 photo cell
        let width: CGFloat = (collectionView.frame.size.width - (2 * minimumInteritemSpacing) - 1)/3.0
        itemSize = CGSize(width: width, height: width)
        
    }
}

