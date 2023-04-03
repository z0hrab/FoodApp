//
//  Card.swift
//  foodApp
//
//  Created by zed on 22.03.23.
//

import RealmSwift

class Card: Object {
    @Persisted var cardHolder: String
    @Persisted var cardNumber: String
    @Persisted var cardExp: String
    @Persisted var cvv: String
    @Persisted var cardBalance: Int = 1000
    
    override init() {
        super.init()
    }
    
    init(cardHolder: String, cardNumber: String, cardExp: String, cvv: String, cardBalance: Int) {
        self.cardHolder = cardHolder
        self.cardNumber = cardNumber
        self.cardExp = cardExp
        self.cvv = cvv
        self.cardBalance = cardBalance
    }
    
}
