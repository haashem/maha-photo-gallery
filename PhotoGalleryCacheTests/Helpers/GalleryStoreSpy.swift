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
        case insert(LocalPhoto)
        case retrieve
    }
    
    private(set) var receivedMessages = [ReceivedMessage]()
    
    private var insertionsCompletions = [InsertionCompletion]()
    
    func insert(_ photo: LocalPhoto, completion: @escaping InsertionCompletion) {
        insertionsCompletions.append(completion)
        receivedMessages.append(ReceivedMessage.insert(photo))
    }
    
    func completeInsertion(with error: NSError, at index: Int = 0) {
        insertionsCompletions[index](.failure(error))
    }
    
    func retrieve(completion: @escaping RetrievalCompletion) {
        
    }
    
}
