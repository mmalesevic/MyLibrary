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
    @Published var volumes: [Volume]
    @Published var isSearching: Bool
    
    init(apiRequest: ApiRequestProtocol) {
        self.apiRequest = apiRequest
        volumes = [Volume]()
        isSearching = false
    }
    
    func lookupISBN(_ isbn: String) async throws {
        var urlComponents = URLComponents(string: "https://books.googleapis.com/books/v1/volumes")
        urlComponents?.queryItems = [URLQueryItem]()
        urlComponents?.queryItems?.append(URLQueryItem(name: "q", value: "isbn:\(isbn)"))

        self.volumes.removeAll()
        
        isSearching = true
        let volume: VolumeResultModel = try await apiRequest.getRequest(urlComponents?.url)
        isSearching = false
        
        guard let items = volume.items, volume.totalItems > 0 else {
            throw ApiError.noResult
        }
        
        self.volumes.append(contentsOf: items)
    }
    
}
