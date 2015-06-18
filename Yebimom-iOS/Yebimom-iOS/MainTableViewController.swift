//
//  MainTableViewController.swift
//  Yebimom-iOS
//
//  Created by wikibootup on 6/3/15.
//  Copyright (c) 2015 wikibootup. All rights reserved.
//

import UIKit
import SwiftyJSON
import SwiftOverlays

class MainTableViewController: UITableViewController, ENSideMenuDelegate {

    var categoryNames = [String]()
    var cetegorySlugs = [String]()
    var numOfCentersOfCategory = [Int]()
    var imageURLS = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Wait overlay with text
        let text = "Please wait..."
        showWaitOverlayWithText(text)
        
        sideMenuController()?.sideMenu?.delegate = self
        
        // This app use Custom swipe
        sideMenuController()?.sideMenu?.allowLeftSwipe = false
        sideMenuController()?.sideMenu?.allowRightSwipe = false
        
        //categories cell
        let categoryURL = NSURL(string:"https://yebimom.com/api/categories/")
        var categoryJsonData = JSON(data: NSData(contentsOfURL: categoryURL!)!)
        let centersOfCategoryURL = NSURL(string:"https://yebimom.com/api/categories/")
        
        for (key: String, subJsonData: JSON)in categoryJsonData {
            categoryNames.append(subJsonData["name"].string!)
            cetegorySlugs.append(subJsonData["slug"].string!)
            if subJsonData["image"].string != nil {
                imageURLS.append(subJsonData["image"].string!)
            }
            else {
                imageURLS.append("")
            }
            
            let centersOfCategoryURL = NSURL(string:"https://yebimom.com/api/categories/" + subJsonData["slug"].string!)
            var centersOfCategoryJsonData = JSON(data: NSData(contentsOfURL: centersOfCategoryURL!)!)
            numOfCentersOfCategory.append(centersOfCategoryJsonData.count)
        }
        
        // Navigation bar setting
        designMainNavigationBar()
        
        removeAllOverlays()
    }
    
    func designMainNavigationBar() {
        navigationController!.navigationBar.barTintColor = UIColor.whiteColor()

        let logo = UIImage(named: "menubar_logo.png")
        let imageView = UIImageView(image: logo)
        navigationItem.titleView = imageView
    }
    
    func blurEffectToDisabledView() {
        UIView.animateWithDuration(0, delay: 0.0,
            options: UIViewAnimationOptions.CurveLinear,
            animations: {
            },
            completion: ({finished in
                if (finished) {
                    UIView.animateWithDuration(0.5, animations: {
                        self.view.alpha = 0.9
                        self.view.backgroundColor = UIColor.darkGrayColor()
                    })
                }
            }))
    }
    
    func releaseBlurEffectToView() {
        UIView.animateWithDuration(0, delay: 0.0,
            options: UIViewAnimationOptions.CurveLinear,
            animations: {
            },
            completion: ({finished in
                if (finished) {
                    UIView.animateWithDuration(0.5, animations: {
                        self.view.alpha = 1.0
                        self.view.backgroundColor = UIColor.whiteColor()
                    })
                }
            }))
    }

    
    override func hideSideMenuView() {
        sideMenuController()?.sideMenu?.hideSideMenu()
        view.userInteractionEnabled = true
    }

    override func showSideMenuView() {
        sideMenuController()?.sideMenu?.showSideMenu()
        view.userInteractionEnabled = false
    }
    
    override func toggleSideMenuView () {
        if isSideMenuOpen() {
            hideSideMenuView()
            releaseBlurEffectToView()
        }
        else {
            showSideMenuView()
            blurEffectToDisabledView()
        }
    }
    
    @IBAction func sideMenuInfo(sender: UIBarButtonItem) {
        toggleSideMenuView()
    }
    
    func storyBoardTransition(storyBoardID: String) {
        // Cannot change this method to "viewTransition", that occur some problems
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        destViewController = mainStoryboard.instantiateViewControllerWithIdentifier(storyBoardID) as! UIViewController
        sideMenuController()?.setContentViewController(destViewController)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryNames.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CategoryTableCell", forIndexPath: indexPath) as! CategoryTableViewCell
        cell.categoryNameLabel.text = categoryNames[indexPath.row]
        cell.numOfCentersOfCategoryLabel.text = "\(numOfCentersOfCategory[indexPath.row]) 곳"
        
        cell.categoryImage.imageFromURL(imageURLS[indexPath.row], placeholder: UIImage(), fadeIn: true) {
            (image: UIImage?) in
            if image != nil {
                cell.categoryImage.image = image!
            }
        }
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowCategoryPage" {
            let categoryPageViewController = segue.destinationViewController as! CategoryPageTableViewController
            
            let indexPath = self.tableView.indexPathForSelectedRow()
            categoryPageViewController.categoryName = categoryNames[indexPath!.row]
            categoryPageViewController.categorySlug = cetegorySlugs[indexPath!.row]
        }
        
    }
}
