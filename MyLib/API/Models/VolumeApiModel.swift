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

enum ISBNType: String {
    case isbn13 = "ISBN_13"
    case isbn10 = "ISBN_10"
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
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case subtitle = "subtitle"
        case authors = "authors"
        case publisher = "publisher"
        case publishedDate = "publishedDate"
        case industryIdentifiers = "industryIdentifiers"
        case imageLinks = "ImageLinks"
        case pageCount = "pageCount"
        case language = "language"
    }
    
    var isbn13: String? {
        return industryIdentifiers?.first(where: {$0.type == ISBNType.isbn13.rawValue})?.identifier
    }
    
    var thumbnailUrl: URL? {
        return imageLinks?.thumbnail
    }
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
