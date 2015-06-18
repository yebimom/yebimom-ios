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
    @IBOutlet weak var centerAddressLabel: UILabel!
    @IBOutlet weak var centerImage: UIImageView!
    
    @IBOutlet weak var mapViewOutlet: GMSMapView!
    
    @IBOutlet weak var detailAddressLabel: UILabel!
    @IBOutlet weak var datailContactNumberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let centerDetailOfCategoryURL = NSURL(string:"https://yebimom.com/api/centers/" + centerHashID!)
        var centerDetailOfCategoryJsonData = JSON(data: NSData(contentsOfURL: centerDetailOfCategoryURL!)!)
        
        // Center Info
        let centerName: String? = centerDetailOfCategoryJsonData["name"].string
        let centerAddress: String? = centerDetailOfCategoryJsonData["address"].stringValue
        let centerImageURL: String? = centerDetailOfCategoryJsonData["main_image_url"].stringValue
        let centerContactNumber: String? = centerDetailOfCategoryJsonData["phone"].stringValue

        for (key: String, subJsonData: JSON)in centerDetailOfCategoryJsonData["facility_set"] {
            facilities.append(subJsonData.stringValue)
        }
        
        
        // Center Basic info view
        centerNameLabel.text = centerName
        centerAddressLabel.text = centerAddress
        centerImage.imageFromURL(centerImageURL!, placeholder: UIImage(), fadeIn: true) {
            (image: UIImage?) in
            if image != nil {
                self.centerImage.image = image
            }
        }
    
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
        
        
        // Detail
        detailAddressLabel.text = centerAddress
        datailContactNumberLabel.text = centerContactNumber
        
        designCenterDetailNavigationBar()
    }
    
    func designCenterDetailNavigationBar() {
        navigationController!.navigationBar.barTintColor = UIColor.whiteColor()
        
        let logo = UIImage(named: "menubar_logo.png")
        let imageView = UIImageView(image: logo)
        navigationItem.titleView = imageView
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return facilities.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "FacilityTableCell")
        
        cell.backgroundColor = UIColor.clearColor()
        
        cell.textLabel?.text = facilities[indexPath.row]
        cell.imageView!.image = UIImage(
            //there's korean encoding problem, temporary solution using index
            named: "icon_facility_" + String(indexPath.row) + ".png"
        )
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
