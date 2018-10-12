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
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(MLClockListTableViewCell.self), for: indexPath) as! MLClockListTableViewCell
        let clockObj = clockList[indexPath.row]
        cell.offsetTimeLabel.text = clockObj.offsetTime
        cell.dateRangeLabel.text = clockObj.timeRangeText
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MLClockListManager : UITableViewDelegate {
    
}
