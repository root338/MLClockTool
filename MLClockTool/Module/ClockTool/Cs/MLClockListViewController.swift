//
//  MLClockListViewController.swift
//  MLClockTool
//
//  Created by apple on 2018/9/27.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

class MLClockListViewController: UITableViewController {

    private let listManager = {
        return MLClockListManager.init()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = listManager
        tableView.dataSource = listManager
        listManager.targetTableView = tableView
        
        listManager.reloadData()
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.editButtonItem.target = self
        self.editButtonItem.action = #selector(handleEditTableView(_:))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if var editVC = segue.destination as? MLClockEditContainerManagerProtocol {
            
            var clockStatus : MLClockStatus?
            if let identifier = segue.identifier {
                if identifier == MLAddClockIdentifier {
                    clockStatus = .add
                }
            }
            editVC.resultDelegate = self
            editVC.clockStatus = clockStatus
        }
    }
    
    //MARK:- Action
    @objc func handleEditTableView(_ sender: UIBarButtonItem) {
        self.setEditing(!self.isEditing, animated: true)
    }
    
}

extension MLClockListViewController : MLClockEditResultDelegate {
    
    //MARK:- MLClockEditResultDelegate
    func saveEdit(parameters: [String : Any]?) {
        if let clockDate = parameters?[MLSaveClockDateKey] as? MLClockDateProtocol {
            listManager.insert(ClockDate: clockDate)
        }
    }
    
    func cancelEdit(clockDate: MLClockDateProtocol) {
        
    }
}
