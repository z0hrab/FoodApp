//
//  ProfileController.swift
//  foodApp
//
//  Created by zed on 27.03.23.
//

import UIKit
import RealmSwift

class ProfileController: UIViewController {
    
    var user = Database.getUser()

    @IBOutlet var profileLabel: UILabel!
    @IBOutlet var profileCardBalance: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setLabels()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        user = Database.getUser()
        self.setLabels()
    }
    
    func setLabels() {
        self.profileLabel.text = "Welcome, \(user.fullName)"
        self.profileCardBalance.text = "Your balance: \(self.user.bankCard?.cardBalance ?? 0) AZN"
    }
    
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        setRoot()
    }
    
    
    func setRoot() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = scene.delegate as? SceneDelegate {
            UserDefaults.standard.set(false, forKey: "loggedIn") // Setting the flag
            sceneDelegate.setRootControllerWhenLogOutClicked(windowScene: scene)
        }
    }
    
}
