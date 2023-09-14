//
//  CharacterViewModelTests.swift
//  MarvelpediaTests
//
//  Created by Kabir Dhillon on 9/13/23.
//

import XCTest
@testable import Marvelpedia

final class CharacterViewModelTests: XCTestCase {
    
    private var characterVM: CharacterViewModel!
    private var mockMarvelAPI: MockMarvelAPI!
    
    override func setUp() {
        super.setUp()
        characterVM = CharacterViewModel()
        mockMarvelAPI = MockMarvelAPI()
    }
    
    override func tearDown() {
        super.tearDown()
        characterVM = nil
        mockMarvelAPI = nil
    }
    
    func test_getCharacters_shouldNotBeNil() {
        characterVM.getCharacters()
        
        XCTAssertNotNil(characterVM.$characters)
    }
    
    func test_getMoreCharacter_shouldNotBeNil() {
        characterVM.getMoreCharacters()
        
        XCTAssertNotNil(characterVM.$characters)
    }
    
    func test_rest_shouldBeTrue() {
        characterVM.getCharacters()
        
        
        characterVM.reset()
        
        XCTAssertTrue(characterVM.characters.count == 0)
        XCTAssertTrue(characterVM.offset == 0)
        XCTAssertTrue(characterVM.viewState == nil)
    }
    
    
}
