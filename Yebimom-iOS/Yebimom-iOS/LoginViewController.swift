//
//  LoginViewController.swift
//  Yebimom-iOS
//
//  Created by wikibootup on 6/4/15.
//  Copyright (c) 2015 wikibootup. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func userNameTextFieldReturn(sender: UITextField) {
        sender.resignFirstResponder()
    }
    @IBAction func passwordTextFieldReturn(sender: UITextField) {
        sender.resignFirstResponder()
    }
    @IBAction func loginTry(sender: UIButton) {
        var loginAPIURL: String = "https://yebimom.com/api/login/"
        let parameters = [
            "username": [userNameTextField.text],
            "password": [passwordTextField.text]]
        
        /* TODO: 1. Try extension Alamofire class for handling response out of closure (add return value)
                 2. Get JWT value
        */
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        userNameTextField.endEditing(true)
        passwordTextField.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
