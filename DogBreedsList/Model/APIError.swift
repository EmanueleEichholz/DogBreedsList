//
//  APIError.swift
//  DogBreedsList
//
//  Created by Emanuele Eichholz on 29/10/21.
//

import Foundation

enum APIError: Error {
     case emptyResponse
     case notFound
     case emptyArray
     case serverError
     case invalidResponse
 }
