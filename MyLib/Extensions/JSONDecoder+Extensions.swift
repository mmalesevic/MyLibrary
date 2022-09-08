//
//  JSONDecoder+Extensions.swift
//  MyLib
//
//  Created by Matej Malesevic on 12.05.22.
//

import Foundation
enum JSONDecoderError: Error {
    case fileNotFound(filename: String)
}

extension JSONDecoder {
    
    func loadObjectFromFile<T: Codable>(bundle: Bundle = Bundle.main, fileName: String) throws -> T {
        guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
            throw JSONDecoderError.fileNotFound(filename: fileName)
        }
        let data = try Data(contentsOf: url)
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}
