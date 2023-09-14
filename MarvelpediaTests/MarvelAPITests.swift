//
//  MarvelAPITests.swift
//  MarvelpediaTests
//
//  Created by Kabir Dhillon on 9/13/23.
//

import XCTest
@testable import Marvelpedia

class MockMarvelAPI: MarvelAPIDataServicing {
    
    func MD5(string: String) -> String {
        return "MD5String"
    }
    
    func fetchCharacters(offset: Int, completion: @escaping ([Character]?, Error?) -> Void) {
        completion([Character](),nil)
    }
    func fetchComics(id: Int, completion: @escaping ([Comic]?, Error?) -> Void) {
        completion([Comic](),nil)
    }
    
    func fetchEvents(id: Int, completion: @escaping ([Event]?, Error?) -> Void) {
        completion([Event](),nil)
    }
}

final class MarvelAPITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
