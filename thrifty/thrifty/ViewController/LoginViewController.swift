//
//  LoginViewController.swift
//  thrifty
//
//  Created by Kevin Wang on 11/7/18.
//  Copyright © 2018 Kevin Wang. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var Username: LoginSignupTextField!
    @IBOutlet weak var Password: LoginSignupTextField!
    
    var userEmail = ""
    var userPassword = ""
    
    @IBAction func LoginPressed(_ sender: Any) {
        guard let usernameText = Username.text else { return }
        guard let passwordText = Password.text else { return }
        
        if usernameText == "" || passwordText == "" {
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields
            let alertController = UIAlertController(title: "Log In Error", message: "Please enter an email and password.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            Auth.auth().signIn(withEmail: userEmail, password: userPassword) { (user, error) in
                if error == nil {
                    self.performSegue(withIdentifier: "LoginToHomePage", sender: self)
                }
                    // email and password fields are not blank, let's try logging in the user!
                    // you'll need to use `emailText` and `passwordText`, and a method found in this
                    // api doc https://firebase.google.com/docs/auth/ios/start
                    // if the error == nil, segue to the main page using `performSegue` with identifier
                    // `segueLogInToMainPage`
                    // if there is an error signing in (error != nil), present the following alert:
                else {
                    let alertController = UIAlertController(title: "Log In Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.Username.delegate = self
        self.Password.delegate = self 

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
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.Username {
            if textField.text != nil {
                self.userEmail = textField.text!
            }
        } else {
            if textField.text != nil {
                self.userPassword = textField.text!
            }
        }
    }

}
