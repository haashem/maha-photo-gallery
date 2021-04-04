//
//  PhotoLoader.swift
//  PhotoGallery
//
//  Created by Hashem Aboonajmi on 4/4/21.
//

import Foundation

public protocol PhotoLoader {
    typealias Result = Swift.Result<[Photo], Error>
    func load(completion: @escaping (Result) -> Void)
}
