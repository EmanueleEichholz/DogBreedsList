//
//  API.swift
//  DogBreedsList
//
//  Created by Emanuele Eichholz on 29/10/21.
//

import Foundation

class API: DogAPI {
    
    //https://thedogapi.com/v1/images?api_key=ABC123
    //https://api.thedogapi.com/v1/breeds
  
    
    let baseURL = "https://api.thedogapi.com/v1"
    
    //Junta a URL base com os EndPoints
    func setDogsURL() -> String {
        return "\(self.baseURL)/\(EndPoints.breeds)"
    }
    
    //MARK: Utiliza a API para popular o array de dogs
    /// Returns an array of Dogs -> If nil = []
    func getDogs(urlString: String, method: HTTPMethod, key: String, succes: @escaping ([Dog]) -> Void, failure: @escaping (APIError) -> Void) {

        var _ : [Dog] = []
        let config: URLSessionConfiguration = .default
        let session: URLSession = URLSession(configuration: config)
        
        guard let url: URL = URL(string: urlString) else { return }
        var urlRequest: URLRequest = URLRequest(url: url)
        urlRequest.httpMethod = "\(method)"
        
        let task = session.dataTask(with: urlRequest, completionHandler: { (result, urlResponse, error) in
            var statusCode: Int = 0
            
            if let response = urlResponse as? HTTPURLResponse {
                statusCode = response.statusCode
            }
            
            guard let data = result else {
                failure(APIError.emptyResponse)
                return
            }
            
            do {
                let decoder : JSONDecoder = JSONDecoder()
                let decodeData: [Dog] = try
                decoder.decode([Dog].self, from: data)
                
                switch statusCode {
                case 200:
//                    failure(APIError.notFound)
                    succes(decodeData)
                case 404:
                    failure(APIError.notFound)
                    return
                case 500:
                    failure(APIError.serverError)
                    return
                default:
                    break
                }
            } catch {
                failure(APIError.invalidResponse)
            }
        })
        task.resume()
    }
}
