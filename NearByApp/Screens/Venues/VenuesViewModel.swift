//
//  VenuesViewModel.swift
//  NearByApp
//
//  Created by Sonam on 17/03/24.
//

import Foundation


final class VenuesViewModel {
    
    var eventData: ((EventData) -> Void)?
    let apiHelper = APIHelper(serviceLayer: ServiceLayerImpl())
    var venuesModel: VenuesModel?
    
    func fetchData()  {
        eventData?(.loading)
        apiHelper.fetchVenues(completionHandler:  { [weak self] result in
            guard let self else {
                return
            }
            switch result {
            case .success(let venuesModel):
                self.venuesModel = venuesModel
                self.eventData?(.dataLoaded)
                break
                
            case .failure(let error):
                self.eventData?(.error(error))
                break
                
            }
        } )
    }
    
}

    enum EventData {
        case loading
        case endLoading
        case dataLoaded
        case error(APIError?)
    }
