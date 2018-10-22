//
//  MLClockDataHelper.swift
//  MLClockTool
//
//  Created by apple on 2018/9/20.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

class MLClockDataHelper {
    
    enum ClockDataResultType {
        case success
        case faild
    }
    
    class func getClockDataList(completion: @escaping ([MLClockDateProtocol]?) -> Void) {
        let queue = DispatchQueue.global(qos: .default)
        queue.async {
            let clockListData = NSKeyedUnarchiver.unarchiveObject(withFile: MLClockDataHelper.clockFilePath()) as? [MLClockDateProtocol]
            DispatchQueue.main.async {
                completion(clockListData)
            }
        }
    }
    
    class func save(clockList: [MLClockDateProtocol], completion: ((ClockDataResultType) -> Void)? = nil) {
        DispatchQueue.global().async {
            
            let resultValue = syncSave(clockList: clockList)
            completion?(resultValue ? ClockDataResultType.success : ClockDataResultType.faild)
        }
    }
    
    class func syncSave(clockList: [MLClockDateProtocol]) ->Bool {
        
        let resultValue = NSKeyedArchiver.archiveRootObject(clockList, toFile: MLClockDataHelper.clockFilePath())
        return resultValue
    }
    
    private class func clockFilePath() ->String {
        let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).last!
        let clockFileName = "clockDate.ml";
        let clockFolderPath = (path as NSString).appendingPathComponent("MeSaveDate")
        if !FileManager.default.fileExists(atPath: clockFolderPath) {
            
            do {
                try FileManager.default.createDirectory(atPath: clockFolderPath, withIntermediateDirectories: true, attributes: nil)
            }catch {
            }
        }
        return (clockFolderPath as NSString).appendingPathComponent(clockFileName)
    }
}
