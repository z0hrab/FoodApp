//
//  RestaurantInfoController.swift
//  foodApp
//
//  Created by zed on 25.03.23.
//

import UIKit

class RestaurantInfoController: UIViewController {

    var restaurant: Restaurant?
    
    @IBOutlet var restaurantImage: UIImageView!
    @IBOutlet var restaurantName: UILabel!
    @IBOutlet var restaurantInfo: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fillDetail()
    }
    
    func fillDetail() {
        self.restaurantImage.image = UIImage(named: self.restaurant?.restaurantName ?? "")
        self.restaurantImage.layer.cornerRadius = 10
        self.restaurantName.text = self.restaurant?.restaurantName
        self.restaurantInfo.text = self.restaurant?.restaurantInfo
    }


}
