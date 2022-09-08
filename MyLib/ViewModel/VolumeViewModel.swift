//
//  VolumeViewModel.swift
//  MyLib
//
//  Created by Matej Malesevic on 04.03.22.
//

import Foundation
import SwiftUI

@MainActor class VolumeViewModel: NSObject, ObservableObject {
    
    var apiRequest: ApiRequestProtocol
    
    init(apiRequest: ApiRequestProtocol) {
        self.apiRequest = apiRequest
    }
    
    func lookupISBN(_ isbn: String) async throws -> [VolumeApiModel] {
        guard !isbn.isEmpty else {
            throw ApiError.noResult
        }
        
        try Validator.ISBN(isbn).isValid()
        
        var urlComponents = URLComponents(string: "https://books.googleapis.com/books/v1/volumes")
        urlComponents?.queryItems = [URLQueryItem]()
        urlComponents?.queryItems?.append(URLQueryItem(name: "q", value: "isbn:\(isbn)"))
        
        let volume: VolumeApiModel.APIResult = try await apiRequest.getRequest(urlComponents?.url)
        
        guard let items = volume.items, volume.totalItems > 0 else {
            throw ApiError.noResult
        }
        
        return items
    }
    
}
