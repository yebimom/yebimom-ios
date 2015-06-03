//
//  ENSwiftSideMenuNavViewController.swift
//  Yebimom-iOS
//
//  Created by wikibootup on 6/3/15.
//  Copyright (c) 2015 wikibootup. All rights reserved.
//

import UIKit

class ENSwiftSideMenuNavViewController: ENSideMenuNavigationController, ENSideMenuDelegate {
        override func viewDidLoad() {
            super.viewDidLoad()
            sideMenu = ENSideMenu(sourceView: self.view, menuViewController: ENSideMenuTableViewController(), menuPosition: .Left)
            
            // Swipe set, default true
            // sideMenu?.allowLeftSwipe = false
            // sideMenu?.allowRightSwipe = false
            
            sideMenu?.menuWidth = 280.0 // optional, default is 160
            sideMenu?.bouncingEnabled = false
            
            // make navigation bar showing over side menu
            view.bringSubviewToFront(navigationBar)
            
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