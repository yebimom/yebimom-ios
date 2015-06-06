//
//  EventTableViewCell.swift
//  Yebimom-iOS
//
//  Created by wikibootup on 6/5/15.
//  Copyright (c) 2015 wikibootup. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var numOfEventsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
