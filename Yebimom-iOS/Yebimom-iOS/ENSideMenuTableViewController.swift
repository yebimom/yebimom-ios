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

        /*
        var isLoggedIn: Bool = session.boolForKey("ISLOGGEDIN")
        // println(isLoggedIn)
        if isLoggedIn {
            var username: String = session.objectForKey("USERNAME") as! String
            sideMenuList = [
                username + " 님 환영합니다",
                "",
                "",
                "",
                "",
                "",
                "",
                "Logout"
            ]
        }
        else {
            sideMenuList = [
                "",
                "",
                "",
                "",
                "",
                "",
                "",
                "Login or Register"
            ]
        }
        */
        
        // Customize apperance of table view
        tableView.contentInset = UIEdgeInsetsMake(64.0, 0, 0, 0) //
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor.whiteColor()//UIColor.clearColor()
        tableView.scrollsToTop = false
        
        // Preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
        tableView.selectRowAtIndexPath(NSIndexPath(forRow: selectedMenuItem, inSection: 0), animated: false, scrollPosition: .Middle)
    }
    
    func setBackgroundOfCell(cell: UITableViewCell) {
        let selectedBackgroundView = UIView(frame: CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height))
        cell.selectedBackgroundView = selectedBackgroundView
        cell.backgroundColor = UIColor.clearColor()
        
    }
    
    func setTextOfCell(cell: UITableViewCell) {
        cell.textLabel?.textColor = UIColor.darkGrayColor()
        cell.textLabel?.font = UIFont (name: "BM JUA_OTF", size: 15)
    }
    
    func setCategoryTextOfCell(cell: UITableViewCell) {
        cell.textLabel?.textColor = UIColor.darkGrayColor()
        cell.textLabel?.font = UIFont (name: "BM JUA_OTF", size: 12)
    }
    
    func setContentsOfCell(cell: UITableViewCell, text: String, imageName: String) {
        cell.textLabel!.setTranslatesAutoresizingMaskIntoConstraints(false)
        cell.imageView!.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        cell.textLabel?.text = text
        cell.imageView!.image = UIImage(named: imageName)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 8
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("CELL") as? UITableViewCell

        cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "CELL")
        
        setBackgroundOfCell(cell!)
        setTextOfCell(cell!)
        
        switch (indexPath.section) {
            case 0:
                setContentsOfCell(cell!, text: "로그인 또는 회원가입", imageName: "icon_user_mother.png")
            case 1:
                setContentsOfCell(cell!, text: "", imageName: "icon_user_mother.png")
            case 2:
                setContentsOfCell(cell!, text: "전망이 좋은", imageName: "icon_view.png")
                setCategoryTextOfCell(cell!)
            case 3:
                setContentsOfCell(cell!, text: "가성비가 좋은", imageName: "icon_price.png")
                setCategoryTextOfCell(cell!)
            case 4:
                setContentsOfCell(cell!, text: "리뷰가 많은", imageName: "icon_review.png")
                setCategoryTextOfCell(cell!)
            case 5:
                setContentsOfCell(cell!, text: "연예인이 방문한", imageName: "icon_celeb.png")
                setCategoryTextOfCell(cell!)
            case 6:
                setContentsOfCell(cell!, text: "이벤트를 진행중인", imageName: "icon_event.png")
                setCategoryTextOfCell(cell!)
            case 7:
                setContentsOfCell(cell!, text: "로그인 또는 회원가입", imageName: "icon_user_mother.png")
            default:
                break
        }
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
    