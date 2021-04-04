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

extension LocalGallery: PhotoSaver {
    public typealias SaveResult = Result<Void, Error>
    public func save(_ photo: Photo, completion: @escaping (SaveResult) -> Void) {
        store.insert(photo.toLocal(), completion: { error in
            completion(error)
        })
    }
}

extension LocalGallery: PhotoLoader {
    public typealias LoadResult = PhotoLoader.Result
    public func load(completion: @escaping (LoadResult) -> Void) {
        store.retrieve { result in
            switch result {
            case let .failure(error):
                completion(.failure(error))
                
            case let .success(.some(photos)):
                completion(.success(photos.toModels()))
                
            case .success:
                completion(.success([]))
            }
        }
    }
    
    
}

extension Photo {
    func toLocal() -> LocalPhoto {
        return LocalPhoto(name: name, date: date, image: image)
    }
}

private extension Array where Element == LocalPhoto {
    func toModels() -> [Photo] {
        return map{Photo(name: $0.name, date: $0.date, image: $0.image)}
    }
}
