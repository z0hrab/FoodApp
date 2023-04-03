//
//  FoodController.swift
//  foodApp
//
//  Created by zed on 26.03.23.
//

import UIKit
import RealmSwift

class FoodController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var collection: UICollectionView!
    
    var foodList: [Food]?
    var foodListTemp: [Food]?
    var realm = try! Realm()
    var resetCallback: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Food List"
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.resetCallback?()
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // print("Diqqet! Miqdar chap olunur!")
        // print(self.foodList![indexPath.item].foodPurchaseAmount)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.foodListTemp?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodCell", for: indexPath) as! FoodCell
        cell.foodPurchaseAmountLabel.text = "\(foodListTemp![indexPath.item].foodPurchaseAmount)"
        cell.foodNameLabel.text = self.foodListTemp![indexPath.item].foodName
        cell.foodPriceLabel.text = String("\(self.foodListTemp![indexPath.item].foodPrice) AZN")
        cell.foodImageLabel.image = UIImage(named: self.foodListTemp![indexPath.item].foodImage)
        
        cell.foodImageLabel.layer.cornerRadius = 10
    
        var miqdar: Int?
        
        cell.setFoodAmountCallback = { (amount) -> Void in
            cell.foodPurchaseAmountLabel.text = String(amount)
            miqdar = amount
        }
        
        cell.addToCartCallback = {
            self.foodListTemp![indexPath.item].foodPurchaseAmount = miqdar ?? 0            
            let tempPurchase: Purchase = Purchase()
            let realmUser = self.realm.object(ofType: User.self, forPrimaryKey: Database.currentEmail)

            for food in self.foodListTemp! {
                if food.foodPurchaseAmount > 0 {
                    tempPurchase.foodList.append(food)
                }
            }
            
            // Setting the FoodController badge
            let userTemp = Database.getUser()
            var badgeCount: Int = 0

            if let myFoodList = userTemp.purchase?.foodList {
                for myFood in myFoodList {
                    if myFood.foodPurchaseAmount > 0 {
                        badgeCount = badgeCount + myFood.foodPurchaseAmount
                    }
                }
            }

            for food in tempPurchase.foodList {
                if food.foodPurchaseAmount > 0 {
                    badgeCount = badgeCount + food.foodPurchaseAmount
                }
            }

            self.tabBarController?.viewControllers?[2].tabBarItem.badgeColor = .systemGreen
            self.tabBarController?.viewControllers?[2].tabBarItem.badgeValue = String(badgeCount)
            
            
            // Updates the User Purchase info
            try! self.realm.write {
                realmUser?.purchase?.foodList.append(objectsIn: tempPurchase.foodList)
                realmUser?.purchase?.purchaseStatus = "incomplete"
            }
            self.foodListTemp![indexPath.item] = Food(value: self.foodList![indexPath.item])
            cell.foodPurchaseAmountLabel.text = "0"
        }
        

        self.resetCallback = {
            print("itdiler!")
        }
        

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 280)
    }
    
    
    
}
