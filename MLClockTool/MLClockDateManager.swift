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
        return "\(dateComponents.year!)-\(dateComponents.month!)-\(dateComponents.day!) \(dateComponents.hour!):\(dateComponents.minute!)"
    }
}

// MARK: - 时间比较
extension MLClockDateManager {
    func range(fromDate: Date, toDate: Date) -> String {
        let dateComponent = calendar.dateComponents([.hour, .minute], from: fromDate, to: toDate)
        return "\(dateComponent.hour!):\(dateComponent.minute!)"
    }
}
