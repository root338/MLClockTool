//
//  View+MLAdd.swift
//  MLClockTool
//
//  Created by apple on 2018/9/21.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit


extension UIView {
    func mlAddSubviews(_ views: UIView...) {
        for view in views {
            self.addSubview(view)
        }
    }
}
