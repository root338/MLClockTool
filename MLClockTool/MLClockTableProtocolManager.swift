//
//  MLClockTableProtocolManager.swift
//  MLClockTool
//
//  Created by apple on 2018/9/20.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

private let MLClockTableViewCellIdentifier = "MLClockTableViewCell"

protocol MLClockTableDelegate : NSObjectProtocol {
    func manager(_ manager: MLClockTableProtocolManager, didSelectedWith date: Date?, indexPath: IndexPath)
}

// MARK: - Public
extension MLClockTableProtocolManager {
    
    var getEndDate : Date? {
        return dataSource[1].data
    }
    
    func calculateTime(datePickerValue: Date) -> String? {
        guard let didSelectedRow = self.tableView?.indexPathForSelectedRow else {
            return nil
        }
        
        var startDate : Date? = nil
        var endDate : Date? = nil
        if didSelectedRow.row == 0 {
            startDate = datePickerValue
            endDate = dataSource[1].data
            dataSource[0].data = datePickerValue
        }else {
            startDate = dataSource[0].data
            endDate = datePickerValue
            dataSource[1].data = datePickerValue
        }
        
        if startDate == nil || endDate == nil {
            return nil
        }
        
        tableView?.reloadRows(at: [didSelectedRow], with: .none)
        tableView?.selectRow(at: didSelectedRow, animated: true, scrollPosition: .none)
        return MLClockDateManager.shareManager.range(fromDate: startDate!, toDate: endDate!)
    }
}

class MLClockTableProtocolManager: NSObject {
    
    weak var tableView : UITableView? {
        didSet {
            if oldValue != tableView {
                tableView?.delegate = self
                tableView?.dataSource = self
            }
        }
    }
    weak var delegate : MLClockTableDelegate?
    
    private var dataSource : [MLClockData] = {
        return []
    }()
    
    func reset(_ clockDataList: [MLClockData]) {
        dataSource = Array.init(clockDataList)
        tableView?.reloadData()
        handleTableDidReload()
    }
}

// MARK: - UITableViewDelegate
extension MLClockTableProtocolManager : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.manager(self, didSelectedWith: dataSource[indexPath.row].data, indexPath: indexPath)
    }
}

// MARK: - UITableViewDataSource
extension MLClockTableProtocolManager : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MLClockTableViewCellIdentifier) as! MLClockTableViewCell
        
        let clockData = dataSource[indexPath.row]
        cell.titleLabel.text = clockData.title
        
        var dateText : String? = nil
        if clockData.data != nil {
            dateText = MLClockDateManager.shareManager.format(date: clockData.data!)
        }
        cell.dateLabel.text = dateText
        
        return cell
    }
}

private extension MLClockTableProtocolManager {
    func handleTableDidReload() {
        var targetIndex : Int = 1
//        for (index, obj) in dataSource.enumerated() {
//            if obj.data == nil {
//                targetIndex = index
//            }
//        }
        
        if targetIndex >= 0 {
            tableView?.beginUpdates()
            tableView?.selectRow(at: IndexPath.init(row: targetIndex, section: 0), animated: true, scrollPosition: .none)
            tableView?.endUpdates()
        }
    }
}
