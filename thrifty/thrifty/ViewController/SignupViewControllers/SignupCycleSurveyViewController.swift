//
//  SignupCycleSurveyViewController.swift
//  thrifty
//
//  Created by Kevin Wang on 11/7/18.
//  Copyright © 2018 Kevin Wang. All rights reserved.
//

import UIKit

class SignupCycleSurveyViewController: UIViewController {

    @IBOutlet weak var cycleLength: LoginSignupTextField!
   
    
    var length = ""
    
    let currentUser = CurrentUser()
    
    @IBAction func signupPressed(_ sender: Any) {
        // TODO: empty date checks and date format!
        
        let num = Int(cycleLength.text!)
        
        currentUser.setCycleLength(cycleLength: num!)
        
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
        if textField == self.cycleLength {
            if textField.text != nil {
                self.length = textField.text!
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
