//
//  ItemsViewController.swift
//  thrifty
//
//  Created by Charlyn Manuyag on 11/30/18.
//  Copyright © 2018 Kevin Wang. All rights reserved.
//

import UIKit

class ItemsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let currentUser = CurrentUser()
    
    var categoryItems: [CategoryItem] = []
    
    var category: String!
    
    @IBOutlet weak var itemsTableView: ItemTableView!
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemsTableView.delegate = self
        itemsTableView.dataSource = self
        itemsTableView.rowHeight = 100
        
        

        // Do any additional setup after loading the view.
//        currentUser.getCategoryItems(category: "Food", completion: { categoryItems in
//            //TODO: populate table rows
//            print(categoryItems)
//            self.categoryItems = categoryItems
//        })
//        print(categoryItems)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemTableViewCell", for: indexPath) as! ItemTableViewCell
        print("i am  a cell!")
        print(indexPath.row)
        print(categoryItems)
        
        let itemName = categoryItems[indexPath.row].itemName
        cell.itemName.text = itemName
        let itemCost = categoryItems[indexPath.row].itemCost
        cell.costLabel.text = "$" + itemCost!
        let notes = categoryItems[indexPath.row].itemNotes
        cell.notesLabel.text = "Note: " + notes!
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("items going to appear!")
        currentUser.getCategoryItems(category: category, completion: { categoryItems in
            //TODO: populate table rows
            
//            print(categoryItems.count)
            self.categoryItems = categoryItems
            self.itemsTableView.reloadData()
            print(categoryItems)
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "categoryViewToAddItem" {
            let dest = segue.destination as! AddItemViewController
            dest.category = category
        }
    }
    
    @IBAction func goBackToHomeButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "unwindSegueToHomePage", sender: self)
    }
    
    @IBAction func unwindToItemsList(segue:UIStoryboardSegue) {
        
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
