//
//  MLClockViewController.swift
//  MLClockTool
//
//  Created by apple on 2018/9/20.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

class MLClockViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var resultLabel: UILabel!
    
    let clockTableProtocolManager = MLClockTableProtocolManager.init()
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clockTableProtocolManager.tableView = tableView
        clockTableProtocolManager.delegate = self
        clockTableProtocolManager.reset(MLClockDataList.getClockDataList())
        datePicker.minimumDate = Date.init()
        datePicker.addTarget(self, action: #selector(handleDateValueChangedAction(sender:)), for: .valueChanged)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleWillTerminateNote(_:)), name: UIApplication.willTerminateNotification, object: nil)
    }
}

// MARK: - Action
extension MLClockViewController {
    @objc func handleDateValueChangedAction(sender: UIDatePicker) {
        
        if let resultText = clockTableProtocolManager.calculateTime(datePickerValue: sender.date) {
            resultLabel.text = resultText
        }
    }
    
    @objc func handleWillTerminateNote(_ note: Notification) {
        guard let endDate = clockTableProtocolManager.getEndDate else {
            return
        }
        MLClockDataList.save(endDate: endDate)
    }
}

// MARK: - MLClockTableDelegate
extension MLClockViewController : MLClockTableDelegate {
    func manager(_ manager: MLClockTableProtocolManager, didSelectedWith date: Date?, indexPath: IndexPath) {
        if date != nil {
            datePicker.date = date!
        }else {
            handleDateValueChangedAction(sender: datePicker)
        }
    }
}
