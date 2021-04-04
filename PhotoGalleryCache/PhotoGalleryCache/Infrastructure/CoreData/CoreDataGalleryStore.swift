//
//  CoreDataGalleryStore.swift
//  PhotoGalleryCache
//
//  Created by Hashem Aboonajmi on 4/4/21.
//

import CoreData

public class CoreDataGalleryStore: GalleryStore {
    
    private let container: NSPersistentContainer
    private let context: NSManagedObjectContext
    
    public init(storeURL: URL, bundle: Bundle = .main) throws {
        container = try NSPersistentContainer.load(modelName: "GalleryStore", url: storeURL, in: bundle)
        context = container.newBackgroundContext()
     }
    
    public func insert(_ photo: LocalPhoto, completion: @escaping InsertionCompletion) {
        perform { context in
            completion(Result {
                _ = ManagedPhoto.fromLocal(photo, in: context)
                try context.save()
             })
         }
    }
    
    public func retrieve(completion: @escaping RetrievalCompletion) {
        perform { context in
            completion(Result {
                try ManagedPhoto.find(in: context).map {
                 return $0.local
                }
            })
        }
    }
    
    private func perform(_ action: @escaping (NSManagedObjectContext) -> Void) {
         let context = self.context
         context.perform { action(context) }
     }
    
}
