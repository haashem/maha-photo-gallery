//
//  XCTestCase+GalleryStoreSpecs.swift
//  PhotoGalleryCacheTests
//
//  Created by Hashem Aboonajmi on 4/4/21.
//

import XCTest
import PhotoGalleryCache

extension GalleryStoreSpecs where Self: XCTestCase {
    
    func assertThatRetrieveDeliversEmptyOnEmptyCache(on sut: GalleryStore, file: StaticString = #file, line: UInt = #line) {
        expect(sut, toRetrieve: .success(.none), file: file, line: line)
    }
    
    func expect(_ sut: GalleryStore, toRetrieve expectedResult: GalleryStore.RetrievalResult, file: StaticString = #file, line: UInt = #line) {
       let exp = expectation(description: "Wait for cache retrieval")
       
       sut.retrieve{ retrievedResult in
           switch (retrievedResult, expectedResult) {
           case (.success(.none), .success(.none)),
                (.failure, .failure):
               break
           case let (.success(.some(expectedPhotos)), .success(.some(retrievedPhotos))):
            XCTAssertEqual(expectedPhotos, retrievedPhotos, file: file, line: line)
          
           default:
               XCTFail("Expected to retrieve \(expectedResult), got \(retrievedResult) instead", file: file, line: line)
           }
           exp.fulfill()
       }
       wait(for: [exp], timeout: 1.0)
    }

}
