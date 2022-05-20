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
        guard let urlSession = MockUrlSession(filename: "VolumeApiModel_empty", urlString: "http://malesevic.ch", urlResponseCode: 200) else {
            XCTAssertFalse(true, "creation of mock url session not possible")
            return
        }
        let apiRequest = ApiRequest(urlSession: urlSession, responseInterceptor: APIResponseInterceptor())
        let sut = VolumeViewModel(apiRequest: apiRequest)
        
        do {
            let _ = try await sut.lookupISBN("")
        } catch {
            XCTAssert(error is ApiError)
        }
    }
    
    func testLookupISBN_InvalidISBN_InvalidISBN() async throws {
        guard let urlSession = MockUrlSession(filename: "VolumeApiModel", urlString: "http://malesevic.ch", urlResponseCode: 200) else {
            XCTAssertFalse(true, "creation of mock url session not possible")
            return
        }
        let apiRequest = ApiRequest(urlSession: urlSession, responseInterceptor: APIResponseInterceptor())
        let sut = VolumeViewModel(apiRequest: apiRequest)
        
        
        do {
            let _ = try await sut.lookupISBN("3630874739Drt!")
        } catch {
            XCTAssert(error is ValidationError)
        }
    }
    
    func testLookupISBN_validISBN_validISBN() async throws {
        guard let urlSession = MockUrlSession(filename: "VolumeApiModel", urlString: "http://malesevic.ch", urlResponseCode: 200) else {
            XCTAssertFalse(true, "creation of mock url session not possible")
            return
        }
        let apiRequest = ApiRequest(urlSession: urlSession, responseInterceptor: APIResponseInterceptor())
        let sut = VolumeViewModel(apiRequest: apiRequest)
        
        let volumes = try await sut.lookupISBN("978-3-63087-473-9")
        
        XCTAssertFalse(volumes.isEmpty)
    }
    
    func testLookupISBN_validISBN_empty() async throws {
        guard let urlSession = MockUrlSession(filename: "VolumeApiModel_empty", urlString: "http://malesevic.ch", urlResponseCode: 200) else {
            XCTAssertFalse(true, "creation of mock url session not possible")
            return
        }
        let apiRequest = ApiRequest(urlSession: urlSession, responseInterceptor: APIResponseInterceptor())
        let sut = VolumeViewModel(apiRequest: apiRequest)
        
        do {
            let _ = try await sut.lookupISBN("978-3-63087-473-9")
        } catch {
            XCTAssert(error is ApiError)
            let apiError = error as! ApiError
            XCTAssertTrue(apiError == .noResult)
        }
    }
    
    
    
}
