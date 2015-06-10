//
//  CenterOfCategoryViewController.swift
//  Yebimom-iOS
//
//  Created by wikibootup on 6/7/15.
//  Copyright (c) 2015 wikibootup. All rights reserved.
//

import UIKit
import SwiftyJSON

class CenterOfCategoryViewController: UIViewController {

    var centerHashID: String?
    
    @IBOutlet weak var centerNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let centerDetailOfCategoryURL = NSURL(string:"https://yebimom.com/api/centers/" + centerHashID!)
        var centerDetailOfCategoryJsonData = JSON(data: NSData(contentsOfURL: centerDetailOfCategoryURL!)!)
        
        centerNameLabel.text = centerDetailOfCategoryJsonData["name"].string
        
        
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
