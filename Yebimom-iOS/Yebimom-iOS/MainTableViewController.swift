//
//  MainTableViewController.swift
//  Yebimom-iOS
//
//  Created by wikibootup on 6/3/15.
//  Copyright (c) 2015 wikibootup. All rights reserved.
//

import UIKit
import SwiftyJSON

class MainTableViewController: UITableViewController, ENSideMenuDelegate {
    
    var categoryNames = [String]()
    var cetegorySlugs = [String]()
    
    var numOfEvents: Int = 0
    var numOfCentersOfCategory = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 340
        
        self.sideMenuController()?.sideMenu?.delegate = self
        
        //categories cell
        let categoryURL = NSURL(string:"https://yebimom.com/api/categories/")
        var categoryJsonData = JSON(data: NSData(contentsOfURL: categoryURL!)!)
        
        for (key: String, subJsonData: JSON)in categoryJsonData {
            categoryNames.append(subJsonData["name"].string!)
            cetegorySlugs.append(subJsonData["slug"].string!)
        }
        
        /* api error : need fix */
        // events cell
        //let eventURL = NSURL(string:"https://yebimom.com/api/events/")
        //var eventJsonData = JSON(data: NSData(contentsOfURL: eventURL!)!)
        //numOfEvents = eventJsonData.count
        numOfEvents = 0
        
    }

    @IBAction func menuENSide(sender: UIBarButtonItem) {
        toggleSideMenuView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section) {
            case 0:
                return 1
            case 1:
                return categoryNames.count
            default:
                return 0
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch(indexPath.section) {
            case 0:
                let cell = tableView.dequeueReusableCellWithIdentifier("EventTableCell", forIndexPath: indexPath) as! EventTableViewCell
                    cell.numOfEventsLabel.text = "\(numOfEvents) 건"
                return cell
            case 1:
                let cell = tableView.dequeueReusableCellWithIdentifier("CategoryTableCell", forIndexPath: indexPath) as! CategoryTableViewCell
                cell.categoryNameLabel.text = categoryNames[indexPath.row]
                return cell
            default:
                let cell: UITableViewCell! = nil
                return cell
        }
        
        let cell: UITableViewCell! = nil
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
