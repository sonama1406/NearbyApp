//
//  APIHelper.swift
//  NearByApp
//
//  Created by Sonam on 17/03/24.
//

import Foundation
struct APIHelper {
    var serviceLayer:ServiceLayer?
    
    func fetchVenues(_ latitude: String, _ longitude: String,_ miles: String, _ count: Int, completionHandler: @escaping (Result<VenuesModel,APIError>) -> Void) {
        
        let urlString  = Constants.API.basePath + "?per_page=\(count)&page=1&client_id=Mzg0OTc0Njl8MTcwMDgxMTg5NC44MDk2NjY5&lat=\(latitude)&lon=\(longitude)&range=\(miles)"
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
