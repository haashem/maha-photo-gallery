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
    
    // MARK: - Helpers
    
    private func makeSut(currentDate: @escaping () -> Date = Date.init , file: StaticString = #file, line: UInt = #line) -> (sut: LocalGallery, store: GalleryStoreSpy) {
        let store = GalleryStoreSpy()
        let sut = LocalGallery(store: store)
        
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return (sut, store)
    }
}
