//
//  MLSelectorAlertProtocol.swift
//  MLClockTool
//
//  Created by apple on 2018/10/16.
//  Copyright © 2018 apple. All rights reserved.
//

import Foundation

enum MLSelectorAlertStatus {
    case show
    case hide
}

protocol MLSelectorAlertProtocol : NSObjectProtocol {
    var currentStatus : MLSelectorAlertStatus {get}
    var isHideRemoveFromSuperview : Bool {get set}
    func ml_show()
    func ml_hide()
}
