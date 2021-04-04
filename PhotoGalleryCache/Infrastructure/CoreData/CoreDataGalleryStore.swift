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
    
    public func insert(_ photo: LocalPhoto, completion: @escaping InsertionCompletion) {
        completion(.success(()))
    }
    
    public func retrieve(completion: @escaping RetrievalCompletion) {
        
        completion(.success(.none))
        
    }
    
}
