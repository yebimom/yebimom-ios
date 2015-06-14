//
//  ENSideMenuTableViewController.swift
//  Yebimom-iOS
//
//  Created by wikibootup on 6/3/15.
//  Copyright (c) 2015 wikibootup. All rights reserved.
//

import UIKit

class ENSideMenuTableViewController: UITableViewController {
    var selectedMenuItem : Int = 0
    var sideMenuList = [String()]
    var session:NSUserDefaults = NSUserDefaults.standardUserDefaults()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        var isLoggedIn: Bool = session.boolForKey("ISLOGGEDIN")
        // println(isLoggedIn)
        if isLoggedIn {
            var username: AnyObject? = session.objectForKey("USERNAME") as! String
            println("qqq" + "aaa")
            sideMenuList = [" 님 환영합니다", "", "", "", "", "", "", "Logout"]
        }
        else {
            sideMenuList = ["", "", "", "", "", "", "", "Login or Register"]
        }
        
        
        // Customize apperance of table view
        tableView.contentInset = UIEdgeInsetsMake(64.0, 0, 0, 0) //
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor.clearColor()
        tableView.scrollsToTop = false
        
        // Preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
        tableView.selectRowAtIndexPath(NSIndexPath(forRow: selectedMenuItem, inSection: 0), animated: false, scrollPosition: .Middle)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return 8
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("CELL") as? UITableViewCell
        
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "CELL")
            cell!.backgroundColor = UIColor.whiteColor()
            cell!.textLabel?.textColor = UIColor.blackColor()
            let selectedBackgroundView = UIView(frame: CGRectMake(0, 0, cell!.frame.size.width, cell!.frame.size.height))
            selectedBackgroundView.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.2)
            cell!.selectedBackgroundView = selectedBackgroundView
        }
        
        cell!.textLabel?.text = sideMenuList[indexPath.row]
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
    
    func storyBoardTransition(storyBoardID: String) {
        // Cannot change this method to "viewTransition", that occur some problems
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        destViewController = mainStoryboard.instantiateViewControllerWithIdentifier(storyBoardID) as! UIViewController
        sideMenuController()?.setContentViewController(destViewController)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // println("did select row: \(indexPath.row)")
        
        if (indexPath.row == selectedMenuItem) {
            return
        }
        selectedMenuItem = indexPath.row
        
        switch (indexPath.row) {
            case 7:
                if session.boolForKey("ISLOGGEDIN") {
                    var session:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                    session.removeObjectForKey("USERNAME")
                    session.setBool(false, forKey: "ISLOGGEDIN")
                    session.synchronize()
                    storyBoardTransition("Main")
                }
                else {
                    storyBoardTransition("LoginOrRegister")
                }
            default:
                storyBoardTransition("Main")
        }
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
}
    