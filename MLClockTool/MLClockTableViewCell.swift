//
//  MLClockTableViewCell.swift
//  MLClockTool
//
//  Created by apple on 2018/9/20.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

class MLClockTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        let borderColor : CGColor?
        let borderWidth : CGFloat
        if selected {
            borderColor = UIColor.red.cgColor
            borderWidth = 2
        }else {
            borderColor = nil
            borderWidth = 0
        }
        
        self.contentView.layer.borderColor = borderColor
        self.contentView.layer.borderWidth = borderWidth
    }
}
