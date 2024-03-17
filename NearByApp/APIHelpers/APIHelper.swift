//
//  APIHelper.swift
//  NearByApp
//
//  Created by Sonam on 17/03/24.
//

import Foundation
struct APIHelper {
    var serviceLayer:ServiceLayer?
    
    func fetchVenues(completionHandler: @escaping (Result<VenuesModel,APIError>) -> Void) {
        let urlString  = Constants.API.basePath
        serviceLayer?.fetch(path: urlString, completionHandler: { result in
            switch result {
            case .success(let data):
                do {
                    let venuesModel = try JSONDecoder().decode(VenuesModel.self, from: data)
                    completionHandler(.success(venuesModel))
                } catch {
                    completionHandler(.failure(.invalidJson))
                }
                
                
            case .failure(let error):
                completionHandler(.failure(error))
            }
        })
    }
}
