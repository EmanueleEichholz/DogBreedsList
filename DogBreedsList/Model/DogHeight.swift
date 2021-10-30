//
//  DogHeight.swift
//  DogBreedsList
//
//  Created by Emanuele Eichholz on 29/10/21.
//

import Foundation

struct DogHeight: Codable {
    var metric : String?
    
    enum CodingKeys: String, CodingKey {
        case metric
    }
}
