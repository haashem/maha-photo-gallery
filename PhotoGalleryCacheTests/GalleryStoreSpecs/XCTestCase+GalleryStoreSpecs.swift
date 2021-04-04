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
    
    func assertThatInsertDeliversNoErrorOnEmptyCache(on sut: GalleryStore, file: StaticString = #file, line: UInt = #line) {
        
        let insertionError = insert(samplePhoto(), to: sut)
        XCTAssertNil(insertionError, "Expected to insert photo successfully")
    }
    
    func assertThatInsertDeliversNoErrorOnNonEmptyCache(on sut: GalleryStore, file: StaticString = #file, line: UInt = #line) {
        insert(samplePhoto(), to: sut)
        let insertionError = insert(samplePhoto(), to: sut)
        XCTAssertNil(insertionError, "Expected to override cache successfully")
    }

    @discardableResult
    func insert(_ photo: LocalPhoto, to sut: GalleryStore) -> Error? {
       
       let exp = expectation(description: "Wait for photo inserion")
       var insertionError: Error?
        sut.insert(photo) { result in
            if case let Result.failure(error) = result { insertionError = error }
               exp.fulfill()
        }
       
       wait(for: [exp], timeout: 1.0)
       
        return insertionError
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
