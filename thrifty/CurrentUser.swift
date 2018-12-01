//
//  CurrentUser.swift
//  thrifty
//
//  Created by Charlyn Manuyag on 11/28/18.
//  Copyright © 2018 Kevin Wang. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class CurrentUser {
    
    var username: String!
    var id: String!
    
    let dbRef = Database.database().reference()
    
    init() {
        let currentUser = Auth.auth().currentUser
        username = currentUser?.displayName
        id = currentUser?.uid
    }
    
    func setCycleLength(cycleLength: Int) {
        // YOUR CODE HERE
        dbRef.child("Users").child(id).child("cycleLength").setValue(cycleLength)
        
    }
    
    // TODO: change to float
    func setTotalBudget(amount: String) {
        // YOUR CODE HERE
        dbRef.child("Users").child(id).child("cycleBudget").child("totalBudget").setValue(amount)
        dbRef.child("Users").child(id).child("cycleBudget").child("remainingBudget").setValue(amount)
        for key in Categories.categoryDict.keys {
            dbRef.child("Users").child(id).child(Categories.categoryDict[key] as! String).child("categoryAmount").setValue("0")
        }
    }
    
    func addNewItem(category: String, item: String, cost: String, notes: String) {
        let newItemRef = dbRef.child("Users").child(id).child(category).childByAutoId()
        newItemRef.child("item").setValue(item)
        newItemRef.child("cost").setValue(cost)
        newItemRef.child("notes").setValue(notes)
        
        let remainingBudgetRef = dbRef.child("Users").child(id).child("cycleBudget").child("remainingBudget")
        remainingBudgetRef.observeSingleEvent(of: DataEventType.value) { dataSnapshot in
            if let value = dataSnapshot.value as? String {
                print(value)
                let newValue = Float(value)! - Float(cost)!
                print(newValue)
                remainingBudgetRef.setValue(String(newValue))
            }
        }
        
        let categoryAmountRef = dbRef.child("Users").child(id).child(category).child("categoryAmount")
        categoryAmountRef.observeSingleEvent(of: DataEventType.value) { dataSnapshot in
            if let value = dataSnapshot.value as? String {
                print(value)
                let newValue = Float(value)! + Float(cost)!
                print(newValue)
                categoryAmountRef.setValue(String(newValue))
            }
        }
    }
    
//    func getTotalBudget() -> String {
//        var totalBudget = "0"
//        let totalBudgetRef = dbRef.child("Users").child(id).child("cycleBudget").child("totalBudget")
//        totalBudgetRef.observeSingleEvent(of: DataEventType.value) { dataSnapshot in
//            if let value = dataSnapshot.value as? String {
//                totalBudget = value
//            }
//        }
//        print(totalBudget)
//        return totalBudget
//    }
    
    func getTotalBudget(completion: @escaping (String) -> Void) {
        var totalBudget = ""
        let totalBudgetRef = dbRef.child("Users").child(id).child("cycleBudget").child("totalBudget")
        totalBudgetRef.observeSingleEvent(of: DataEventType.value) { dataSnapshot in
            if dataSnapshot.exists() {
                if let value = dataSnapshot.value as? String {
                    totalBudget = value
                }
            }
            completion(totalBudget)
        }
    }
    
    func getRemainingBudget(completion: @escaping (String) -> Void) {
        var remainingBudget = ""
        let remainingBudgetRef = dbRef.child("Users").child(id).child("cycleBudget").child("remainingBudget")
        remainingBudgetRef.observeSingleEvent(of: DataEventType.value) { dataSnapshot in
            if dataSnapshot.exists() {
                if let value = dataSnapshot.value as? String {
                    remainingBudget = value
                }
            }
            completion(remainingBudget)
        }
    }
    
    func getCategoryAmount(category: String, completion: @escaping (String) -> Void) {
        var categoryAmount = ""
        let categoryAmountRef = dbRef.child("Users").child(id).child(category).child("categoryAmount")
        categoryAmountRef.observeSingleEvent(of: DataEventType.value) { dataSnapshot in
            if dataSnapshot.exists() {
                if let value = dataSnapshot.value as? String {
                    categoryAmount = value
                    print(category, categoryAmount)
                }
            }
            completion(categoryAmount)
        }
    }
    
    func getCycleLength(completion: @escaping (Int) -> Void) {
        var cycleLength = 0
        let cycleLengthRef = dbRef.child("Users").child(id).child("cycleLength")
        cycleLengthRef.observeSingleEvent(of: DataEventType.value) { dataSnapshot in
            if dataSnapshot.exists() {
                if let value = dataSnapshot.value as? Int {
                    cycleLength = value
                }
            }
            completion(cycleLength)
        }
    }
    
    func getCategoryItems(category: String!, completion: @escaping ([CategoryItem]) -> Void) {
        var categoryItems: [CategoryItem] = []
        let categoryItemRef = dbRef.child("Users").child(id).child(category)
        categoryItemRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists() {
                if let dict = snapshot.value as? [String: Any] {
                    for (key, value) in dict {
//                        print(key, value)
                        if let itemDict = value as? [String : Any] {
                            print(itemDict)
                            let categoryItem = CategoryItem(itemName: itemDict["item"] as! String, itemCost: itemDict["cost"] as! String, itemNotes: itemDict["notes"] as! String)
                            categoryItems.append(categoryItem)
                        }
                    }
                }
            }
            completion(categoryItems)
    }
    )}
}
