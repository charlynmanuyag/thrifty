//
//  SignupCycleSurveyViewController.swift
//  thrifty
//
//  Created by Kevin Wang on 11/7/18.
//  Copyright © 2018 Kevin Wang. All rights reserved.
//

import UIKit

class SignupCycleSurveyViewController: UIViewController {

    @IBOutlet weak var startDate: LoginSignupTextField!
    @IBOutlet weak var endDate: LoginSignupTextField!
    
    var Start = ""
    var End = ""
    
    let currentUser = CurrentUser()
    
    @IBAction func signupPressed(_ sender: Any) {
        // TODO: empty date checks and date format!
        
        currentUser.setCycleDates(startDate: startDate.text as! String, endDate: endDate.text as! String)
        
        performSegue(withIdentifier: "CycleToBudget", sender: nil)
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
        if textField == self.startDate {
            if textField.text != nil {
                self.Start = textField.text!
            }
        } else {
            if textField.text != nil {
                self.End = textField.text!
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
