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

extension LocalGallery {
    public typealias SaveResult = Result<Void, Error>
    public func save(_ photo: Photo, completion: @escaping (SaveResult) -> Void) {
        store.insert(photo.toLocal(), completion: { error in
            
        })
    }
}

extension Photo {
    func toLocal() -> LocalPhoto {
        return LocalPhoto(name: name, date: date, image: image)
    }
}

