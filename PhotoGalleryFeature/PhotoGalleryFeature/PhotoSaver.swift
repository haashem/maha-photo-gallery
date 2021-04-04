//
//  PhotoSaver.swift
//  PhotoGallery
//
//  Created by Hashem Aboonajmi on 4/4/21.
//

import Foundation

public protocol PhotoSaver {
    typealias SaveResult = Result<Void, Error>
    func save(_ photo: Photo, completion: @escaping (SaveResult) -> Void)
}
