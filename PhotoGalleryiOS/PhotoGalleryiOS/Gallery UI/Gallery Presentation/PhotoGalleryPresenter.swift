//
//  PhotoGalleryPresenter.swift
//  PhotoGalleryiOS
//
//  Created by Hashem Aboonajmi on 4/4/21.
//

import PhotoGalleryFeature

struct GalleryViewModel {
    let photos: [Photo]
}

protocol GalleryView {
    func display(_ viewModel: GalleryViewModel)
}

final class PhotoGalleryPresenter {
    let galleryView: GalleryView
    init(galleryView: GalleryView) {
        self.galleryView = galleryView
    }
    
    func didFinishLoadingPhotos(with photos: [Photo]) {
        galleryView.display(GalleryViewModel(photos: photos))
    }
}
