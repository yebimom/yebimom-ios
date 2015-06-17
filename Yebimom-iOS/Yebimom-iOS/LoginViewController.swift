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
        
        designLoginNavigationBar()
        applyBackgroundImageSizeToFit("main_0.png")
    }

    @IBAction func showMainView(sender: UIBarButtonItem) {
        viewTransition("SideMenuNavView")
    }
    
    @IBAction func showRegisterView(sender: UIButton) {
        storyBoardTransition("RegisterBoard")
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

        if blankInfoCheckAndAlert(username, password: password) == false {
            /* It will be good if Passwords are hashed */
            var url:NSURL = NSURL(string:"https://yebimom.com/api/login/")!
            var post:NSString = "username=\(username)&password=\(password)"
            var request:NSMutableURLRequest = setHTTPPostMethod(url, post: post)
            
            var reponseError: NSError?
            var response: NSURLResponse?
            var urlData: NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse:&response, error:&reponseError)

            if urlData != nil {
                let res = response as! NSHTTPURLResponse!;
                // NSLog("Response code: %ld", res.statusCode);
                if res.statusCode >= 200 && res.statusCode < 300 {
                    var token: AnyObject? = getTokenFromResponseData(urlData!)
                    // println(jsonData.valueForKey("token"))
                    if token != nil {
                        loginSuccess(username)
                        viewTransition("SideMenuNavView")
                    }
                    else {
                        tokenAbsentAlert()
                    }
                }
                else if res.statusCode == 400 {
                    incorrectUserInfoAlert()
                }
                else {
                    connectionFailure(reponseError)
                }
            }
            else {
                connectionFailure(reponseError)
            }
        }
    }    
    
    func applyBackgroundImageSizeToFit(fileName: String) {
        UIGraphicsBeginImageContext(view.frame.size)
        UIImage(named: fileName)?.drawInRect(view.bounds)
        var backGroundImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        view.backgroundColor = UIColor(patternImage: backGroundImage)
    }

    func designLoginNavigationBar() {
        navigationController?.navigationBar.hidden = true
    }
    
    func viewTransition(storyboardID: String) {
        var destViewController: UIViewController = self.storyboard?.instantiateViewControllerWithIdentifier(storyboardID) as! UIViewController
        
        self.presentViewController(destViewController, animated: false, completion: nil)
    }
    
    func storyBoardTransition(storyBoardID: String) {
        // Cannot change this method to "viewTransition", that occur some problems
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        destViewController = mainStoryboard.instantiateViewControllerWithIdentifier(storyBoardID) as! UIViewController
        sideMenuController()?.setContentViewController(destViewController)
    }
    
    func blankInfoCheckAndAlert(username: NSString, password: NSString) -> Bool {
        if ( username.isEqualToString("") || password.isEqualToString("") ) {
            
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "로그인 실패"
            alertView.message = "Please enter Username and Password"
            alertView.delegate = self
            alertView.addButtonWithTitle("확인")
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
    
    func getTokenFromResponseData(urlData: NSData) -> AnyObject {
        var responseData:NSString  = NSString(data:urlData, encoding:NSUTF8StringEncoding)!
        // NSLog("Response ==> %@", responseData);
        
        var error: NSError?
        let jsonData:NSDictionary = NSJSONSerialization.JSONObjectWithData(urlData, options:NSJSONReadingOptions.MutableContainers , error: &error) as! NSDictionary
        
        return jsonData.valueForKey("token")!
    }
    
    func tokenAbsentAlert() {
        var error_msg:NSString = "JWT 토큰을 받아오는데 실패하였습니다. 관리자에게 문의해주세요."
        var alertView:UIAlertView = UIAlertView()
        alertView.title = "로그인 실패"
        alertView.message = error_msg as String
        alertView.delegate = self
        alertView.addButtonWithTitle("확인")
        alertView.show()
    }
    
    func loginSuccess(username: NSString) {
        // NSLog("Login SUCCESS");
        var session:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        session.setObject(username, forKey: "USERNAME")
        session.setBool(true, forKey: "ISLOGGEDIN")
        session.synchronize()
        
        // for using 'presentViewController' mehod, this instruction was commented
        //self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func incorrectUserInfoAlert() {
        var alertView:UIAlertView = UIAlertView()
        alertView.title = "로그인 실패"
        alertView.message = "입력하신 회원정보가 존재하지 않거나\n 다른 정보가 입력되었습니다"
        alertView.delegate = self
        alertView.addButtonWithTitle("확인")
        alertView.show()
        
    }
    
    func connectionFailure(reponseError: NSError?) {
        var alertView:UIAlertView = UIAlertView()
        alertView.title = "로그인 실패"
        if (reponseError) != nil {
            alertView.message = reponseError?.localizedDescription
        }
        else {
            alertView.message = "Connection Failed"
        }
        alertView.delegate = self
        alertView.addButtonWithTitle("확인")
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
