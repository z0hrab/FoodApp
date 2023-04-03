//
//  RestaurantController.swift
//  foodApp
//
//  Created by zed on 23.03.23.
//

import UIKit

class RestaurantController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var user = Database.getUser()
    var restaurantList: [Restaurant] = RestaurantController.jsonRead()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Restaurant List"
        self.tabBarItem.title = "HOME"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setBadge()
    }
    
    // Setting the RestaurantController badge
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
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "FoodController") as? FoodController
        vc?.foodList = self.restaurantList[indexPath.row].foodList
        
        // Creating and filling a separate temporary list
        var foodListTemp: [Food] = [Food]()
        for food in self.restaurantList[indexPath.row].foodList {
            let tempFood: Food = Food(value: food)
            foodListTemp.append(tempFood)
        }
        vc?.foodListTemp = foodListTemp
        
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.restaurantList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as! RestaurantCell
        cell.textLabel?.text = self.restaurantList[indexPath.row].restaurantName
        
        cell.infoButtonCallback = {
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "RestaurantInfoController") as! RestaurantInfoController
            vc.restaurant = self.restaurantList[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        return cell
    }
    
    static func jsonRead() -> [Restaurant] {
        let jsonFile = Bundle.main.url(forResource: "Storage", withExtension: "json")
        let data = try? Data(contentsOf: jsonFile!)
        var result: [Restaurant] = [Restaurant]()
        do {
            result = try JSONDecoder().decode([Restaurant].self, from: data!)
        } catch {
            print(error.localizedDescription)
        }
        return result
    }
    
    static func readFoodList(num: Int) -> [Food] {
        var foodList: [Food] = [Food]()
        for food in jsonRead()[num].foodList {
            foodList.append(food)
        }
        return foodList
    }
    
    
}
