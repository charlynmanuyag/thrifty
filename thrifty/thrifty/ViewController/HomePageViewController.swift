//
//  HomePageViewController.swift
//  thrifty
//
//  Created by Kevin Wang on 11/7/18.
//  Copyright © 2018 Kevin Wang. All rights reserved.
//

import UIKit


class HomePageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBAction func refreshButtonPressed(_ sender: Any) {
        viewWillAppear(true)
    }
    @IBOutlet weak var categoryView: CategoryTableView!
    
    @IBOutlet weak var pieChart: UIImageView!
   
    @IBOutlet weak var cycleLength: UILabel!
    @IBOutlet weak var BudgetRemaining: UILabel!
    
    var CategoryAmount: String!
    
    var selectedCategory: String!
    
    let currentUser = CurrentUser()
    
    @IBAction func unwindToHomePage(segue:UIStoryboardSegue) { }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Categories.categoryDict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryTableViewCell", for: indexPath) as! CategoryTableViewCell
        
//        cell.contentView.backgroundColor = UIColor.clear
        
//        let whiteRoundedView : UIView = UIView(frame: CGRect(x: 10, y: 8, width: self.view.frame.size.width - 20, height: 120))
//
//        whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [CGFloat(59/255), CGFloat(59/255), CGFloat(80/255), 0.2])
//        whiteRoundedView.layer.masksToBounds = false
////        whiteRoundedView.layer.cornerRadius = 8
//        whiteRoundedView.layer.shadowOffset = CGSize(width: -1, height: 1)
//        whiteRoundedView.layer.shadowOpacity = 0.2
//
//        cell.contentView.addSubview(whiteRoundedView)
//        cell.contentView.sendSubview(toBack: whiteRoundedView)
        
        cell.CategoryLogo.image = UIImage(named: Categories.categoryLogos[indexPath.row])
        cell.CategoryLogo.layer.cornerRadius = 8
        cell.CategoryLogo.clipsToBounds = true
        
        cell.CategoryLabel.text = Categories.categoryDict[indexPath.row]
        cell.AmountLabel.text = "$0"
        
        let category = Categories.categoryDict[indexPath.row]
        
        
        
        currentUser.getCategoryAmount(category: category!, completion: {categoryAmount in
            cell.AmountLabel.text = "$" + categoryAmount
        })
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCategory = Categories.categoryDict[indexPath.row]
        performSegue(withIdentifier: "HomeToItemList", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HomeToItemList" {
            let dest = segue.destination as! ItemsViewController
            dest.category = selectedCategory
        }
    }
    

    @IBOutlet weak var GoalText: UILabel!
    var budget: String!
    var remainingBudget: String!
    var numOfDays: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GoalText.layer.cornerRadius = GoalText.frame.size.height/2
        GoalText.clipsToBounds = false
        GoalText.layer.shadowOpacity=0.4
        GoalText.layer.shadowOffset = CGSize(width: 5, height: 5)
        if budget == nil {
            budget = "0"
        }

        // Do any additional setup after loading the view.
        
        categoryView.rowHeight = 80
        categoryView.delegate = self
        categoryView.dataSource = self
//        pieChart.layer.cornerRadius = pieChart.frame.size.width / 2
//        pieChart.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("going to appear!")
        currentUser.getTotalBudget(completion: {totalBudget in
            print(totalBudget)
            self.budget = totalBudget
            self.GoalText.text = "Goal: $" + self.budget
            
        })
        
        currentUser.getRemainingBudget(completion: {remainingBudget in
            print("remaining budget:" + remainingBudget)
            self.remainingBudget = remainingBudget
            self.BudgetRemaining.text = "Budget Remaining: $" + self.remainingBudget
            
        })
        
        
        currentUser.getCycleLength(completion: {cycleLength in
            self.numOfDays = cycleLength
            self.cycleLength.text = "Cycle Length: " + String(self.numOfDays) + " days"
            
        })
        
        categoryView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
