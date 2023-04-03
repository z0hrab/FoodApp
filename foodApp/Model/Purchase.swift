//
//  Purchase.swift
//  foodApp
//
//  Created by zed on 22.03.23.
//

import RealmSwift

class Purchase: Object {

    // @Persisted var userID: String?
    @Persisted var totalPrice: Int
    @Persisted var foodList: List<Food>
    @Persisted var purchaseStatus: String
    
    override init() {
        super.init()
    }
    
    init(totalPrice: Int, foodList: List<Food>, purchaseStatus: String) {
        self.totalPrice = totalPrice
        self.foodList = foodList
        self.purchaseStatus = purchaseStatus
        //self.totalAmount = totalAmount
    }
    
    // Sets the variable as a primary key
//    override class func primaryKey() -> String? {
//        "userID"
//    }

    
}
