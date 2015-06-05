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

        // Do any additional setup after loading the view.
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
