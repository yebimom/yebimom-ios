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
        var destViewController: UIViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MainBoard") as! UIViewController
        
        self.presentViewController(destViewController, animated: false, completion: nil)
    }
    
    @IBAction func showRegisterView(sender: UIButton) {
        var destViewController: UIViewController = self.storyboard?.instantiateViewControllerWithIdentifier("RegisterBoard") as! UIViewController
        self.presentViewController(destViewController, animated: false, completion: nil)
    }
    
    @IBAction func showLoginView(sender: UIButton) {
        var destViewController: UIViewController = self.storyboard?.instantiateViewControllerWithIdentifier("LoginBoard") as! UIViewController
        self.presentViewController(destViewController, animated: false, completion: nil)
    }
    
    func addLeftNavItemOnView (iconName: String?)
    {
        // hide default navigation bar button item
        // self.navigationItem.leftBarButtonItem = nil;
        // self.navigationItem.hidesBackButton = true;
        
        let buttonBack: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        buttonBack.frame = CGRectMake(0, 0, 40, 40)
        buttonBack.setImage(UIImage(named: iconName!), forState: UIControlState.Normal)
        buttonBack.addTarget(self, action: "leftNavButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        
        var leftBarButtonItem: UIBarButtonItem = UIBarButtonItem(customView: buttonBack)
        
        self.navigationItem.setLeftBarButtonItem(leftBarButtonItem, animated: false)
    }
    
    func leftNavButtonClick(sender:UIButton!) {
        var destViewController: UIViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MainBoard") as! UIViewController

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
