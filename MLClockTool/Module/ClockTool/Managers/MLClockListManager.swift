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

private let MLClockListCountKey = "count"

class MLClockListManager: NSObject {
    
    var clockList = [MLClockDateProtocol]()
    weak var targetTableView : UITableView?
    
    private var needSaveClockDataToLocal = false
    private var clockReloadTimer : Timer?
    
    deinit {
        stopTimer()
        NotificationCenter.default.removeObserver(self)
    }
    
    override init() {
        super.init()
        openNotification()
    }
}

//MARK:- Public Method
extension MLClockListManager {
    func reloadData() {
        
        MLClockDataHelper.getClockDataList {[weak self] (clockList) in
            self?.clockList = clockList ?? []
            self?.targetTableView?.reloadData()
            self?.autoEnableTimer()
        }
    }
    
    func insert(ClockDate: MLClockDateProtocol) {
        clockList.append(ClockDate)
        targetTableView?.insertRows(at: [IndexPath.init(row: clockList.count - 1, section: 0)], with: .bottom)
        needSaveClockDataToLocal = true
        autoEnableTimer()
    }
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let indexPaths = [indexPath]
        removeObj(at: indexPaths)
        deleteRows(at: indexPaths, with: .automatic)
    }
}

// MARK: - UITableViewDelegate
extension MLClockListManager : UITableViewDelegate {
    
}

//MARK:- Notification
private extension MLClockListManager {
    
    func openNotification() {
        
        func addNotification(name: Notification.Name, selector: Selector) {
            NotificationCenter.default.addObserver(self, selector: selector, name: name, object: nil)
        }
        
        addNotification(name: MLClockWillTerminateNotification, selector: #selector(handleKillApplication(note:)))
        addNotification(name: UIApplication.didEnterBackgroundNotification, selector: #selector(handleDidEnterBackground(note:)))
        addNotification(name: UIApplication.willEnterForegroundNotification, selector: #selector(handleWillEnterForeground(note:)))
    }
    
    @objc func handleKillApplication(note: Notification) {
        saveClockListToLocal()
    }
    
    @objc func handleDidEnterBackground(note: Notification) {
        pauseTimer()
    }
    
    @objc func handleWillEnterForeground(note: Notification) {
        if verifyNeedOpenTimer() {
            enableTimer()
            handleTimerChange(timer: clockReloadTimer!)
        }else {
            stopTimer()
        }
    }
}

//MARK:- Private Method
private extension MLClockListManager {
    
    //MARK:- 数据操作
    
    func verifyIndexPathsAvailable(indexPaths: [IndexPath]) ->Bool {
        let totalCount = clockList.count
        for indexPath in indexPaths {
            let row = indexPath.row
            if row < 0 || row >= totalCount {
                return false
            }
        }
        return true
    }
    
    func removeObj(at indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            clockList.remove(at: indexPath.row)
        }
        needSaveClockDataToLocal = true
    }
    func deleteRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation) {
        targetTableView?.deleteRows(at: indexPaths, with: animation)
        autoEnableTimer()
    }
    
    func saveClockListToLocal() {
        if !needSaveClockDataToLocal {
            return
        }
        _ = MLClockDataHelper.syncSave(clockList: clockList)
        needSaveClockDataToLocal = false
    }
    
    //MARK:- 计数器管理
    
    func autoEnableTimer() {
        if verifyNeedOpenTimer() {
            enableTimer()
        }else {
            stopTimer()
        }
    }
    
    func verifyNeedOpenTimer() ->Bool {
        var isRealTimeRefresh = false
        for obj in clockList {
            isRealTimeRefresh = obj.isRealTimeRefresh
            if isRealTimeRefresh {
                break
            }
        }
        return isRealTimeRefresh
    }
    
    func enableTimer() {
        if clockReloadTimer == nil {
            clockReloadTimer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(handleTimerChange(timer:)), userInfo: nil, repeats: true)
        }else {
            clockReloadTimer?.fireDate = NSDate.init() as Date
        }
    }
    
    func pauseTimer() {
        clockReloadTimer?.fireDate = NSDate.distantFuture
    }
    
    func stopTimer() {
        if let clockReloadTimer = self.clockReloadTimer, clockReloadTimer.isValid {
            clockReloadTimer.invalidate()
        }
        clockReloadTimer = nil
    }
    
    @objc func handleTimerChange(timer: Timer) {
        guard let visibleIndexPaths = targetTableView?.indexPathsForVisibleRows, visibleIndexPaths.count > 0 else {
            return
        }
        
        var needReloadIndexPaths = [IndexPath]()
        for indexPath in visibleIndexPaths {
            let clockObj = clockList[indexPath.row]
            if clockObj.isRealTimeRefresh {
                needReloadIndexPaths.append(indexPath)
            }
        }
        if needReloadIndexPaths.count > 0 {
            targetTableView?.reloadRows(at: needReloadIndexPaths, with: .automatic)
        }
    }
}
