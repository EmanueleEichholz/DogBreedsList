//
//  IntegrationTests.swift
//  DogBreedsListTests
//
//  Created by Emanuele Eichholz on 01/11/21.
//

import XCTest

@testable import DogBreedsList

class IntegrationTests: XCTestCase {
    func testAPIIntegration() {
        
        let api = API()
        
        let sut = BreedsTableViewController(api: api)
        sut.loadViewIfNeeded()
        
        sleep(5)
        
        guard sut.arrayOfDogs.count > 0 else {
            XCTFail()
            return
        }
        let charactersNameFirstDog = sut.arrayOfDogs[0].name?.count ?? 0
        XCTAssertTrue(charactersNameFirstDog > 0)
    }
}
