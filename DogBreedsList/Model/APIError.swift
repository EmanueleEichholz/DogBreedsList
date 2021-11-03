//
//  APIError.swift
//  DogBreedsList
//
//  Created by Emanuele Eichholz on 29/10/21.
//

import Foundation

//Enum que define algumas opções de erros que podem resultar da chamada da API
enum APIError: Error {
     case emptyResponse
     case notFound
     case emptyArray
     case serverError
     case invalidResponse
 }
