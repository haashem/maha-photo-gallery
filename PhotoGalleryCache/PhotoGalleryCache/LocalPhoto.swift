//
//  LocalPhoto.swift
//  PhotoGalleryCache
//
//  Created by Hashem Aboonajmi on 4/4/21.
//

import Foundation

public struct LocalPhoto: Equatable {
    public let name: String
    public let date: Date
    public let image: Data
    
    public init(name: String, date: Date, image: Data) {
        self.name = name
        self.date = date
        self.image = image
    }
}
