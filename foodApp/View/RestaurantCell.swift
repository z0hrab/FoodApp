//
//  RestaurantCell.swift
//  foodApp
//
//  Created by zed on 23.03.23.
//

import UIKit

class RestaurantCell: UITableViewCell {
    var restName: String?
    var infoButtonCallback: (()->Void)?

    @IBAction func infoButtonTapped(_ sender: Any) {
        infoButtonCallback?()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
