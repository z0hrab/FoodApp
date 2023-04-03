//
//  Food.swift
//  foodApp
//
//  Created by zed on 22.03.23.
//

import RealmSwift

class Food: Object, Codable {
    @Persisted var foodName: String
    @Persisted var foodImage: String
    @Persisted var foodPrice: Int
    @Persisted var foodPurchaseAmount: Int
    
    override init() {
        super.init()
    }
    
    init(foodName: String, foodImage: String, foodPrice: Int, foodPurchaseAmount: Int) {
        self.foodName = foodName
        self.foodImage = foodImage
        self.foodPrice = foodPrice
        self.foodPurchaseAmount = foodPurchaseAmount
    }
    
}
