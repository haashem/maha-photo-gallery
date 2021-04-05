//
//  PhotoDetailsViewController.swift
//  PhotoGalleryiOS
//
//  Created by Hashem Aboonajmi on 4/5/21.
//

import UIKit

final public class PhotoDetailsViewController: UIViewController {
    @IBOutlet private(set) public var imageView: UIImageView!
    @IBOutlet private(set) public var dateLabel: UILabel!
    
    var viewModel: PhotoViewModel<UIImage>?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel?.name
        imageView.image = viewModel?.image
        dateLabel.text = viewModel?.date
    }
}
