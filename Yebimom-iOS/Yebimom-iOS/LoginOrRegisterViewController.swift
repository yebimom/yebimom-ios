//
//  LoginOrRegisterViewController.swift
//  Yebimom-iOS
//
//  Created by wikibootup on 6/9/15.
//  Copyright (c) 2015 wikibootup. All rights reserved.
//

import UIKit
import DynamicColor

class LoginOrRegisterViewController: UIViewController {

    @IBOutlet weak var navBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let backMainButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "backMain:")
        backMainButton.image = UIImage(named: "icon_back")
        backMainButton.tintColor = UIColor(hex: 0xc0392b)
        navigationItem.leftBarButtonItem = backMainButton
        applyBackgroundImageSizeToFit("main_0.png")
    }

    @IBAction func showMainView(sender: UIBarButtonItem) {
        viewTransition("SideMenuNavView")
    }
    
    @IBAction func showRegisterView(sender: UIButton) {
        storyBoardTransition("RegisterBoard")
    }
    
    @IBAction func showLoginView(sender: UIButton) {
        storyBoardTransition("LoginBoard")
    }
    
    func backMain(sender: UIBarButtonItem) {
        navigationController?.popViewControllerAnimated(true)
        viewTransition("SideMenuNavView")
    }
    
    func viewTransition(storyboardID: String) {
        var destViewController: UIViewController = self.storyboard?.instantiateViewControllerWithIdentifier(storyboardID) as! UIViewController
        
        self.presentViewController(destViewController, animated: false, completion: nil)
    }
    
    func applyBackgroundImageSizeToFit(fileName: String) {
        UIGraphicsBeginImageContext(view.frame.size)
        UIImage(named: fileName)?.drawInRect(view.bounds)
        var backGroundImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        view.backgroundColor = UIColor(patternImage: backGroundImage)
    }
    
    func storyBoardTransition(storyBoardID: String) {
        // Cannot change this method to "viewTransition", that occur some problems
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        destViewController = mainStoryboard.instantiateViewControllerWithIdentifier(storyBoardID) as! UIViewController
        sideMenuController()?.setContentViewController(destViewController)
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
