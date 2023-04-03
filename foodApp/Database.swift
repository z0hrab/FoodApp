//
//  DB.swift
//  foodApp
//
//  Created by zed on 23.03.23.
//

import Foundation
import RealmSwift

class Database {
    
    static var realm = try! Realm()
    static var userList: [User] = Database.fetchFromDB(Database: realm)
    static let currentEmail = UserDefaults.standard.string(forKey: "enteredEmail") ?? ""

    
    // Writes the User object to DB
    static func saveToDB(user: User, Database: Realm) {
        try! Database.write {
            Database.add(user)
        }
    }
    
    // Fetchs from DB and returns an array of User objects
    static func fetchFromDB(Database: Realm) -> [User] {
        var result: [User] = [User]()
        let objects = Database.objects(User.self)
        result.append(contentsOf: objects)
        return result
    }
    
    // Gets specific user object
    static func getUser() -> User {
        var result: User = User()
        
        for user in userList {
            if user.email == Database.currentEmail {
                result = user
            }
        }
        
        return result
    }
    
}
