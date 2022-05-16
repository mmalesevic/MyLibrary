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

    func testRequestVolumes() async throws {
        guard let mockUrlSession = MockUrlSession(filename: "VolumeApiModel", urlResponseCode: 200) else {
            throw ApiError.unspecifiedError
        }
        let sut = ApiRequest(urlSession: mockUrlSession, responseInterceptor: APIResponseInterceptor())
        guard let url = URL(string: "https://malesevic.net") else { throw ApiError.unspecifiedError }
        
        let lookup: VolumeApiModel.APIResult = try await sut.getRequest(url)
        
        XCTAssertNotNil(lookup)
    }
}
