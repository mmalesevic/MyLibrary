//
//  Volume.swift
//  MyLib
//
//  Created by Matej Malesevic on 04.03.22.
//

import Foundation

struct VolumeApiModel: Codable, Identifiable  {
    var selfLink: String?
    var volumeInfo: VolumeInfoApiModel?
    var kind: String?
    var id: String?
    var etag: String?
    var searchInfo: SearchInfo?
}

extension VolumeApiModel {
    struct APIResult: Codable {
        var kind: String
        var totalItems: Int
        var items: [VolumeApiModel]?
    }
}

struct VolumeInfoApiModel: Codable {
    var title: String?
    var subtitle: String?
    var authors: [String]?
    var publisher: String?
    var publishedDate: String?
    var industryIdentifiers: [IndustryIdentifiersApiModel]?
    var imageLinks: ImageLinks?
    var pageCount: Int?
    var language: String?
}

struct ImageLinks: Codable {
    var smallThumbnail: URL?
    var thumbnail: URL?
    var small: URL?
    var medium: URL?
    var large: URL?
    var extraLarge: URL?
}

struct IndustryIdentifiersApiModel: Codable {
    var type: String?
    var identifier: String?
}

struct SaleInfoApiModel: Codable {
    var country: String?
    var saleability: String?
    var isEbook: Bool?
}

struct SearchInfo: Codable {
    var textSnippet: String?
}
