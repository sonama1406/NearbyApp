//
//  VenuesViewController+TableViewExtension.swift
//  NearByApp
//
//  Created by Sonam on 17/03/24.
//

import Foundation
import UIKit

extension VenuesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venuesViewModel.venuesModel?.venues?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let venues = venuesViewModel.venuesModel?.venues?[indexPath.row]
        let cell: VenuesTableViewCell = tableView.dequeueReusableCellForIndex(indexPath: indexPath)
        cell.setDataOnCell(venues?.name ?? String(), venuesViewModel.venuesModel?.meta?.geolocation?.state ?? String(), venues?.address ?? String() )
        return cell 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "VenueTicketsViewController") as? VenueTicketsViewController
        guard let vc = vc else {
            return
        }
        vc.url = venuesViewModel.venuesModel?.venues?[indexPath.row].url
        navigationController?.pushViewController(vc,
                                                 animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (venuesViewModel.venuesModel?.venues?.count ?? 0) - 1 {
            count = count + 10
            getDataFromViewModel()
        }
    }
}
