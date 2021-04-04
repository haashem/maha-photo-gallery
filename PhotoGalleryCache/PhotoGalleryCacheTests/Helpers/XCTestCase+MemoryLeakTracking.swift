//
//  XCTestCase+MemoryLeakTracking.swift
//  PhotoGalleryCacheTests
//
//  Created by Hashem Aboonajmi on 4/4/21.
//

import XCTest

extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: #file, line: #line)
        }
    }
}
