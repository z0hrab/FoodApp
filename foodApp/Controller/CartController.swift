//
//  CartController.swift
//  foodApp
//
//  Created by zed on 28.03.23.
//

import UIKit
import RealmSwift

class CartController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var table: UITableView!
    @IBOutlet var totalPriceLabel: UILabel!
    @IBOutlet var purchaseAmountLabel: UILabel!
    @IBOutlet var completeTransactionButton: UIButton!
    
    @IBOutlet var cartStatusLabel: UILabel!
    
    var user: User = Database.getUser()
    var realm = try! Realm()
    var amountDueTemp: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func completeTransactionButtonTapped(_ sender: Any) {
        self.completeTransaction()
    }
    
    func completeTransaction() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "TransactionController") as? TransactionController
        vc?.amountDue = self.amountDueTemp
        navigationController?.show(vc!, sender: nil)
    }
    

    override func viewWillAppear(_ animated: Bool) {
        self.table.reloadData()
        self.setTotalPurchaseAmount()
    }
    
    
    override func viewWillLayoutSubviews() {
        self.table.reloadData()
        self.setTotalPurchaseAmount()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.user.purchase?.foodList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell") as! CartCell

        if self.user.purchase?.purchaseStatus == "incomplete" {
            self.cartStatusLabel.isHidden = true
            cell.textLabel?.text = self.user.purchase?.foodList[indexPath.row].foodName
            cell.purchaseAmountLabel.text = "\(self.user.purchase?.foodList[indexPath.row].foodPurchaseAmount ?? 0)"
            cell.purchaseAmountLabel.layer.masksToBounds = true // without it the radius on labels doesn't work
            cell.purchaseAmountLabel.layer.cornerRadius = 5
        } else if self.user.purchase?.purchaseStatus == "complete" {
            // Deletes the Foodlist from the Purchase
            self.cartStatusLabel.isHidden = false
            try! self.realm.write {
                self.user.purchase?.foodList.removeAll()
            }
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "Delete") { _, _, _ in
            self.deleteItem(indexPathRow: indexPath.row)
            self.table.reloadData()
        }
        
        delete.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func deleteItem(indexPathRow: Int) {
        // Updates the User Purchase info
        try! self.realm.write {
            self.user.purchase?.foodList[indexPathRow].foodPurchaseAmount = 0
            self.user.purchase?.foodList.remove(at: indexPathRow)
        }
        
        self.setBadge()
        
    }
    
    // Setting the CartController badge
    func setBadge() {
        var badgeCount: Int = 0
        
        if let foodList = self.user.purchase?.foodList {
            for food in foodList {
                if food.foodPurchaseAmount > 0 {
                    badgeCount = badgeCount + food.foodPurchaseAmount
                }
            }
        }
        
        self.tabBarController?.viewControllers?[2].tabBarItem.badgeColor = .systemGreen
        self.tabBarController?.viewControllers?[2].tabBarItem.badgeValue = String(badgeCount)
        self.setTotalPurchaseAmount()
    }
    
    
    func setTotalPurchaseAmount() {
        var result: Int = 0
        
        if let foodList = self.user.purchase?.foodList {
            for food in foodList {
                if food.foodPurchaseAmount > 0 {
                    result = result + (food.foodPrice * food.foodPurchaseAmount)
                }
            }
        }
        
        if result > 0 {
            self.totalPriceLabel.text = "Total: \(result) AZN"

            self.totalPriceLabel.isHidden = false
            self.completeTransactionButton.isHidden = false
            self.amountDueTemp = result
        } else {
            self.totalPriceLabel.isHidden = true
            self.completeTransactionButton.isHidden = true
        }
    }
    
 
    
}
