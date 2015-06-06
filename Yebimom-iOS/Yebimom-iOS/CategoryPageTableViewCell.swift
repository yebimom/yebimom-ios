//
//  CategoryPageTableViewCell.swift
//  Yebimom-iOS
//
//  Created by wikibootup on 6/6/15.
//  Copyright (c) 2015 wikibootup. All rights reserved.
//

import UIKit

class CategoryPageTableViewCell: UITableViewCell {

    @IBOutlet weak var centerNameLabel: UILabel!
    @IBOutlet weak var centerAddressLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
