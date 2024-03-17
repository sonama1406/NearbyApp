//
//  VenuesTableViewCell.swift
//  NearByApp
//
//  Created by Sonam on 17/03/24.
//

import UIKit

// MARK: VenuesTableViewCell
final class VenuesTableViewCell: UITableViewCell {
    
    
    @IBOutlet private weak var lblName: UILabel!
    
    @IBOutlet private weak var lblCity: UILabel!
    
    @IBOutlet private weak var lblAddress: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setDataOnCell(_ name: String, _ city: String, _ address: String) {
        lblName.text = name
        lblCity.text = city
        lblAddress.text = address
        
    }
    
}
