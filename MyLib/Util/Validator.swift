//
//  Validator.swift
//  MyLib
//
//  Created by Matej Malesevic on 17.05.22.
//

import Foundation

enum ValidationError: Error {
    case invalidFormat
    case minimumLengthRequired
    case maximumLengthReached
}

enum Validator {
    case ISBN(_ isbn: String)
    
    func isValid() throws {
        switch self {
        case .ISBN(let isbn):
            try validateISBN(isbn)
        }
    }
    
    private func validateISBN(_ isbn: String) throws {
        let regexer = try NSRegularExpression(pattern: #"^(?=(?:\D*\d){10}(?:(?:\D*\d){3})?$)[\d-]+$"#)
        let matches = regexer.matches(in: isbn, range: NSMakeRange(0, isbn.count))
        guard matches.count == 1 else {
            throw ValidationError.invalidFormat
        }
    }
}
