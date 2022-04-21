//
//  ApiError.swift
//  MyLib
//
//  Created by Matej Malesevic on 04.03.22.
//

import Foundation
import SwiftUI

enum ApiError: Error {
    case invalidUrl
    case notFound(url: URL?)
    case noResult
    case unexpectedResponse
    case unspecifiedClientError
    case unspecifiedServerError
    case unspecifiedError
}
