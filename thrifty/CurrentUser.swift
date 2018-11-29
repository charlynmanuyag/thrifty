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
    
    func setCycleDates(startDate: String, endDate: String) {
        // YOUR CODE HERE
        dbRef.child("Users").child(id).child("cycleDates").child("startDate").setValue(startDate)
        dbRef.child("Users").child(id).child("cycleDates").child("endDate").setValue(endDate)
    }
    
    // TODO: change to float
    func setTotalBudget(amount: String) {
        // YOUR CODE HERE
        dbRef.child("Users").child(id).child("cycleBudget").child("totalBudget").setValue(amount)
    }
    
}
