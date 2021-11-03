//
//  ApiSpy.swift
//  DogBreedsListTests
//
//  Created by Emanuele Eichholz on 01/11/21.
//

import Foundation

@testable import DogBreedsList

class APISpy: DogAPI {
    var apiCalls = 0
    
    func setDogsURL() -> String {
        return ""
    }
    
    func getDogs(urlString: String, method: HTTPMethod, key: String, succes: @escaping ([Dog]) -> Void, failure: @escaping (APIError) -> Void) {
        apiCalls += 1
    }
}
