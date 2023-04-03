//
//  User.swift
//  foodApp
//
//  Created by zed on 22.03.23.
//

import RealmSwift

class User: Object {
    //@Persisted var userID: String = UUID().uuidString
    @Persisted var fullName: String
    @Persisted var email: String
    @Persisted var password: String
    @Persisted var bankCard: Card?
    @Persisted var purchase: Purchase?
    
    override init() {
        super.init()
    }

    init(fullName: String, email: String, password: String, purchase: Purchase, bankCard: Card) {
        self.fullName = fullName
        self.email = email
        self.password = password
        self.purchase = purchase
        self.bankCard = bankCard
    }
    
    // Sets the variable as a primary key
    override class func primaryKey() -> String? {
        "email"
    }
    
}
