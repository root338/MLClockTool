//
//  MLClockDataList.swift
//  MLClockTool
//
//  Created by apple on 2018/9/20.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

private let MLClockEndDataKey = "MLClockEndDataKey"

class MLClockData: NSObject {
    let title : String
    var data : Date?
    init(title: String) {
        self.title = title
        super.init()
    }
}

class MLClockDataList: NSObject {
    
}

extension MLClockDataList {
    class func getClockDataList() -> [MLClockData] {
        return [createStartClockData(), createEndClockData()]
    }
    
    class func save(endDate: Date) {
        UserDefaults.standard.setValue(endDate, forKey: MLClockEndDataKey)
    }
    
    private class func createStartClockData() -> MLClockData {
        let startClockData = MLClockData.init(title: "开始时间")
        startClockData.data = Date.init()
        return startClockData
    }
    private class func createEndClockData() -> MLClockData {
        
        let endClockData = MLClockData.init(title: "结束时间")
        if let endClockTime = UserDefaults.standard.object(forKey: MLClockEndDataKey) as? Date {
            endClockData.data = endClockTime
        }
        return endClockData
    }
    
    
}
