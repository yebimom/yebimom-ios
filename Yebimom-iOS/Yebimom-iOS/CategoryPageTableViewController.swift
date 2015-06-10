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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 340
        
        // when overlay, overlay sign will be shown
        let text = "Please wait..."
        self.showWaitOverlayWithText(text)
    
        let centersOfCategoryURL = NSURL(string:"https://yebimom.com/api/categories/" + categorySlug!)
        var centersOfCategoryJsonData = JSON(data: NSData(contentsOfURL: centersOfCategoryURL!)!)

        for (key: String, subJsonData: JSON)in centersOfCategoryJsonData {
            centerNames.append(subJsonData["name"].string!)
            centerAddress.append(subJsonData["address"].string!)
            centerHashID.append(subJsonData["hash_id"].string!)
        }
        
        
        self.removeAllOverlays()
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

