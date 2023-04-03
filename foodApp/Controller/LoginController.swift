//
//  ViewController.swift
//  foodApp
//
//  Created by zed on 16.03.23.
//

import UIKit
import RealmSwift
import Lottie

class LoginController: UIViewController {
    
    var userList: [User] = Database.fetchFromDB(Database: try! Realm())
    var realm = try! Realm()
    
    @IBOutlet var inputEmail: UITextField!
    @IBOutlet var inputPassword: UITextField!
    @IBOutlet var animatedLogo: LottieAnimationView!
    @IBOutlet var loadingAnimation: LottieAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.playLogo()
        print(self.realm.configuration.fileURL!)
    }
    
    func playLogo() {
        self.animatedLogo.contentMode = .scaleAspectFit
        self.animatedLogo.loopMode = .playOnce
        self.animatedLogo.play()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.userList = Database.fetchFromDB(Database: try! Realm())
        self.inputEmail.text = ""
        self.inputPassword.text = ""
        playLogo()
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        self.goToHome()
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        self.goToRegistration()
    }
    
    // Goes to Home screen
    func goToHome() {
        checkUser()
    }
    
    // Checks user an upon success moves to another page
    func checkUser() {
        for user in self.userList {
            if user.email == self.inputEmail.text
                && user.password == self.inputPassword.text
                && (self.inputEmail.text != nil)
                && (self.inputPassword.text != nil)
                && !(self.inputEmail.text?.isEmpty ?? true)
                && !(self.inputPassword.text?.isEmpty ?? true){
                                
                         
                // Loading line
                self.loadingAnimation.isHidden = false
                self.loadingAnimation.contentMode = .scaleAspectFill
                self.loadingAnimation.loopMode = .loop
                self.loadingAnimation.play()
                
                
                Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
                    UserDefaults.standard.set(user.email, forKey: "enteredEmail") // Setting the flag
                    self.setRoot()
                }
                
            } else {
                print("wrong details")
            }
        }
    }
    
    
    // Sets Root Controller
    func setRoot() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = scene.delegate as? SceneDelegate {
            UserDefaults.standard.set(true, forKey: "loggedIn") // Setting the flag
            sceneDelegate.setRootControllerWhenLogInClicked(windowScene: scene)
        }
    }
        
    // Goes to Registration screen
    func goToRegistration() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "RegisterController") as? UIViewController
        self.navigationController?.show(vc!, sender: nil)
    }
    
}

