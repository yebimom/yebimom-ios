//
//  LoginOrRegisterViewController.swift
//  Yebimom-iOS
//
//  Created by wikibootup on 6/9/15.
//  Copyright (c) 2015 wikibootup. All rights reserved.
//

import UIKit

class LoginOrRegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBarHidden = true
    }

    @IBAction func showMainView(sender: UIBarButtonItem) {
        viewTransition("SideMenuNavView")
    }
    
    @IBAction func showRegisterView(sender: UIButton) {
        viewTransition("RegisterBoard")
    }
    
    @IBAction func showLoginView(sender: UIButton) {
        viewTransition("LoginBoard")
    }
    
    func viewTransition(storyboardID: String) {
        var destViewController: UIViewController = self.storyboard?.instantiateViewControllerWithIdentifier(storyboardID) as! UIViewController
        
        self.presentViewController(destViewController, animated: false, completion: nil)
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
