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
    
    private var mockMarvelAPI: MockMarvelAPI!
    
    override func setUp() {
        super.setUp()
        mockMarvelAPI = MockMarvelAPI()
    }
    
    override func tearDown() {
        super.tearDown()
        mockMarvelAPI = nil
    }
    
    func test_MD5_shouldReturnTrue() {
        let inputString = "testInputString"
        let expectedHashValue = "MD5String"
        
        let md5Hash = mockMarvelAPI.MD5(string: inputString)
        
        XCTAssertEqual(md5Hash, expectedHashValue)
    }
    
    func test_fetchCharacters_shouldNotBeNil() {
        let offset = 0
        let expectation = XCTestExpectation(description: "Mock Fetch Characters")
        
        mockMarvelAPI.fetchCharacters(offset: offset) { (characters, error) in
            XCTAssertNotNil(characters, "Characters should not be nil")
            XCTAssertNil(error, "Error should be nil")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func test_fetchComics_ShouldNotBeNil() {
        let characterID = 123
        let expectation = XCTestExpectation(description: "Mock Fetch Comics")
        
        mockMarvelAPI.fetchComics(id: characterID) { (comics, error) in
            XCTAssertNotNil(comics, "Comics should not be nil")
            XCTAssertNil(error, "Error should be nil")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }

    func test_fetchEvents_shouldNotBeNil() {
        let characterID = 456
        let expectation = XCTestExpectation(description: "Mock Fetch Events")
        
        mockMarvelAPI.fetchEvents(id: characterID) { (events, error) in
            XCTAssertNotNil(events, "Events should not be nil")
            XCTAssertNil(error, "Error should be nil")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    
}
