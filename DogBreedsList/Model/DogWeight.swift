//
//  DogWeight.swift
//  DogBreedsList
//
//  Created by Emanuele Eichholz on 29/10/21.
//

import Foundation

struct DogWeight: Codable {
    var metric : String?
    
    enum CodingKeys: String, CodingKey {
        case metric
    }
}

