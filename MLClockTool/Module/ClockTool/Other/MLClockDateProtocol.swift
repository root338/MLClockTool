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
    var isRealTimeRefresh: Bool {get}
    
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
        
        let fromDateText = fromDate != nil ? format(date: fromDate!) : MLClockCurrentTimeText
        let toDateText = format(date: toDate)
        
        return "\(fromDateText) -> \(toDateText)"
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
    
    private func format(date: Date) -> String {
        let clockDateManager = MLClockDateManager.shareManager
        
        guard clockDateManager.isEqual(date1: date, date2: Date.init()) == false else {
            return MLClockCurrentTimeText
        }
        
        let calendar = MLClockDateManager.shareManager.calendar
        
        func hourText() -> String {
            
            let dateComponents = MLClockDateManager.shareManager.dateComponent(date: date)
            
            return "\(String(format: "%02i", dateComponents.hour!)):\(String(format: "%02i", dateComponents.minute!))"
        }
        
        guard calendar.isDateInToday(date) == false else {
            return "\(MLClockTodayText) \(hourText())"
        }
        
        guard calendar.isDateInTomorrow(date) == false else {
            return "\(MLClockTomorrowText) \(hourText())"
        }
        
        return clockDateManager.format(date: date)
    }
}
