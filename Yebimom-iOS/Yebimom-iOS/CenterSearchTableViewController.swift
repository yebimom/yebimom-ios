//
//  CenterSearchTableViewController.swift
//  Yebimom-iOS
//
//  Created by wikibootup on 6/15/15.
//  Copyright (c) 2015 wikibootup. All rights reserved.
//
//  Highly referenced by http:// www.raywenderlich.com/76519/add-table-view-search-swift

import UIKit
import SwiftyJSON

class CenterSearchTableViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {

    var centerNames = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let backMainButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "backMain:")
        backMainButton.image = UIImage(named: "icon_back")
        navigationItem.leftBarButtonItem = backMainButton
        
        //categories cell
        let centersURL = NSURL(string:"https://yebimom.com/api/centers/")
        var centersJsonData = JSON(data: NSData(contentsOfURL: centersURL!)!)
        
        for (key: String, subJsonData: JSON)in centersJsonData {
            centerNames.append(subJsonData["name"].string!)
        }
        
    }
    
    func viewTransition(storyboardID: String) {
        var destViewController: UIViewController = self.storyboard?.instantiateViewControllerWithIdentifier(storyboardID) as! UIViewController
        
        self.presentViewController(destViewController, animated: false, completion: nil)
    }
    
    func backMain(sender: UIBarButtonItem) {
        navigationController?.popViewControllerAnimated(true)
        viewTransition("SideMenuNavView")
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
        let cell = tableView.dequeueReusableCellWithIdentifier("CenterSearchTableCell", forIndexPath: indexPath) as! CenterSearchTableViewCell

        cell.centerNameLabel.text = centerNames[indexPath.row]

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
