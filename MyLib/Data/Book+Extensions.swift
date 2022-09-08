//
//  Book+Extensions.swift
//  MyLib
//
//  Created by Matej Malesevic on 12.06.22.
//

import Foundation

extension Book {
    
    func map(from model: VolumeApiModel) {
        self.title = model.volumeInfo?.title ?? "title missing"
        self.subtitle = model.volumeInfo?.subtitle
        self.volumeId = model.id
        self.language = model.volumeInfo?.language
        self.isbn = model.volumeInfo?.isbn13
        self.pages = Int64(model.volumeInfo?.pageCount ?? 0)
        self.thumbnailUrl = model.volumeInfo?.thumbnailUrl?.absoluteString
        self.volumeId = model.id
    }
}
