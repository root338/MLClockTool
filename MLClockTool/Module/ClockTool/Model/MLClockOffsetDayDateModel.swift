//
//  MLClockOffsetDayDateModel.swift
//  MLClockTool
//
//  Created by apple on 2018/10/10.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

/// 相对指定时间的偏移量之间的存储
class MLClockOffsetDayDateModel: NSObject {

    var fromDate : Date?
    var offsetDay : Int
    /// 小时 [0, 23]
    let hour : Int
    /// 分钟 [0, 59]
    let minute : Int
    /// 秒 [0, 59]
    let second : Int = 0
    
    /// 是否是可用的时间区间
    var isAvailableDateRange : Bool {
        return toDate != nil
    }
    
    var toDate : Date? {
        return MLClockDateManager.shareManager.date(dateComponent: toDateComponent)
    }
    
    private var toDateComponent : DateComponents {
        let fromDate = self.fromDate ?? Date.init()
        var dateComponent = MLClockDateManager.shareManager.dateComponent(date: fromDate)
        dateComponent.day = dateComponent.day ?? 0 + offsetDay
        dateComponent.hour = hour
        dateComponent.minute = minute
        dateComponent.second = second
        return dateComponent
    }
    
    init(offsetDay: Int, hour: Int, minute: Int) {
        self.offsetDay = offsetDay
        self.hour = hour
        self.minute = minute
        super.init()
    }
}
