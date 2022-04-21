//
//  VolumeViewModel.swift
//  MyLib
//
//  Created by Matej Malesevic on 04.03.22.
//

import Foundation
import SwiftUI

class VolumeViewModel: NSObject, ObservableObject {
    
    var apiRequest: ApiRequestProtocol
    @Published var volumes: [Volume]
    @Published var isSearching: Bool
    
    init(apiRequest: ApiRequestProtocol) {
        self.apiRequest = apiRequest
        volumes = [Volume]()
        isSearching = false
    }
    
    @MainActor
    func lookupISBN(_ isbn: String) async throws {
        var urlComponents = URLComponents(string: "https://books.googleapis.com/books/v1/volumes")
        urlComponents?.queryItems = [URLQueryItem]()
        urlComponents?.queryItems?.append(URLQueryItem(name: "q", value: "isbn:\(isbn)"))

        isSearching = true
        let volume: VolumeResultModel = try await apiRequest.getRequest(urlComponents?.url)
        isSearching = false
        
        self.volumes.append(contentsOf: volume.items)
    }
    
}
