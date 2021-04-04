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


