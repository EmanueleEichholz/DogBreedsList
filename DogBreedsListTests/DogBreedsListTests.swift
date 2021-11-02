//
//  DogBreedsListTests.swift
//  DogBreedsListTests
//
//  Created by Emanuele Eichholz on 29/10/21.
//

import XCTest
@testable import DogBreedsList


class DogBreedsListTests: XCTestCase {
    
    func test_init_willCallAPIOnce() {
        let doubleApi = APISpy()
        let sut = BreedsTableViewController(api: doubleApi)
        
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(doubleApi.apiCalls, 1, "A API deve ser chamada uma só vez")
    }
    
}
