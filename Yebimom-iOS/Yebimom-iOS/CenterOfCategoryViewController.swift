//
//  CenterOfCategoryViewController.swift
//  Yebimom-iOS
//
//  Created by wikibootup on 6/7/15.
//  Copyright (c) 2015 wikibootup. All rights reserved.
//

import UIKit

class CenterOfCategoryViewController: UIViewController {

    var centerName: String?
    
    @IBOutlet weak var centerNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        centerNameLabel.text = centerName
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
