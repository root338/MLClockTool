//
//  MLClockDateModel.swift
//  MLClockTool
//
//  Created by apple on 2018/10/10.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

/// 具体时间之间的存储
class MLClockDateModel: NSObject {
    
    var toDate : Date
    /// 当为nil时，用当前时间来处理
    var fromDate : Date?
    init(toDate: Date) {
        self.toDate = toDate
        super.init()
    }
}
