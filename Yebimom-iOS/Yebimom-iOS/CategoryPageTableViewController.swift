//
//  CategoryPageTableViewController.swift
//  Yebimom-iOS
//
//  Created by wikibootup on 6/6/15.
//  Copyright (c) 2015 wikibootup. All rights reserved.
//

import UIKit
import SwiftyJSON
import SwiftOverlays

class CategoryPageTableViewController: UITableViewController {

    var categoryName: String?
    var categorySlug: String?
    
    var centerNames = [String]()
    var centerAddress = [String]()
    var centerHashID = [String]()
    var centerImageURLs = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 340
        
        // when overlay, overlay sign will be shown
        let text = "Please wait..."
        self.showWaitOverlayWithText(text)
    
        let centersOfCategoryURL = NSURL(string:"https://yebimom.com/api/categories/" + categorySlug!)
        var centersOfCategoryJsonData = JSON(data: NSData(contentsOfURL: centersOfCategoryURL!)!)

        for (key: String, subJsonData: JSON)in centersOfCategoryJsonData {
            centerNames.append(subJsonData["name"].stringValue)
            centerAddress.append(subJsonData["address"].stringValue)
            centerHashID.append(subJsonData["hash_id"].string!)
            if subJsonData["main_image_url"].string != nil {
                centerImageURLs.append(subJsonData["main_image_url"].string!)
            }
            else {
                centerImageURLs.append("")
            }
        }
        
        designCategoryPageNavigationBar()
        
        self.removeAllOverlays()
    }
    
    func viewTransition(storyboardID: String) {
        var destViewController: UIViewController = self.storyboard?.instantiateViewControllerWithIdentifier(storyboardID) as! UIViewController
        
        self.presentViewController(destViewController, animated: false, completion: nil)
    }
    
    func backMain(sender: UIBarButtonItem) {
        navigationController?.popViewControllerAnimated(true)
        viewTransition("SideMenuNavView")
    }
    
    func designCategoryPageNavigationBar() {
        navigationController!.navigationBar.barTintColor = UIColor.whiteColor()

        let logo = UIImage(named: "menubar_logo.png")
        let imageView = UIImageView(image: logo)
        navigationItem.titleView = imageView
        
        let backMainButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "backMain:")
        backMainButton.image = UIImage(named: "icon_back")
        navigationItem.leftBarButtonItem = backMainButton
        navigationItem.leftBarButtonItem?.tintColor = UIColor(hex: 0xc0392b)
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
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return centerNames.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CategoryPageTableCell", forIndexPath: indexPath) as! CategoryPageTableViewCell
        
        cell.centerNameLabel.text = centerNames[indexPath.row]
        cell.centerAddressLabel.text = centerAddress[indexPath.row]
        cell.centerImageURL.imageFromURL(centerImageURLs[indexPath.row], placeholder: UIImage(named: "blank_image_400x300")!, fadeIn: true) {
            (image: UIImage?) in
            if image != nil {
                cell.centerImageURL.image = image!
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
        if segue.identifier == "ShowCenterDetail" {
            let detailViewController = segue.destinationViewController as! CenterOfCategoryViewController
            let indexPath = self.tableView.indexPathForSelectedRow()
            detailViewController.centerHashID = centerHashID[indexPath!.row]
        }
    }
}

