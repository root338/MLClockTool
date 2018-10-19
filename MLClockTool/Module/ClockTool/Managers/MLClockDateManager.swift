//
//  MLClockDateManager.swift
//  MLClockTool
//
//  Created by apple on 2018/9/20.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

class MLClockDateManager: NSObject {
    
    static let shareManager : MLClockDateManager = {
        return MLClockDateManager.init()
    }()
    
    let calendar : Calendar = {
        return Calendar.current
    }()
}

// MARK: - 常量
extension MLClockDateManager {
    var MLClockDateDefaultUnit : Set<Calendar.Component> {
        return [.year, .month, .day, .hour, .minute]
    }
}

// MARK: - 时间格式化
extension MLClockDateManager {
    
    func format(date: Date) -> String {
        let dateComponents = calendar.dateComponents(MLClockDateDefaultUnit, from: date)
        return "\(dateComponents.year!)-\(String(format: "%02i", dateComponents.month!))-\(String(format: "%02i", dateComponents.day!)) \(String(format: "%02i", dateComponents.hour!)):\(String(format: "%02i", dateComponents.minute!))"
    }
    
    func dateComponent(date: Date, units: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute]) -> DateComponents {
        return calendar.dateComponents(units, from: date)
    }
    
    func date(dateComponent: DateComponents) -> Date? {
        return calendar.date(from: dateComponent)
    }
}

// MARK: - 时间比较
extension MLClockDateManager {
    func range(fromDate: Date, toDate: Date) -> String {
        let dateComponent = calendar.dateComponents([.hour, .minute], from: fromDate, to: toDate)
        return "\(String(format: "%02i", dateComponent.hour!)):\(String(format: "%02i", dateComponent.minute!))"
    }
    
    func isEqual(date1: Date?, date2: Date?) ->Bool {
        if date1 == nil && date2 == nil {
            return true
        }else {
            guard let d1 = date1, let d2 = date2 else {
                return false
            }
            return d1.compare(d2) == .orderedSame
        }
    }
}
