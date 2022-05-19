//
//  VolumeViewModelTest.swift
//  MyLibTests
//
//  Created by Matej Malesevic on 17.05.22.
//

import XCTest
@testable import MyLib


@MainActor class VolumeViewModelTest: XCTestCase {
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLookupISBN_emptyQuery() async throws {
        guard let urlSession = MockUrlSession(filename: "VolumeApiModel", urlString: "http://malesevic.ch", urlResponseCode: 200) else {
            XCTAssertFalse(true, "creation of mock url session not possible")
            return
        }
        let apiRequest = ApiRequest(urlSession: urlSession, responseInterceptor: APIResponseInterceptor())
        let sut = VolumeViewModel(apiRequest: apiRequest)
        
        try await Task{
            try await sut.lookupISBN("")
        }.result.get()
        
        XCTAssertTrue(sut.volumes.isEmpty)
    }
    
    func testLookupISBN_InvalidISBN_toShort() async throws {
        guard let urlSession = MockUrlSession(filename: "VolumeApiModel", urlString: "http://malesevic.ch", urlResponseCode: 200) else {
            XCTAssertFalse(true, "creation of mock url session not possible")
            return
        }
        let apiRequest = ApiRequest(urlSession: urlSession, responseInterceptor: APIResponseInterceptor())
        let sut = VolumeViewModel(apiRequest: apiRequest)
        
        do {
            try await Task{
                try await sut.lookupISBN("74739")
            }.result.get()
        } catch {
            XCTAssert(error is ValidationError)
        }
        
        XCTAssertTrue(sut.volumes.isEmpty)
    }
    
    func testLookupISBN_InvalidISBN_InvalidCharacters() async throws {
        guard let urlSession = MockUrlSession(filename: "VolumeApiModel", urlString: "http://malesevic.ch", urlResponseCode: 200) else {
            XCTAssertFalse(true, "creation of mock url session not possible")
            return
        }
        let apiRequest = ApiRequest(urlSession: urlSession, responseInterceptor: APIResponseInterceptor())
        let sut = VolumeViewModel(apiRequest: apiRequest)
        
        do {
            try await Task{
                try await sut.lookupISBN("3630874739Drt!")
            }.result.get()
        } catch {
            XCTAssert(error is ValidationError)
        }
        
        XCTAssertTrue(sut.volumes.isEmpty)
    }
    
    func testLookupISBN_validISBN_noDashes() async throws {
        guard let urlSession = MockUrlSession(filename: "VolumeApiModel", urlString: "http://malesevic.ch", urlResponseCode: 200) else {
            XCTAssertFalse(true, "creation of mock url session not possible")
            return
        }
        let apiRequest = ApiRequest(urlSession: urlSession, responseInterceptor: APIResponseInterceptor())
        let sut = VolumeViewModel(apiRequest: apiRequest)
        
        try await Task{
            try await sut.lookupISBN("9783630874739")
        }.result.get()
        
        XCTAssertTrue(!sut.volumes.isEmpty)
    }
    
    func testLookupISBN_validISBN_dashed() async throws {
        guard let urlSession = MockUrlSession(filename: "VolumeApiModel", urlString: "http://malesevic.ch", urlResponseCode: 200) else {
            XCTAssertFalse(true, "creation of mock url session not possible")
            return
        }
        let apiRequest = ApiRequest(urlSession: urlSession, responseInterceptor: APIResponseInterceptor())
        let sut = VolumeViewModel(apiRequest: apiRequest)
        
        try await Task{
            try await sut.lookupISBN("978-3-63087-473-9")
        }.result.get()
        
        XCTAssertTrue(!sut.volumes.isEmpty)
    }
    
}
