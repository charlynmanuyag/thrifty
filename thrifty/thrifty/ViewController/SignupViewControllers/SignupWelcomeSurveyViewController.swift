//
//  SignupWelcomeSurveyViewController.swift
//  thrifty
//
//  Created by Kevin Wang on 11/7/18.
//  Copyright © 2018 Kevin Wang. All rights reserved.
//

import UIKit

class SignupWelcomeSurveyViewController: UIViewController {
    @IBOutlet weak var WelcomeSign: UITextView!
    
    var name: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if name == nil {
            name = ""
        }
        WelcomeSign.text = "Welcome " + name + "!"

        // Do any additional setup after loading the view.
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
