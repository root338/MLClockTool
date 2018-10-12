//
//  Label+MLCreate.swift
//  MLClockTool
//
//  Created by apple on 2018/9/21.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(font: UIFont, textColor: UIColor, text: String? = nil) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = textColor
    }

}
