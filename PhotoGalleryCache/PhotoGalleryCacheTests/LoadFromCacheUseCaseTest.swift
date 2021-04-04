//
//  LoadFromCacheUseCaseTest.swift
//  PhotoGalleryCacheTests
//
//  Created by Hashem Aboonajmi on 4/4/21.
//

import XCTest
import PhotoGalleryCache

class LoadFromCacheUseCaseTest: XCTestCase {
    
    func test_init_doesNotMessageStoreUponCreation() {
        let (_, store) = makeSut()
        
        XCTAssertEqual(store.receivedMessages, [])
    }
    
    func test_load_requestsCachRetreival() {
        let (sut, store) = makeSut()
        sut.load {_ in}
        
        XCTAssertEqual(store.receivedMessages, [.retrieve])
    }
    
    func test_load_failsOnRetrievalError() {
        let (sut, store) = makeSut()
        let retrievalError = anyNSError()
        
        expect(sut, toCompleteWith: .failure(retrievalError), when: {
            store.completeRetrieval(with: retrievalError)
        })
    }
    
    func test_load_deliversNoImageOnEmptyCache() {
        let (sut, store) = makeSut()
        expect(sut, toCompleteWith: .success([]), when: {
            store.completeRetrievalWithEmptyCache()
        })
    }
    
    func test_load_deliversCachedImages() {
        
        let (sut, store) = makeSut()
        let photo = samplePhoto()
        
        expect(sut, toCompleteWith: .success([photo.model]), when: {
            store.completeRetrieval(with: [photo.local])
        })
    }
    
    func test_load_doesNotDeliverResultAfterSUTInstanceHasBeenDeallocated() {
        let store = GalleryStoreSpy()
        var sut: LocalGallery? = LocalGallery(store: store)
        
        var receivedResults = [LocalGallery.LoadResult]()
        sut?.load { receivedResults.append($0) }
        sut = nil
        
        store.completeRetrievalWithEmptyCache()
        XCTAssertTrue(receivedResults.isEmpty)
    }
    
    // MARK: - Helpers
    
    private func makeSut(file: StaticString = #file, line: UInt = #line) -> (sut: LocalGallery, store: GalleryStoreSpy) {
        let store = GalleryStoreSpy()
        let sut = LocalGallery(store: store)
        
        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(store, file: file, line: line)
        return (sut, store)
    }
    
    private func expect(_ sut: LocalGallery, toCompleteWith expectedResult: LocalGallery.LoadResult, when action: () -> Void, file: StaticString = #file, line: UInt = #line) {
        
        let exp = expectation(description: "wait for load completion")
        
        sut.load { receivedResult in
            switch (receivedResult, expectedResult) {
            case let (.success(receivedImages), .success(expectedImages)):
                XCTAssertEqual(receivedImages, expectedImages, file: file, line: line)
            case let (.failure(recievedError), .failure(expectedError)):
                XCTAssertEqual(recievedError as NSError, expectedError as NSError, file: file, line: line)
            default:
                XCTFail("Expected result \(expectedResult), got \(receivedResult) instead", file: file, line: line)
            }
            exp.fulfill()
        }

        action()
        wait(for: [exp], timeout: 1.0)
    }
   
}
