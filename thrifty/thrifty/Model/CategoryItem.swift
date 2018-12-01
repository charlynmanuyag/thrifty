//
//  CategoryItem.swift
//  thrifty
//
//  Created by Charlyn Manuyag on 11/30/18.
//  Copyright © 2018 Kevin Wang. All rights reserved.
//

import Foundation

class CategoryItem {
    
    var itemName: String!
    var itemCost: String!
    var itemNotes: String!
    
    init(itemName: String, itemCost: String, itemNotes: String) {
        self.itemName = itemName
        self.itemCost = itemCost
        self.itemNotes = itemNotes
    }
}
