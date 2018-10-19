//
//  MLClockListManager.swift
//  MLClockTool
//
//  Created by apple on 2018/9/27.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

enum MLClockListDataStatus {
    case loading
    case isEmpty
}

// MARK: - 对外接口
extension MLClockListManager {
    func reloadData() {
        
        MLClockDataHelper.getClockDataList {[weak self] (clockList) in
            self?.clockList = clockList ?? []
            self?.targetTableView?.reloadData()
        }
    }
    
    func insert(ClockDate: MLClockDateProtocol) {
        clockList.append(ClockDate)
        targetTableView?.insertRows(at: [IndexPath.init(row: clockList.count - 1, section: 0)], with: .bottom)
        MLClockDataHelper.save(clockList: clockList)
    }
}

class MLClockListManager: NSObject {

    var clockList = [MLClockDateProtocol]()
    weak var targetTableView : UITableView?
}

// MARK: - UITableViewDataSource
extension MLClockListManager : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clockList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MLClockListTableViewCell", for: indexPath) as! MLClockListTableViewCell
        let clockObj = clockList[indexPath.row]
        cell.offsetTimeLabel.text = clockObj.offsetTime
        cell.dateRangeLabel.text = clockObj.timeRangeText
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}

// MARK: - UITableViewDelegate
extension MLClockListManager : UITableViewDelegate {
    
}

extension MLClockListManager {
    
}
