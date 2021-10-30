//
//  DogImage.swift
//  DogBreedsList
//
//  Created by Emanuele Eichholz on 29/10/21.
//

import Foundation

struct DogImage: Codable {
    var url : String?
    
    enum CodingKeys: String, CodingKey {
        case url
    }
}
