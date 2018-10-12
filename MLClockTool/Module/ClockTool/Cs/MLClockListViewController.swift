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
        
        listManager.reloadData()
    }
}
