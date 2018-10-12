//
//  MLClockListTableViewCell.swift
//  MLClockTool
//
//  Created by apple on 2018/9/27.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

class MLClockListTableViewCell: UITableViewCell {

    @IBOutlet weak var offsetTimeLabel: UILabel!
    @IBOutlet weak var dateRangeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
