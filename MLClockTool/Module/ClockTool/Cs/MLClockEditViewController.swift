//
//  MLClockEditViewController.swift
//  MLClockTool
//
//  Created by apple on 2018/10/12.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

class MLClockEditViewController: UIViewController {
    
    var clockStatus : MLClockStatus!
    var clockDate : MLClockDateProtocol?
    var currentEditClockType = MLClockEditType.offsetDay

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    //MARK:- Action
    @IBAction func handleCancelClock(_ sender: Any) {
        dismissEdit()
    }
    
    @IBAction func handleSaveClock(_ sender: Any) {
        if let parameters = getDidEditClockDate() {
            self.ml_responseChain(identifierKey: MLSaveClockDateKey, parameters: parameters)
        }
        dismissEdit()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if var clockEditProtocol = segue.destination as? MLClockDetailEditItemProtocol {
            if let date = clockDate {
                if clockEditProtocol.editType == date.clockEditType {
                    clockEditProtocol.clockDate = date
                }
            }
            clockEditProtocol.delegate = self
            clockEditProtocol.clockStatus = clockStatus
        }
    }
}

extension MLClockEditViewController {
    
    private func dismissEdit() {
        self.ml_responseChain(identifierKey: MLDismissEditKey, parameters: nil)
    }
}

private extension MLClockEditViewController {
    func getDidEditClockDate() -> [String : Any]? {
        
        guard let editClockProtocol = self.currentClockProtocol else {
            return nil
        }
        guard let clockDate = editClockProtocol.clockDate else {
            return nil
        }
        
        return [
            MLSaveClockDateKey : clockDate
        ]
    }
    
    var currentClockProtocol : MLClockDetailEditItemProtocol? {
        for children in self.children {
            if let editClockProtocol = children as? MLClockDetailEditItemProtocol {
                if editClockProtocol.editType == currentEditClockType {
                    return editClockProtocol
                }
            }
        }
        return nil
    }
    
}

extension MLClockEditViewController : MLClockEditDetailDelegate {
//    func save(clockDate: MLClockDateProtocol) {
//
//    }
    
    func remove(clockDate: MLClockDateProtocol) {
        
    }
    
    
}
