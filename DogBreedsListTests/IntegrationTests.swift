//
//  IntegrationTests.swift
//  DogBreedsListTests
//
//  Created by Emanuele Eichholz on 01/11/21.
//

import XCTest

@testable import DogBreedsList

class IntegrationTests: XCTestCase {

    func testApiIntegration() {
        // Setup
        let api = API()
        let sut = BreedsTableViewController(api: api)
        let expect = expectation(description: "Aguardar popular os cachorros")

        // Exercise
        sut.loadViewIfNeeded()
//        sut.fillAndRefreshArrayOfDogs()
        DispatchQueue.global(qos: .userInitiated).async {
            sleep(5)

            // Verify
            guard sut.arrayOfDogs.count > 0 else {
                XCTFail()
                expect.fulfill()
                return
            }
            let charactersNameFirstDog = sut.arrayOfDogs[0].name?.count ?? 0
            XCTAssertTrue(charactersNameFirstDog > 0)
            expect.fulfill()
        }

        wait(for: [expect], timeout: 10.0)
    }
}
