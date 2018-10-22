//
//  MLClockDateModel.swift
//  MLClockTool
//
//  Created by apple on 2018/10/10.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

/// 具体时间之间的存储
class MLClockDateModel: NSObject, MLClockDateProtocol {
    //MARK:- NSCoding
    func encode(with aCoder: NSCoder) {
        if toDate != nil {
            aCoder.encode(toDate!, forKey: "toDate")
        }
        if fromDate != nil {
            aCoder.encode(fromDate!, forKey: "fromDate")
        }
        aCoder.encode(isRealTimeRefresh, forKey: "isRealTimeRefresh")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.toDate = aDecoder.decodeObject(forKey: "toDate") as? Date
        self.fromDate = aDecoder.decodeObject(forKey: "fromDate") as? Date
        isRealTimeRefresh = aDecoder.decodeBool(forKey: "isRealTimeRefresh")
    }
    
    var clockEditType: MLClockEditType {
        return .default
    }
    
    var toDate : Date?
    /// 当为nil时，用当前时间来处理
    var fromDate : Date?
    var isRealTimeRefresh: Bool = false
    
    init(toDate: Date) {
        self.toDate = toDate
        super.init()
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let obj = object as? MLClockDateModel else {
            return false
        }
        
        
        let fromDateIsEqual = MLClockDateManager.shareManager.isEqual(date1: fromDate, date2: obj.fromDate)
        let toDateIsEqual = MLClockDateManager.shareManager.isEqual(date1: toDate, date2: obj.toDate)
        return fromDateIsEqual && toDateIsEqual
    }
    
}
