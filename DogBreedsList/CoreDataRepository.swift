//
//  CoreDataRepository.swift
//  DogBreedsList
//
//  Created by Emanuele Eichholz on 02/11/21.
//

import Foundation

protocol CoreDataRepository {
  func getAllDogs(completion: @escaping (Result<[Dog], APIError>) throws -> Void) throws
  func saveDog(with newDog: Dog, completion: @escaping ((Result<Void, APIError>) -> Void))
  func deleteDog(name: String, completion: @escaping ((Result<Void, APIError>) -> Void))
  func getFavorites(by name: String, completion: @escaping((Result<[Dog], APIError>) -> Void))
}
