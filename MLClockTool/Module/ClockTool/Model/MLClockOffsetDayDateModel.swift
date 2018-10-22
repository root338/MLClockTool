//
//  MLClockOffsetDayDateModel.swift
//  MLClockTool
//
//  Created by apple on 2018/10/10.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

/// 相对指定时间的偏移量之间的存储
class MLClockOffsetDayDateModel: NSObject, MLClockDateProtocol {
    
    //MARK:- NSCoding
    func encode(with aCoder: NSCoder) {
        if fromDate != nil {
            aCoder.encode(fromDate!, forKey: "fromDate")
        }
        aCoder.encode(offsetDay, forKey: "offsetDay")
        aCoder.encode(hour, forKey: "hour")
        aCoder.encode(minute, forKey: "minute")
        aCoder.encode(second, forKey: "second")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fromDate = aDecoder.decodeObject(forKey: "fromDate") as? Date
        offsetDay = aDecoder.decodeInteger(forKey: "offsetDay")
        hour = aDecoder.decodeInteger(forKey: "hour")
        minute = aDecoder.decodeInteger(forKey: "minute")
        second = aDecoder.decodeInteger(forKey: "second")
    }
    
    var clockEditType: MLClockEditType {
        return .offsetDay
    }
    
    var fromDate : Date?
    var offsetDay : Int = 0
    /// 小时 [0, 23]
    var hour : Int = 0
    /// 分钟 [0, 59]
    var minute : Int = 0
    /// 秒 [0, 59]
    var second : Int = 0
    
    var isRealTimeRefresh: Bool {
        return true
    }
    
    /// 是否是可用的时间区间
    var isAvailableDateRange : Bool {
        return toDate != nil
    }
    
    var toDate : Date? {
        return MLClockDateManager.shareManager.date(dateComponent: toDateComponent)
    }
    
    override init() {
        super.init()
    }
    
    private var toDateComponent : DateComponents {
        let fromDate = self.fromDate ?? Date.init()
        var dateComponent = MLClockDateManager.shareManager.dateComponent(date: fromDate)
        dateComponent.day = (dateComponent.day ?? 0) + offsetDay
        dateComponent.hour = hour
        dateComponent.minute = minute
        dateComponent.second = second
        return dateComponent
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let obj = object as? MLClockOffsetDayDateModel else {
            return false
        }
        let fromDateIsEqual = MLClockDateManager.shareManager.isEqual(date1: fromDate, date2: obj.fromDate)
        if !fromDateIsEqual {
            return false
        }
        if offsetDay == obj.offsetDay && hour == obj.hour && minute == obj.minute && second == obj.second {
            return true
        }
        return false
    }
}
