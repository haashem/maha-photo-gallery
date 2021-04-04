//
//  LocalGallery.swift
//  PhotoGalleryCache
//
//  Created by Hashem Aboonajmi on 4/4/21.
//

import PhotoGallery

public final class LocalGallery {
    private let store: GalleryStore
    public init(store: GalleryStore) {
        self.store = store
    }
}
