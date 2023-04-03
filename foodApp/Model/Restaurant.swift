//
//  Restaurant.swift
//  foodApp
//
//  Created by zed on 22.03.23.
//

class Restaurant: Codable {
    var restaurantName: String
    var restaurantInfo: String
    var restaurantImage: String
    var foodList: [Food]
    
    init(restaurantName: String, restaurantInfo: String, restaurantImage: String, foodList: [Food]) {
        self.restaurantName = restaurantName
        self.restaurantInfo = restaurantInfo
        self.restaurantImage = restaurantImage
        self.foodList = foodList
    }
    
}
