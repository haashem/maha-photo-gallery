//
//  GalleryStoreSpecs.swift
//  PhotoGalleryCacheTests
//
//  Created by Hashem Aboonajmi on 4/4/21.
//

import Foundation

protocol GalleryStoreSpecs {
    
    func test_retrieve_deliversEmptyOnEmptyCache()
    func test_retrieveـdeliversFoundValuesOnNonEmptyCache()
    
    func test_insert_deliversNoErrorOnEmptyCache()
    func test_insert_deliversNoErrorOnNonEmptyCache()
}
