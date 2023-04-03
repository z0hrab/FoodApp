//
//  TransactionController.swift
//  foodApp
//
//  Created by zed on 01.04.23.
//

import UIKit
import RealmSwift

class TransactionController: UIViewController {
    
    @IBOutlet var cardTemplateLabel: UIView!
    @IBOutlet var cardHolderLabel: UILabel!
    @IBOutlet var cardNumberLabel: UILabel!
    @IBOutlet var cardExpLabel: UILabel!
    @IBOutlet var cardCVVLabel: UILabel!
    @IBOutlet var amountDueLabel: UILabel!
    
    
    @IBOutlet var balanceNotEnoughLabel: UILabel!
    
    @IBAction func payButtonTapped(_ sender: Any) {
        self.doTransaction()
    }
    
    var user: User = Database.getUser()
    var realm = try! Realm()
    var amountDue: Int = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Complete Transaction"
        self.setLabels()
    }
    
    func setLabels() {
        self.cardTemplateLabel.layer.cornerRadius = 5
        self.cardTemplateLabel.layer.masksToBounds = true // without it the radius on labels doesn't work
        self.cardHolderLabel.text = self.user.bankCard?.cardHolder
        self.cardNumberLabel.text = self.user.bankCard?.cardNumber
        self.cardExpLabel.text = self.user.bankCard?.cardExp
        self.cardCVVLabel.text = self.user.bankCard?.cvv
        self.amountDueLabel.text = "Amount Due: \(self.amountDue) AZN"
    }
    
    func doTransaction() {
        let userBalance: Int = Int(user.bankCard?.cardBalance ?? 0)
        
        if userBalance >= self.amountDue {
            self.balanceNotEnoughLabel.isHidden = true
            // Updates the User Purchase info
            try! self.realm.write {
                self.user.bankCard?.cardBalance = userBalance - self.amountDue
                self.user.purchase?.purchaseStatus = "complete"
            }
            
            self.tabBarController?.viewControllers?[2].tabBarItem.badgeColor = .systemGreen
            self.tabBarController?.viewControllers?[2].tabBarItem.badgeValue = "0"
            navigationController?.popToRootViewController(animated: true)
            // self.tabBarController?.selectedIndex = 0
            
        } else {
            print("not enough balance")
            self.balanceNotEnoughLabel.isHidden = false
        }
        
    }
   
    
    
}
