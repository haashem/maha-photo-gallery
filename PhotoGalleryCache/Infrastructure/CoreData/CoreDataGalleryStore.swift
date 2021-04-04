//
//  CoreDataGalleryStore.swift
//  PhotoGalleryCache
//
//  Created by Hashem Aboonajmi on 4/4/21.
//

import CoreData

public class CoreDataGalleryStore: GalleryStore {
    
    public init(){
        
    }
    
    public func insert(_ feed: LocalPhoto, insertionCompletion: @escaping InsertionCompletion) {
        
    }
    
    public func retrieve(completion: @escaping RetrievalCompletion) {
        
        completion(.success(.none))
        
    }
    
}
