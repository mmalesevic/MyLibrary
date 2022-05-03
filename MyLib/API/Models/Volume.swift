//
//  Volume.swift
//  MyLib
//
//  Created by Matej Malesevic on 04.03.22.
//

import Foundation

struct VolumeResultModel: Codable {
    var kind: String
    var totalItems: Int
    var items: [Volume]?
}

struct Volume: Codable, Identifiable  {
    var selfLink: String?
    var volumeInfo: VolumeInfo?
    var kind: String?
    var id: String?
    var etag: String?
//    var pageCount: Int?
//    var printedPageCount: Int?
//    var dimensions: [String:String]?
//    var printType: String?
//    var categories: [String]?
//    var maturityRating: String?
//    var language: String?
//    var saleInfo: SaleInfo?
}

struct VolumeInfo: Codable {
    var title: String?
    var subtitle: String?
    var authors: [String]?
    var publisher: String?
    //var publishedDate: Date?
    var industryIdentifiers: [IndustryIdentifiers]?
}

struct IndustryIdentifiers: Codable {
    var type: String?
    var identifier: String?
}

struct SaleInfo: Codable {
    var country: String?
    var saleability: String?
    var isEbook: Bool?
}
