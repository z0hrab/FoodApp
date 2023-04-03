//
//  RegisterController.swift
//  foodApp
//
//  Created by zed on 16.03.23.
//

import UIKit
import RealmSwift

class RegisterController: UIViewController {
    
    var user: User?
    let realm = try! Realm()
    
    @IBOutlet var inputFullName: UITextField!
    @IBOutlet var inputEmail: UITextField!
    @IBOutlet var inputPassword: UITextField!
    
    var bankCard: Card = Card()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Registration"
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        self.registerUser()
        Database.saveToDB(user: self.user!, Database: self.realm)
        print(self.realm.configuration.fileURL!)
    }
    
    func registerUser() {
        self.bankCard.cardHolder = self.inputFullName.text!
        self.bankCard.cardNumber = "0200 0340 0200 0100"
        self.bankCard.cardExp = "01/2021"
        self.bankCard.cvv = "000"
        
        self.user = User(fullName: self.inputFullName.text!,
                         email: self.inputEmail.text!,
                         password: self.inputPassword.text!, purchase: Purchase(), bankCard: self.bankCard)
    }
    
}
