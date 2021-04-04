//
//  GalleryStore.swift
//  PhotoGalleryCache
//
//  Created by Hashem Aboonajmi on 4/4/21.
//

import Foundation

public protocol GalleryStore {
    
    typealias InsertionResult = Result<Void, Error>
    typealias InsertionCompletion = (InsertionResult) -> Void
    
    func insert(_ feed: LocalPhoto, insertionCompletion: @escaping InsertionCompletion)
}
