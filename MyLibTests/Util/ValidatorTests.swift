//
//  ValidatorTests.swift
//  MyLibTests
//
//  Created by Matej Malesevic on 19.05.22.
//

import XCTest
@testable import MyLib

class ValidatorTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testValidator_ISBN_isValid() throws {
        XCTAssertNoThrow(try Validator.ISBN("1-56619-909-3").isValid())
        XCTAssertNoThrow(try Validator.ISBN("978-1-56619-909-4").isValid())
        XCTAssertNoThrow(try Validator.ISBN("1257561035").isValid())
        XCTAssertNoThrow(try Validator.ISBN("1248752418865").isValid())
    }
    
    func testValidator_ISBN_isInvalid() throws {
        XCTAssertThrowsError(try Validator.ISBN("978-1-56619-909-4 2").isValid())
        XCTAssertThrowsError(try Validator.ISBN("1-56619-909-32").isValid())
        XCTAssertThrowsError(try Validator.ISBN("isbn446877428ydh").isValid())
        XCTAssertThrowsError(try Validator.ISBN("55 65465 4513574").isValid())
    }


}
