//
//  ApiManager.swift
//  MyLib
//
//  Created by Matej Malesevic on 04.03.22.
//

import Foundation
import os.log

protocol ApiRequestProtocol {
    func getRequest<T: Codable>(_ url:URL?) async throws -> T
}

class ApiRequest: NSObject, ApiRequestProtocol {
    
    let session: URLSessionProtocol
    let responseInterceptor: APIResponseInterceptorProtocol
    
    init(urlSession: URLSessionProtocol, responseInterceptor: APIResponseInterceptorProtocol) {
        self.session = urlSession
        self.responseInterceptor = responseInterceptor
    }
    
    internal func getRequest<T: Codable>(_ url:URL?) async throws -> T {
        
        guard let url = url else {
            os_log("invalid URL: %@", log: .api, type: .error, url?.absoluteString ?? "-")
            throw ApiError.invalidUrl
        }
        var urlRequest = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 30.0)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        let (data, urlResponse) = try await session.data(for: urlRequest, delegate: nil)
        
        try responseInterceptor.intercept(response: urlResponse as? HTTPURLResponse)
        
        do {
            os_log("JSON Response: %@", log: OSLog.api, type: .debug, data.prettyPrintedJSONString)
            let responseObjecct = try JSONDecoder().decode(T.self, from: data)
            return responseObjecct
        } catch DecodingError.typeMismatch( _, let context) {
            os_log("parsing error, type mismatch error: %@", log: OSLog.api, type: .error, "\(context.codingPath)")
            throw ApiError.invalidResponse(responseData: data)
        } catch DecodingError.valueNotFound(let type, _) {
            os_log("parsing error, value not found: %@", log: OSLog.api, type: .error, "\(type)")
            throw ApiError.invalidResponse(responseData: data)
        } catch DecodingError.keyNotFound(let codingKey, _) {
            os_log("parsing error, key not found: %@", log: OSLog.api, type: .error, "\(codingKey)")
            throw ApiError.invalidResponse(responseData: data)
        } catch {
            os_log("parsing error, unknown error %@", log: OSLog.api, type: .error, error.localizedDescription)
            throw error
        }
        
    }
}
