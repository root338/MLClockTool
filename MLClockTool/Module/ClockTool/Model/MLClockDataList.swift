//
//  MLClockDataList.swift
//  MLClockTool
//
//  Created by apple on 2018/9/20.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

private let MLClockListDataKey = "MLClockEndDataKey"

class MLClockDataHelper {
    class func getClockDataList(completion: @escaping ([MLClockDateProtocol]?) -> Void) {
        let queue = DispatchQueue.global(qos: .default)
        queue.async {
            let clockListData = UserDefaults.standard.array(forKey: MLClockListDataKey) as? [MLClockDateProtocol]
            DispatchQueue.main.async {
                completion(clockListData)
            }
        }
    }
    
    class func save(clockList: [MLClockDateProtocol]) {
        DispatchQueue.global().async {
            UserDefaults.standard.set(clockList, forKey: MLClockListDataKey)
        }
    }
}
