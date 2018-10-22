//
//  MLClockDefineConstants.swift
//  MLClockTool
//
//  Created by apple on 2018/10/10.
//  Copyright © 2018 apple. All rights reserved.
//

import Foundation

//MARK:- 常量字符串
let MLClockCurrentTimeText = "当前时间"
let MLClockTodayText = "今天"
let MLClockTomorrowText = "明天"

//MARK:- Segue 相关
/// 添加 clock 标识
let MLAddClockIdentifier = "MLAddClockIdentifier"

//MARK:- Response Chain
/// dismiss edit
let MLDismissEditKey = "MLDismissEditKey"

//MARK:- parameters key
let MLSaveClockDateKey = "MLSaveClockDateKey"

//MARK:- NotificationName
let MLClockWillTerminateNotification: Notification.Name = Notification.Name(rawValue: "MLWillTerminateNotification")


//MARK:- Error Message
let MLEditErrorOffsetDayIsNull = "偏移天数不能为空"
