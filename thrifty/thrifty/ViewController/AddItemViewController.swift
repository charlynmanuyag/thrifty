//
//  AddItemViewController.swift
//  thrifty
//
//  Created by Kevin Wang on 11/7/18.
//  Copyright © 2018 Kevin Wang. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController {

    @IBOutlet weak var AddNewItemLabel: UILabel!
    @IBOutlet weak var Item: LoginSignupTextField!
    @IBOutlet weak var Cost: LoginSignupTextField!
    @IBOutlet weak var Notes: LoginSignupTextField!
    
    var category: String!
    
    @IBAction func addItemWasPressed(_ sender: Any) {
        let currentUser = CurrentUser()
        currentUser.addNewItem(category: category, item: Item.text as! String, cost: Cost.text as! String, notes: Notes.text as! String)
        performSegue(withIdentifier: "unwindToHomePage", sender: self)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "unwindToHomePage" {
//            let dest = segue.destination as! HomePageViewController
//            print(Cost.text)
//            dest.CategoryAmount = Cost.text
//        }
//    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        AddNewItemLabel.text = "Add a new item to " + category
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBackToItemsList(_ sender: Any) {
        performSegue(withIdentifier: "unwindToItemsListSegue", sender: self)
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
