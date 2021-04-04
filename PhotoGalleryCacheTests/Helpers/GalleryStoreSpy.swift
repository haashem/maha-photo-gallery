//
//  GalleryStoreSpy.swift
//  PhotoGalleryCacheTests
//
//  Created by Hashem Aboonajmi on 4/4/21.
//

import Foundation
import PhotoGalleryCache

class GalleryStoreSpy: GalleryStore {
    
    enum ReceivedMessage: Equatable {
        case insert(LocalPhoto, Date)
        case retrieve
    }
    
    private(set) var receivedMessages = [ReceivedMessage]()
    
    func insert(_ photo: LocalPhoto, completion: @escaping InsertionCompletion) {
        
    }
    
    func retrieve(completion: @escaping RetrievalCompletion) {
        receivedMessages.append(.retrieve)
    }
}
