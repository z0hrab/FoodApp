//
//  FoodCell.swift
//  foodApp
//
//  Created by zed on 26.03.23.
//

import UIKit

class FoodCell: UICollectionViewCell {
    
    @IBOutlet var foodImageLabel: UIImageView!
    @IBOutlet var foodNameLabel: UILabel!
    @IBOutlet var foodPriceLabel: UILabel!
    @IBOutlet var foodPurchaseAmountLabel: UILabel!
    
    var setFoodAmountCallback: ((_ amount: Int)->Void)?
    var addToCartCallback: (()->Void)?
    
    @IBAction func plusFood(_ sender: Any) {
        let someString: String = self.foodPurchaseAmountLabel.text ?? "0"
        var count: Int = Int(someString) ?? 0
        count = count + 1
        // self.foodPurchaseAmountLabel.text = String(count) // bele etmek olmaz, collection-u reload etmek lazimdir
        setFoodAmountCallback?(count)
    }
    
    @IBAction func minusFood(_ sender: Any) {
        let someString: String = self.foodPurchaseAmountLabel.text ?? "0"
        var count: Int = Int(someString) ?? 0
        
        if count > 0 {
            count = count - 1
            // self.foodPurchaseAmountLabel.text = String(count) // bele etmek olmaz, collection-u reload etmek lazimdir
            setFoodAmountCallback?(count)
        }
    }
    
    
    @IBAction func addFood(_ sender: Any) {
        // add to Cart
        self.addToCartCallback?()
        //self.foodPurchaseAmount.text = "0"
    }
    
}
