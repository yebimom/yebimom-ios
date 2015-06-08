//
//  LoginViewController.swift
//  Yebimom-iOS
//
//  Created by wikibootup on 6/4/15.
//  Copyright (c) 2015 wikibootup. All rights reserved.
//

/*
Session implementation highly referenced by 
https:// dipinkrishna.com/blog/2014/07/login-signup-screen-tutorial-xcode-6-swift-ios-8-json/
*/


import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

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
        // var loginAPIURL: String = "https://yebimom.com/api/login/"
        var username:NSString = userNameTextField.text
        var password:NSString = passwordTextField.text

        if(blankInfoCheckAndAlert(username, password: password) == false) {
            /* It will be good if Passwords are hashed */
            var url:NSURL = NSURL(string:"https://yebimom.com/api/login/")!
            var post:NSString = "username=\(username)&password=\(password)"
            var request:NSMutableURLRequest = setHTTPPostMethod(url, post: post)
            
            var reponseError: NSError?
            var response: NSURLResponse?
            var urlData: NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse:&response, error:&reponseError)

            if ( urlData != nil ) {
                let res = response as! NSHTTPURLResponse!;
                // NSLog("Response code: %ld", res.statusCode);
                if (res.statusCode >= 200 && res.statusCode < 300)
                {
                    var responseData:NSString  = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
                    // NSLog("Response ==> %@", responseData);
                    
                    var error: NSError?
                    let jsonData:NSDictionary = NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers , error: &error) as! NSDictionary

                    var token: AnyObject? = jsonData.valueForKey("token")
                    // println(jsonData.valueForKey("token"))
                    if(token != nil) {
                        
                    }
                    else {
                        tokenAbsentAlert(jsonData)
                    }
                    /*
                    
                    let jsonData:NSDictionary = NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers , error: &error) as! NSDictionary
                    
                    
                    let success:NSInteger = jsonData.valueForKey("success") as! NSInteger
                    
                    //[jsonData[@"success"] integerValue];
                    
                    NSLog("Success: %ld", success);
*/
                }
            }
        }
        /*
        if ( username.isEqualToString("") || password.isEqualToString("") ) {
            
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign in Failed!"
            alertView.message = "Please enter Username and Password"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        }
        */
        
        
        /*
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
*/
        /* If private service requested, token will be used like following statement
        request.responseJSON{ (req, res, json, error) in
            var json = JSON(json!)
            println(json["token"])
        }
        */
        
    }
    
    func blankInfoCheckAndAlert(username: NSString, password: NSString) -> Bool {
        if ( username.isEqualToString("") || password.isEqualToString("") ) {
            
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign in Failed!"
            alertView.message = "Please enter Username and Password"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
            
            return true
        }
        return false
    }
    
    func setHTTPPostMethod(url: NSURL, post:NSString) -> NSMutableURLRequest {
        var request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
        var postData:NSData = post.dataUsingEncoding(NSASCIIStringEncoding)!
        var postLength:NSString = String( postData.length )

        request.HTTPMethod = "POST"
        request.HTTPBody = postData
        request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
    
        return request
    }
    
    
    func tokenAbsentAlert(jsonData: NSDictionary) {
        var error_msg:NSString
        
        if jsonData["error_message"] as? NSString != nil {
            error_msg = jsonData["error_message"] as! NSString
        } else {
            error_msg = "JWT 토큰을 받아오는데 실패하였습니다. 관리자에게 문의해주세요."
        }
        var alertView:UIAlertView = UIAlertView()
        alertView.title = "Sign in Failed!"
        alertView.message = error_msg as String
        alertView.delegate = self
        alertView.addButtonWithTitle("OK")
        alertView.show()
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
