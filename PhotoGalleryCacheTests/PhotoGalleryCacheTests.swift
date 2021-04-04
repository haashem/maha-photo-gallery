//
//  PhotoGalleryCacheTests.swift
//  PhotoGalleryCacheTests
//
//  Created by Hashem Aboonajmi on 4/4/21.
//

import XCTest
import PhotoGalleryCache

class PhotoGalleryCacheTests: XCTestCase, GalleryStoreSpecs {
    func test_retrieve_deliversEmptyOnEmptyCache() {
        let sut = makeSUT()

        assertThatRetrieveDeliversEmptyOnEmptyCache(on: sut)
    }
    
    func test_retrieveـdeliversFoundValuesOnNonEmptyCache() {
        
    }
    
    func test_insert_deliversNoErrorOnEmptyCache() {
        
    }
    
    func test_insert_deliversNoErrorOnNonEmptyCache() {
        
    }
    
    private func makeSUT(file: StaticString = #file, line: Int = #line) -> GalleryStore {
        
         
         let sut = CoreDataGalleryStore()
         
         return sut
     }
    
}
