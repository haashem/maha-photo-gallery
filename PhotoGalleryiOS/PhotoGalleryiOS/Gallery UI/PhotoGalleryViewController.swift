//
//  PhotoGalleryViewController.swift
//  PhotoGalleryiOS
//
//  Created by Hashem Aboonajmi on 4/4/21.
//

import UIKit

protocol PhotoGalleryViewControllerDelegate {
    func didRequestLoadPhotos()
}


final public class PhotoGalleryViewController: UICollectionViewController {
    var delegate: PhotoGalleryViewControllerDelegate?
    var photos = [PhotoViewModel<UIImage>]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate?.didRequestLoadPhotos()
    }
    
    
    public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotoCell.self), for: indexPath) as! PhotoCell
        cell.nameLabel.text = photos[indexPath.row].name
        cell.imageView.image = photos[indexPath.row].image
        return cell
    }
}
