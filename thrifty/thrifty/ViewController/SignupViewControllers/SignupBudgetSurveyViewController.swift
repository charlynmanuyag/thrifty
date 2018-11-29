//
//  SignupBudgetSurveyViewController.swift
//  thrifty
//
//  Created by Kevin Wang on 11/7/18.
//  Copyright © 2018 Kevin Wang. All rights reserved.
//

import UIKit

class SignupBudgetSurveyViewController: UIViewController {

    @IBOutlet weak var EnterBudget: LoginSignupTextField!
    var amount = ""
    let currentUser = CurrentUser()
    
    @IBAction func signUpPressed(_ sender: Any) {
        // TODO: convert budget to float
        amount = EnterBudget.text as! String
        print(EnterBudget.text)
        currentUser.setTotalBudget(amount: EnterBudget.text as! String)
        
        performSegue(withIdentifier: "CycleSurveyToHome", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CycleSurveyToHome" {
            let dest = segue.destination as! HomePageViewController
                dest.budget = amount
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.EnterBudget {
            if textField.text != nil {
                self.amount = textField.text!
            }
        }
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
