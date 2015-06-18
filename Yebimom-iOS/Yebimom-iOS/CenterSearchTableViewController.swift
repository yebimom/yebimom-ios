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

class CenterSearchTableViewController: UITableViewController, UISearchResultsUpdating {

    var centerNames = [String]()
    var filteredTableData = [String]()
    var resultSearchController = UISearchController()
    
    @IBOutlet weak var centerSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //categories cell
        let centersURL = NSURL(string:"https://yebimom.com/api/centers/")
        var centersJsonData = JSON(data: NSData(contentsOfURL: centersURL!)!)
        
        for (key: String, subJsonData: JSON)in centersJsonData {
            centerNames.append(subJsonData["name"].string!)
        }
        
        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            
            // Custom icon
            //controller.searchBar.positionAdjustmentForSearchBarIcon(<#icon: UISearchBarIcon#>)
            controller.searchBar.placeholder = "산후조리원 이름으로 검색하기"
            self.tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
        designSearchPageNavigationBar()
        
        // Reload the table
        self.tableView.reloadData()
    }
    
    func viewTransition(storyboardID: String) {
        var destViewController: UIViewController = self.storyboard?.instantiateViewControllerWithIdentifier(storyboardID) as! UIViewController
        
        self.presentViewController(destViewController, animated: false, completion: nil)
    }
    
    func backMain(sender: UIBarButtonItem) {
        navigationController?.popViewControllerAnimated(true)
        viewTransition("SideMenuNavView")
    }
    
    func designSearchPageNavigationBar() {
        let logo = UIImage(named: "menubar_logo.png")
        let imageView = UIImageView(image: logo)
        navigationItem.titleView = imageView
    }

    
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        filteredTableData.removeAll(keepCapacity: false)
        
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text)
        let array = (centerNames as NSArray).filteredArrayUsingPredicate(searchPredicate)
        filteredTableData = array as! [String]
        
        self.tableView.reloadData()
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
        // return centerNames.count
        if resultSearchController.active {
            return filteredTableData.count
        }
        else {
            return 0
            //return centerNames.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CenterSearchTableCell", forIndexPath: indexPath) as! CenterSearchTableViewCell

        if (self.resultSearchController.active) {
            cell.centerNameLabel?.text = filteredTableData[indexPath.row]
            return cell
        }
        else {
            cell.centerNameLabel?.text = centerNames[indexPath.row]
            return cell
        }
        
        /*
        if searchActive {
            cell.centerNameLabel.text = filtered[indexPath.row]
        }
        else {
            cell.centerNameLabel.text = centerNames[indexPath.row];
        }
        */
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
