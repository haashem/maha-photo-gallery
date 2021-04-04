//
//  CachePhotoUseCaseTests.swift
//  PhotoGalleryCacheTests
//
//  Created by Hashem Aboonajmi on 4/4/21.
//

import XCTest
import PhotoGalleryCache

class CachePhotoUseCaseTests: XCTestCase {
    
    func test_init_doesNotMessageStoreUponCreation() {
        let (_, store) = makeSut()
        
        XCTAssertEqual(store.receivedMessages, [])
    }
    
    func test_save_requestsNewPhotoInsertion() {
        
        let (sut, store) = makeSut()
        let photo = samplePhoto()
        sut.save(photo.model) {_ in }
        
        XCTAssertEqual(store.receivedMessages, [.insert(photo.local)])
    }
    
    func test_save_failsOnInsertionError() {
        let (sut, store) = makeSut()
        let insertionError = anyNSError()
        expect(sut, toCompleteWithError: insertionError, when: { store.completeInsertion(with: insertionError)
        })
    }
    
    func test_save_successOnSuccessfulCacheInsertion() {
        let (sut, store) = makeSut()
        
        expect(sut, toCompleteWithError: nil, when: {
            store.completeInsertionSuccessfully()
        })
    }
    
    private func expect(_ sut: LocalGallery, toCompleteWithError expectedError: NSError?, when action: () -> Void, file: StaticString = #file, line: UInt = #line) {
        let exp = expectation(description: "wait for save completion")
        
        var receivedError: Error?
        sut.save(samplePhoto().model) { result in
            if case let Result.failure(error) = result { receivedError = error }
            exp.fulfill()
        }
        
        action()
        wait(for: [exp], timeout: 1.0)
        
        XCTAssertEqual(receivedError as NSError?, expectedError, file: file, line: UInt(line))
    }
    
    // MARK: - Helpers
    
    private func makeSut(currentDate: @escaping () -> Date = Date.init , file: StaticString = #file, line: UInt = #line) -> (sut: LocalGallery, store: GalleryStoreSpy) {
        let store = GalleryStoreSpy()
        let sut = LocalGallery(store: store)
        
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return (sut, store)
    }
}
