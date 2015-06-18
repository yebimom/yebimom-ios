//
//  CenterOfCategoryViewController.swift
//  Yebimom-iOS
//
//  Created by wikibootup on 6/7/15.
//  Copyright (c) 2015 wikibootup. All rights reserved.
//

import UIKit
import SwiftyJSON
import GoogleMaps

class CenterOfCategoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var centerHashID: String?
    var facilities = [String]()
    
    @IBOutlet weak var facilityTableView: UITableView!
    @IBOutlet weak var centerNameLabel: UILabel!
    @IBOutlet weak var mapViewOutlet: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let centerDetailOfCategoryURL = NSURL(string:"https://yebimom.com/api/centers/" + centerHashID!)
        var centerDetailOfCategoryJsonData = JSON(data: NSData(contentsOfURL: centerDetailOfCategoryURL!)!)
        let centerName: String? = centerDetailOfCategoryJsonData["name"].string
        
        for (key: String, subJsonData: JSON)in centerDetailOfCategoryJsonData["facility_set"] {
            facilities.append(subJsonData.stringValue)
        }
        centerNameLabel.text = centerName
    
        facilityTableView.dataSource = self
        
        // Center location map using Google Map
        let latitude = centerDetailOfCategoryJsonData["latitude"].double
        let longitude = centerDetailOfCategoryJsonData["longitude"].double
        let coordinate = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
        mapViewOutlet.camera = GMSCameraPosition.cameraWithTarget(coordinate, zoom: 16)
        
        var locationMarker = GMSMarker(position: coordinate)
        locationMarker.snippet = centerName
        locationMarker.appearAnimation = kGMSMarkerAnimationPop
        locationMarker.map = mapViewOutlet
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return facilities.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "FacilityTableCell")
        
        cell.textLabel?.text = facilities[indexPath.row]
        cell.imageView!.image = UIImage(named: "logo.png")
        return cell
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
