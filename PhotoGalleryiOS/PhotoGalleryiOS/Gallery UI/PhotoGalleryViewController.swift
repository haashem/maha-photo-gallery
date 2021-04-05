//
//  PhotoGalleryViewController.swift
//  PhotoGalleryiOS
//
//  Created by Hashem Aboonajmi on 4/4/21.
//

import UIKit

protocol PhotoGalleryViewControllerDelegate {
    func didRequestLoadPhotos()
    func didRequestSaveImage(image: UIImage, with name: String)
    func didSelectImage(at index: Int)
}


final public class PhotoGalleryViewController: UICollectionViewController {
    var delegate: PhotoGalleryViewControllerDelegate?
    private var photos = [PhotoViewModel<UIImage>]()
   
    func appened(_ newPhotos: [PhotoViewModel<UIImage>]) {
        let startIndex = self.photos.count
        let endIndex = startIndex + newPhotos.count
        photos += newPhotos
        
        collectionView.insertItems(at: (startIndex ..< endIndex).map { index in
            IndexPath(item: index, section: 0)
        })
    }
    
    private var imageToSave: UIImage?
    
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
    
    public override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectImage(at: indexPath.row)
    }
    
    @IBAction func selectPhoto(sender: UIBarButtonItem) {
        
        func selectPhoto(from source: UIImagePickerController.SourceType) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = source
            present(imagePicker, animated: true, completion: nil)
        }
        
        let actionSheetController = UIAlertController(title: nil, message: "Please select photo", preferredStyle: .actionSheet)
        //We need to provide a popover sourceView when using it on iPad
        actionSheetController.popoverPresentationController?.barButtonItem = sender
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {  action -> Void in
            // dismiss action sheet
        }
        
        let chooseFromGalleryAction = UIAlertAction(title: "Photo Gallery", style: .default) {
            action -> Void in
            selectPhoto(from: .photoLibrary)
        }
        let takePictureAction = UIAlertAction(title: "Camera", style: .default) {
            action -> Void in
            selectPhoto(from: .camera)
        }
        
        actionSheetController.addAction(chooseFromGalleryAction)
        actionSheetController.addAction(cancelAction)
        
        if UIImagePickerController.isCameraDeviceAvailable(.front) || UIImagePickerController.isCameraDeviceAvailable(.rear) {
            actionSheetController.addAction(takePictureAction)
        }
        
        present(actionSheetController, animated: true, completion: nil)
    }
    
}

extension PhotoGalleryViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        imageToSave = image
        showTextFieldForImageName()
    }
    
    func showTextFieldForImageName() {
        let alert = UIAlertController(title: "Name for image?", message: nil, preferredStyle: .alert)
        alert.addTextField()
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        alert.addAction(UIAlertAction(title: "Save photo", style: .default, handler: { _ in
            let name = alert.textFields![0].text
            self.delegate?.didRequestSaveImage(image: self.imageToSave!, with: name!)
        }))

        present(alert, animated: true)
    }
}
