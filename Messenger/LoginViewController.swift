//
//  LoginViewController.swift
//  Messenger
//
//  Created by Alvin Magee on 6/26/17.
//  Copyright © 2017 Alvin Magee. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UITextField!
    
    @IBOutlet weak var passwordLabel: UITextField!
    
    let alertController = UIAlertController(title: "Empty inputs", message: "Please provide both a username and a password", preferredStyle: .alert)
    
    let invalidUserName = UIAlertController(title: "Invalid Username", message: "This username already exists. Please choose another username", preferredStyle: .alert)
    
    let invalidLoginCredentials = UIAlertController(title: "Invalid Login Credentials", message: "Please ensure that you are using the correct username and password and try again", preferredStyle: .alert)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // handle response here.
        }
        alertController.addAction(OKAction)
        invalidUserName.addAction(OKAction)
        invalidLoginCredentials.addAction(OKAction)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapSignUp(_ sender: Any) {
        let newUser = PFUser()
        
        let username = usernameLabel.text as! String
        let password = passwordLabel.text as! String
        
        if username.isEmpty || password.isEmpty
        {
            present(self.alertController, animated: true) {
                
            }
            
        } else {
        
        newUser.username = usernameLabel.text
        newUser.password = passwordLabel.text
        
        
        
        newUser.signUpInBackground { (Bool, error: Error?) in
            
            if let error = error {
                let errorInfo = error._userInfo as! [String: Any]
                let code = errorInfo["code"] as! Int
                if code == 202 {
                    self.present(self.invalidUserName, animated: true) {
                        
                    }
                }
            } else {
                print("User Registered successfully")
                // manually segue to logged in view
            }
        }
        }
    }
    
    
    @IBAction func didTapLogin(_ sender: Any) {
        
        let username = usernameLabel.text ?? ""
        let password = passwordLabel.text ?? ""
        
        if username.isEmpty || password.isEmpty {
            present(self.alertController, animated: true) {
                
            }
        } else {
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                let errorInfo = error._userInfo as! [String: Any]
                let code = errorInfo["code"] as! Int
                if code == 101 {
                    self.present(self.invalidLoginCredentials, animated: true) {
                        
                    }
                }
                
            } else {
                print("User logged in successfully")
                // display view controller that needs to shown after successful login
            }
            
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
