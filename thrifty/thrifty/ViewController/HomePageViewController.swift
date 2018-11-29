//
//  HomePageViewController.swift
//  thrifty
//
//  Created by Kevin Wang on 11/7/18.
//  Copyright © 2018 Kevin Wang. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var categoryView: CategoryTableView!
    
    @IBOutlet weak var pieChart: UIImageView!
   
    @IBOutlet weak var DaysRemaining: UILabel!
    @IBOutlet weak var BudgetRemaining: UILabel!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Categories.categoryDict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryTableViewCell", for: indexPath) as! CategoryTableViewCell
        
        cell.contentView.backgroundColor = UIColor.clear
        
        let whiteRoundedView : UIView = UIView(frame: CGRect(x: 10, y: 8, width: self.view.frame.size.width - 20, height: 120))
        
        whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [CGFloat(59/255), CGFloat(59/255), CGFloat(80/255), 0.2])
        whiteRoundedView.layer.masksToBounds = false
//        whiteRoundedView.layer.cornerRadius = 8
        whiteRoundedView.layer.shadowOffset = CGSize(width: -1, height: 1)
        whiteRoundedView.layer.shadowOpacity = 0.2
        
        cell.contentView.addSubview(whiteRoundedView)
        cell.contentView.sendSubview(toBack: whiteRoundedView)
        
        cell.CategoryLogo.image = UIImage(named: Categories.categoryLogos[indexPath.row])
        cell.CategoryLogo.layer.cornerRadius = 8
        cell.CategoryLogo.clipsToBounds = true
        
        cell.CategoryLabel.text = Categories.categoryDict[indexPath.row]
        cell.AmountLabel.text = "$0"
        
        return cell
    }
    

    @IBOutlet weak var GoalText: UITextView!
    var budget: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GoalText.layer.cornerRadius = GoalText.frame.size.height/2
        GoalText.clipsToBounds = false
        GoalText.layer.shadowOpacity=0.4
        GoalText.layer.shadowOffset = CGSize(width: 5, height: 5)
        if budget == nil {
            budget = "0"
        }
        GoalText.text = "Goal: $" + budget
        
        BudgetRemaining.text = "Budget Remaining: $0"
        DaysRemaining.text = "Days Remaining: 0"

        // Do any additional setup after loading the view.
        
        categoryView.rowHeight = 80
        categoryView.delegate = self
        categoryView.dataSource = self
        print(pieChart.frame.height)
        print(pieChart.frame.width)
//        pieChart.layer.cornerRadius = pieChart.frame.size.width / 2
//        pieChart.clipsToBounds = true
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
