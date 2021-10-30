//
//  DogAPI.swift
//  DogBreedsList
//
//  Created by Emanuele Eichholz on 29/10/21.
//

import Foundation

protocol DogAPI {
    func setDogsURL() -> String
    func getDogs(urlString: String, method: HTTPMethod) -> [Dog]
}
