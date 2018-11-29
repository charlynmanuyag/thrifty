//
//  SignupViewController.swift
//  thrifty
//
//  Created by Kevin Wang on 11/7/18.
//  Copyright © 2018 Kevin Wang. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignupViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var firstName: LoginSignupTextField!
    @IBOutlet weak var lastName: LoginSignupTextField!
    @IBOutlet weak var password: LoginSignupTextField!
    @IBOutlet weak var confirmPassword: LoginSignupTextField!
    @IBOutlet weak var email: LoginSignupTextField!
    
    var userEmail = ""
    var first = ""
    var last = ""
    var userPassword = ""
    var userVerifiedPassword = ""
    
    @IBAction func signUpPressed(_ sender: Any) {
        guard let userEmail = email.text else { return }
        guard let userPassword = password.text else { return }
        guard let first = firstName.text else { return }
        guard let last = lastName.text else { return }
        guard let userVerifiedPassword = confirmPassword.text else { return }
        
        if userEmail == "" || userPassword == "" || first == "" || userVerifiedPassword == "" || last == ""  {
            let alertController = UIAlertController(title: "Form Error.", message: "Please fill in form completely.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
            
        } else {
            Auth.auth().createUser(withEmail: userEmail, password: userPassword) { (user, error) in
                if error == nil {
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = userEmail
                    changeRequest?.commitChanges { (error) in
                        if error == nil {
                            let alertController = UIAlertController(title: "Display Name Ceeated!", message: "Congrats! You have created a new Thrifty Account!", preferredStyle: .alert)
                            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: {_ in self.performSegue(withIdentifier: "SignupToWelcome", sender: self)})
                            alertController.addAction(defaultAction)
                            self.present(alertController, animated: true, completion: nil)
                        }
                        else {
                            let alertController = UIAlertController(title: "Sign Up Error", message: error?.localizedDescription, preferredStyle: .alert)
                            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            alertController.addAction(defaultAction)
                            self.present(alertController, animated: true, completion: nil)
                        }
                    }
                    // TO DO:
                    // The user account has been successfully created. Now, update the user's name in
                    // firebase and then perform a segue to the main page. Note, again, that this segue
                    // already exists somewhere, just do some simple debugging to find the identifier.
                    // Also, notify the user that the account has been successfully created before
                    // performing the segue.
                    guard (user?.user) != nil else { return }
                    let alertController = UIAlertController(title: "New Account Created", message: "Congrats! You have created a new Thrifty Account!", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: {_ in self.performSegue(withIdentifier: "SignupToWelcome", sender: self)})
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                } else if userPassword != userVerifiedPassword {
                    let alertController = UIAlertController(title: "Verification Error.", message: "The two passwords do not match.", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.confirmPassword.textColor = UIColor.red
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    let alertController = UIAlertController(title: "Sign Up Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SignupToWelcome" {
            let dest = segue.destination as! SignupWelcomeSurveyViewController
            dest.name = first
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.firstName.delegate = self
        self.lastName.delegate = self
        self.password.delegate = self
        self.confirmPassword.delegate = self
        self.email.delegate = self

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
        if textField == self.firstName {
            if textField.text != nil {
                self.first = textField.text!
            }
        } else if textField == self.lastName {
            if textField.text != nil {
                self.last = textField.text!
            }
        } else if textField == self.password {
            if textField.text != nil {
                self.userPassword = textField.text!
            }
        } else if textField == self.confirmPassword {
            if textField.text != nil {
                self.userVerifiedPassword = textField.text!
            }
        }
        else if textField == self.email {
            if textField.text != nil {
                self.userEmail = textField.text!
            }
        }
    }

}
