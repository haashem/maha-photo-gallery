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
        let sut = makeSUT()

        assertThatInsertDeliversNoErrorOnEmptyCache(on: sut)
    }
    
    func test_insert_deliversNoErrorOnNonEmptyCache() {
        let sut = makeSUT()

        assertThatInsertDeliversNoErrorOnNonEmptyCache(on: sut)
    }
    
    private func makeSUT(file: StaticString = #file, line: Int = #line) -> GalleryStore {
        
         
         let sut = CoreDataGalleryStore()
         
         return sut
     }
    
}
