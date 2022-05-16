//
//  APIResponseHandler.swift
//  MyLib
//
//  Created by Matej Malesevic on 15.05.22.
//

import Foundation
import os.log

protocol APIResponseInterceptorProtocol {
    func intercept(response: HTTPURLResponse?) throws
}

class APIResponseInterceptor: APIResponseInterceptorProtocol {
    func intercept(response: HTTPURLResponse?) throws {
        
        guard let response = response else {
            throw ApiError.noResult
        }
        
        switch response.statusCode {
        case 200..<400:
            return
        case 404:
            os_log("Not Found URL: %@", log: .api, type: .error)
            throw ApiError.notFound(url: response.url)
        case 400..<500:
            throw ApiError.unspecifiedClientError
        case 500..<600:
            throw ApiError.unspecifiedServerError
        default:
            throw ApiError.unspecifiedError
        }
    }
}
