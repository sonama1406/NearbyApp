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
    
}
