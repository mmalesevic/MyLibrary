//
//  ApiError.swift
//  MyLib
//
//  Created by Matej Malesevic on 04.03.22.
//

import Foundation
import SwiftUI

enum ApiError: Error, Equatable {
    case invalidUrl
    case notFound(url: URL?)
    case noResult
    case unexpectedResponse
    case invalidResponse(responseData: Data?)
    case unspecifiedClientError
    case unspecifiedServerError
    case unspecifiedError
    case invalidRequest
}
