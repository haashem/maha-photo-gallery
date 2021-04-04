//
//  PhotoGalleryCacheTestHelpers.swift
//  PhotoGalleryCacheTests
//
//  Created by Hashem Aboonajmi on 4/4/21.
//

import Foundation
import PhotoGalleryCache
import PhotoGallery

func samplePhoto() -> (model: Photo, local: LocalPhoto) {
    let date = Date()
    return (Photo(name: "any", date: date, image: Data()), LocalPhoto(name: "any", date: date, image: Data()))
}


