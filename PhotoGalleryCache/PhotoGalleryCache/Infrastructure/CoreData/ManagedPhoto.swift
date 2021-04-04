//
//  ManagedPhoto.swift
//  PhotoGalleryCache
//
//  Created by Hashem Aboonajmi on 4/4/21.
//

import CoreData

@objc(ManagedPhoto)
class ManagedPhoto: NSManagedObject {
  @NSManaged  var name: String
  @NSManaged  var date: Date
  @NSManaged  var image: Data
}

extension ManagedPhoto {
    static func fromLocal(_ localPhoto: LocalPhoto, in context: NSManagedObjectContext) -> ManagedPhoto {
       let managed = ManagedPhoto(context: context)
        managed.name = localPhoto.name
        managed.date = localPhoto.date
        managed.image = localPhoto.image
        return managed
   }
    
    static func find(in context: NSManagedObjectContext) throws -> [ManagedPhoto] {
       let request = NSFetchRequest<ManagedPhoto>(entityName: entity().name!)
        
       return try context.fetch(request)
   }
    
    var local: LocalPhoto {
       return LocalPhoto(name: name, date: date, image: image)
   }
}
