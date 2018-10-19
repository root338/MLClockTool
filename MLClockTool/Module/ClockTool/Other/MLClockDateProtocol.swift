//
//  MLClockDateProtocol.swift
//  MLClockTool
//
//  Created by apple on 2018/10/10.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

enum MLClockEditType {
    case `default`
    case offsetDay
}

protocol MLClockDateProtocol: NSObjectProtocol, NSCoding {
    
    var clockEditType : MLClockEditType {get}
    var fromDate : Date? {get}
    var toDate : Date? {get}
    
    /// 时间之间的差值
    var offsetTime : String {get}
    /// 时间之间的范围
    var timeRangeText : String {get}
    
    var fromDateText : String {get}
    var toDateText : String? {get}
}

extension MLClockDateProtocol {
    
    var offsetTime : String {
        guard let toDate = self.toDate else {
            return ""
        }
        return MLClockDateManager.shareManager.range(fromDate: fromDate ?? Date.init(), toDate: toDate)
    }
    
    var timeRangeText : String {
        guard let toDate = self.toDate else {
            return ""
        }
        let fromDateText = fromDate == nil ? MLClockCurrentTimeText : MLClockDateManager.shareManager.format(date: fromDate!)
        let tomDateText = MLClockDateManager.shareManager.format(date: toDate)
        return "\(fromDateText) -> \(tomDateText)"
    }
    
    var fromDateText : String {
        guard let fromDate = self.fromDate else {
            return MLClockCurrentTimeText
        }
        return MLClockDateManager.shareManager.format(date: fromDate)
    }
    
    var toDateText : String? {
        guard let toDate = self.toDate else {
            return nil
        }
        return MLClockDateManager.shareManager.format(date: toDate)
    }
}
