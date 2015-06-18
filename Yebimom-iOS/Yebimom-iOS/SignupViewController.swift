//
//  SignupViewController.swift
//  
//
//  Created by wikibootup on 6/5/15.
//
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImageName: String = "main_0.png"
        applyBackgroundImageSizeToFit(backgroundImageName)

        designSignUpNavigationBar()
    }
    
    @IBAction func showMainView(sender: UIBarButtonItem) {
        viewTransition("SideMenuNavView")
    }
    
    @IBAction func showLoginView(sender: UIButton) {
        storyBoardTransition("LoginBoard")
    }
    
    @IBAction func userNameTextFieldReturn(sender: UITextField) {
        sender.resignFirstResponder()
    }
    @IBAction func passwordTextFieldReturn(sender: UITextField) {
        sender.resignFirstResponder()
    }
    @IBAction func passwordConfirmTextFieldReturn(sender: UITextField) {
        sender.resignFirstResponder()
    }

    @IBAction func signupTry(sender: UIButton) {
    }
    
    func designSignUpNavigationBar() {
        navigationController?.navigationBar.hidden = true
    }
    
    func applyBackgroundImageSizeToFit(fileName: String) {
        UIGraphicsBeginImageContext(view.frame.size)
        UIImage(named: fileName)?.drawInRect(view.bounds)
        var backGroundImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        view.backgroundColor = UIColor(patternImage: backGroundImage)
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
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        userNameTextField.endEditing(true)
        passwordTextField.endEditing(true)
        passwordConfirmTextField.endEditing(true)
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
