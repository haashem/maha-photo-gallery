//
//  Composers.swift
//  PhotoGalleryiOS
//
//  Created by Hashem Aboonajmi on 4/4/21.
//

import UIKit
import PhotoGalleryFeature

public final class GalleryUIComposer {
    private init() {}
    
    public static func photoGalleryComposedWith(photoLoader: PhotoLoader, photoSaver: PhotoSaver) -> PhotoGalleryViewController {
        
        let bundle = Bundle(for: PhotoGalleryViewController.self)
        let storyboard = UIStoryboard(name: "PhotoGallery", bundle: bundle)
        let feedController = storyboard.instantiateInitialViewController() as! PhotoGalleryViewController
        return feedController
    }
    
}
