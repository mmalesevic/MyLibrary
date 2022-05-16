//
//  MockUrlSession.swift
//  MyLib
//
//  Created by Matej Malesevic on 15.05.22.
//

import Foundation

class MockUrlSession: URLSessionProtocol {
    
    var responseData: Data
    var urlResponse: URLResponse
    
    init?(responseData: Data, urlString: String = "https://malesevic.ch", urlResponseCode: Int) {
        self.responseData = responseData
        guard let url = URL(string: urlString) else { return nil }
        guard let urlResponse: URLResponse = HTTPURLResponse(url: url, statusCode: urlResponseCode, httpVersion: nil, headerFields: nil) else { return nil }
        
        self.urlResponse = urlResponse
    }
    
    init?(filename: String, urlString: String = "https://malesevic.ch", urlResponseCode: Int) {
        guard let fileUrl = Bundle.main.url(forResource: filename, withExtension: "json") else { return nil }
        guard let url = URL(string: urlString) else { return nil }
        guard let urlResponse: URLResponse = HTTPURLResponse(url: url, statusCode: urlResponseCode, httpVersion: nil, headerFields: nil) else { return nil }
        
        do {
            self.responseData = try Data(contentsOf: fileUrl)
        } catch {
            return nil
        }
        
        self.urlResponse = urlResponse
    }
    
    func data(from url: URL, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse) {
        return (responseData, urlResponse)
    }
    
    public func data(for request: URLRequest, delegate: URLSessionTaskDelegate? = nil) async throws -> (Data, URLResponse) {
        return (responseData, urlResponse)
    }
}
