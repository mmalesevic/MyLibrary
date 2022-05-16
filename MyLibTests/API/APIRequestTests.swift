//
//  APIRequestTests.swift
//  MyLibTests
//
//  Created by Matej Malesevic on 12.05.22.
//

import XCTest
@testable import MyLib

class APIRequestTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRequestInvalidUrl() async throws {
        guard let mockUrlSession = MockUrlSession(filename: "VolumeApiModel", urlString: "https://malesevic.ch", urlResponseCode: 200) else {
            throw ApiError.unspecifiedError
        }
        let sut = ApiRequest(urlSession: mockUrlSession, responseInterceptor: APIResponseInterceptor())

        do {
            let _: VolumeApiModel.APIResult = try await sut.getRequest(nil)
        } catch {
            XCTAssert(error is ApiError)
            let apiError = error as! ApiError
            XCTAssertEqual(apiError, .invalidUrl)
        }
    }
    
    func testRequestSucccessful() async throws {
        guard let mockUrlSession = MockUrlSession(filename: "VolumeApiModel", urlString: "https://malesevic.ch", urlResponseCode: 200) else {
            throw ApiError.unspecifiedError
        }
        let sut = ApiRequest(urlSession: mockUrlSession, responseInterceptor: APIResponseInterceptor())
        guard let url = URL(string: "https://malesevic.ch") else { throw ApiError.unspecifiedError }

        let response: VolumeApiModel.APIResult = try await sut.getRequest(url)

        XCTAssertNotNil(response)
    }
    
    func testRequestTypeMismatchException() async throws {
        guard let invalidResponseJSONdata = """
{
        "kind":"books#volumes",
        "totalItems":"1"
}
""".data(using: .utf8) else {
            XCTAssert(false, "Data could not have been loaded")
            return
        }
        
        guard let mockUrlSession = MockUrlSession(responseData:invalidResponseJSONdata, urlString: "https://malesevic.ch", urlResponseCode: 200) else {
            throw ApiError.unspecifiedError
        }
        let sut = ApiRequest(urlSession: mockUrlSession, responseInterceptor: APIResponseInterceptor())
        guard let url = URL(string: "https://malesevic.ch") else { throw ApiError.unspecifiedError }

        do {
        let _: VolumeApiModel.APIResult = try await sut.getRequest(url)
        } catch {
            XCTAssert(error is ApiError)
            let apiError = error as! ApiError
            guard case .invalidResponse(responseData: _) = apiError else {
                XCTAssert(false, "expected type mismatch error")
                return
            }
        }
    }
    
    func testRequestKeyNotFoundException() async throws {
        guard let invalidResponseJSONdata = """
{
}
""".data(using: .utf8) else {
            XCTAssert(false, "Data could not have been loaded")
            return
        }
        
        guard let mockUrlSession = MockUrlSession(responseData:invalidResponseJSONdata, urlString: "https://malesevic.ch", urlResponseCode: 200) else {
            throw ApiError.unspecifiedError
        }
        let sut = ApiRequest(urlSession: mockUrlSession, responseInterceptor: APIResponseInterceptor())
        guard let url = URL(string: "https://malesevic.ch") else { throw ApiError.unspecifiedError }

        do {
        let _: VolumeApiModel.APIResult = try await sut.getRequest(url)
        } catch {
            XCTAssert(error is ApiError)
            let apiError = error as! ApiError
            guard case .invalidResponse(responseData: _) = apiError else {
                XCTAssert(false, "expected type mismatch error")
                return
            }
        }
    }
    
    func testRequestValueNotFoundException() async throws {
        guard let invalidResponseJSONdata = """
{
    "kind": ""
}
""".data(using: .utf8) else {
            XCTAssert(false, "Data could not have been loaded")
            return
        }
        
        guard let mockUrlSession = MockUrlSession(responseData:invalidResponseJSONdata, urlString: "https://malesevic.ch", urlResponseCode: 200) else {
            throw ApiError.unspecifiedError
        }
        let sut = ApiRequest(urlSession: mockUrlSession, responseInterceptor: APIResponseInterceptor())
        guard let url = URL(string: "https://malesevic.ch") else { throw ApiError.unspecifiedError }

        do {
        let _: VolumeApiModel.APIResult = try await sut.getRequest(url)
        } catch {
            XCTAssert(error is ApiError)
            let apiError = error as! ApiError
            guard case .invalidResponse(responseData: _) = apiError else {
                XCTAssert(false, "expected type mismatch error")
                return
            }
        }
    }
}
