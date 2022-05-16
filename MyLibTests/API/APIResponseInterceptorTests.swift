//
//  APIResponseInterceptorTests.swift
//  MyLibTests
//
//  Created by Matej Malesevic on 15.05.22.
//

import XCTest
@testable import MyLib

class APIResponseInterceptorTests: XCTestCase {
    
    func testNoResponse() async throws {

        let sut = APIResponseInterceptor()
        
        XCTAssertThrowsError(try sut.intercept(response: nil)) {error in
            XCTAssert(error is ApiError)
            let apiError = error as! ApiError
            XCTAssert(apiError == .noResult)
        }
    }
    
    func testSuccessfulResponse() async throws {
        guard let url = URL(string: "https://malesevic.ch") else {
            throw ApiError.invalidUrl
        }
        let response = HTTPURLResponse(url: url, statusCode: Int.random(in: 200..<400), httpVersion: nil, headerFields: nil)
        let sut = APIResponseInterceptor()
        
        XCTAssertNoThrow(try sut.intercept(response: response))
    }
    
    func test400ResponseRange() async throws {
        guard let url = URL(string: "https://malesevic.ch") else {
            throw ApiError.invalidUrl
        }
        let sut = APIResponseInterceptor()
        
        let specifiedHttpCodes = [404]
        
        for httpCode in 400..<500 {
            guard !specifiedHttpCodes.contains(httpCode) else { break }
            
            let response = HTTPURLResponse(url: url, statusCode: httpCode, httpVersion: nil, headerFields: nil)
            
            XCTAssertThrowsError(try sut.intercept(response: response), "handling error") { error in
                XCTAssert(error is ApiError, "Not the expectedType APIError")
                let apiError = error as! ApiError
                XCTAssertTrue(apiError == ApiError.unspecifiedClientError, "not expected error kind for httpCode: \(httpCode)")
            }
        }
    }
    
    func test404Response() async throws {
        guard let url = URL(string: "https://malesevic.ch") else {
            throw ApiError.invalidUrl
        }
        let sut = APIResponseInterceptor()
        
        let response = HTTPURLResponse(url: url, statusCode: 404, httpVersion: nil, headerFields: nil)
        
        XCTAssertThrowsError(try sut.intercept(response: response), "handling error") { error in
            XCTAssert(error is ApiError, "Not the expectedType APIError")
            let apiError = error as! ApiError
            XCTAssertTrue(apiError == ApiError.notFound(url: url), "not expected error kind for httpCode: 404")
        }
    }
    
    func test500ResponseRange() async throws {
        guard let url = URL(string: "https://malesevic.ch") else {
            throw ApiError.invalidUrl
        }
        let sut = APIResponseInterceptor()
        
        for httpCode in 500..<600 {
            let response = HTTPURLResponse(url: url, statusCode: httpCode, httpVersion: nil, headerFields: nil)
            
            XCTAssertThrowsError(try sut.intercept(response: response), "handling error") { error in
                XCTAssert(error is ApiError, "Not the expectedType APIError")
                let apiError = error as! ApiError
                XCTAssertTrue(apiError == ApiError.unspecifiedServerError, "not expected error kind")
            }
        }
    }
    
    func test900Response() async throws {
        guard let url = URL(string: "https://malesevic.ch") else {
            throw ApiError.invalidUrl
        }
        let sut = APIResponseInterceptor()
        
        let response = HTTPURLResponse(url: url, statusCode: 900, httpVersion: nil, headerFields: nil)
        
        XCTAssertThrowsError(try sut.intercept(response: response), "handling error") { error in
            XCTAssert(error is ApiError, "Not the expectedType APIError")
            let apiError = error as! ApiError
            XCTAssertTrue(apiError == ApiError.unspecifiedError, "not expected error kind for httpCode: 404")
        }
    }
}
