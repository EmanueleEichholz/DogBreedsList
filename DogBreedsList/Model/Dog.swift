//
//  Dog.swift
//  DogBreedsList
//
//  Created by Emanuele Eichholz on 29/10/21.
//

import Foundation


//Define como irei decodificar os dados que irei buscar na API
struct Dog: Codable {
    
    var name            : String?
    var bred_for        : String?
    var breed_group     : String?
    var height          : DogHeight?
    var weight          : DogWeight?
    var life_span       : String?
    var temperament     : String?
    var image           : DogImage?
    
    enum CodingKeys: String, CodingKey {
        case name
        case bred_for
        case breed_group
        case height
        case weight
        case life_span
        case temperament
        case image
    }
    
    init(name            : String? = nil,
         bred_for        : String? = nil,
         breed_group     : String? = nil,
         height          : DogHeight? = nil,
         weight          : DogWeight? = nil,
         life_span       : String? = nil,
         temperament     : String? = nil,
         image           : DogImage? = nil
    ) {
        self.name           = name
        self.bred_for       = bred_for
        self.breed_group    = breed_group
        self.height         = height
        self.weight         = weight
        self.life_span      = life_span
        self.temperament    = temperament
        self.image          = image
    }
}
