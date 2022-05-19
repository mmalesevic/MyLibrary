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
    
    func isValid() throws -> Bool {
        switch self {
        case .ISBN(let isbn):
            return try validateISBN(isbn)
        }
    }
    
    private func validateISBN(_ isbn: String) throws -> Bool {
        let regexer = try NSRegularExpression(pattern: #"^(?=(?:\D*\d){10}(?:(?:\D*\d){3})?$)[\d-]+$"#)
        let matches = regexer.matches(in: isbn, range: NSMakeRange(0, isbn.count))
        guard matches.count == 1 else {
            throw ValidationError.invalidFormat
        }
        return true
    }
}

extension String {
    func validate(_ validator: Validator) throws -> Bool {
        try validator.isValid()
    }
}
