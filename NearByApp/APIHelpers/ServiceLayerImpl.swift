//
//  APIManager.swift
//  NearByApp
//
//  Created by Sonam on 17/03/24.
//



import Foundation

enum APIError: Error {
    case invalidData
    case invalidResponse
    case invalidUrl
    case invalidStatusCode
    case invalidJson
}

protocol ServiceLayer {
    func fetch(path:String, completionHandler:@escaping (Result<Data, APIError>) -> Void)
}

struct ServiceLayerImpl:ServiceLayer {
    
    func fetch(path: String, completionHandler: @escaping (Result<Data, APIError>) -> Void) {
        guard let url = URL(string: path) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                completionHandler(.failure(.invalidResponse))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                let errorTemp = NSError(domain:"", code:(response as? HTTPURLResponse)?.statusCode ?? 200, userInfo:nil)
                completionHandler(.failure(.invalidStatusCode))
                return
            }
            if let data = data {
                completionHandler(.success(data))
            } else {
                completionHandler(.failure(.invalidData))
            }
            
        })
        task.resume()
    }
    
    
}


