//
//  LoginViewController.swift
//  Yebimom-iOS
//
//  Created by wikibootup on 6/4/15.
//  Copyright (c) 2015 wikibootup. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

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
            "username": userNameTextField.text,
            "password": passwordTextField.text]
        
        let request = Alamofire.request(.POST, loginAPIURL, parameters: parameters, encoding: .JSON).responseJSON { (req, res, json, error) in
            if(error != nil) {
                NSLog("Error: \(error)")
                println("request: " + req.debugDescription)
                println("response: " + res.debugDescription)
            }
            else {
                var json = JSON(json!)
                if json["token"] == nil {
                    println("Token not arrived")
                    println(res?.debugDescription)
                }
            }
        }
        /* If private service requested, token will be used like following statement
        request.responseJSON{ (req, res, json, error) in
            var json = JSON(json!)
            println(json["token"])
        }
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
