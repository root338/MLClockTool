//
//  MLDatePickerHelper.swift
//  MLClockTool
//
//  Created by apple on 2018/10/16.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

class MLDatePickerHelper : NSObject {
    
    weak var toolView : UIView?
    weak var datePicker : UIView?
    weak var targetSuperview : UIView?
    
    var hideViewIsRemoveFromSuperview = true
    
    private(set) var currentStatus = MLSelectorAlertStatus.hide
}

extension MLDatePickerHelper {
    
    func showDatePickerView() {
        if currentStatus == .show {
            return
        }
        setViewFrame(toStatus: .hide)
        currentStatus = .show
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 7, options: .curveEaseIn, animations: {
            self.setViewFrame(toStatus: self.currentStatus)
            self.targetSuperview?.backgroundColor = UIColor.init(white: 0, alpha: 0.7)
            self.currentStatus = .show
        }, completion: nil)
    }
    
    func hideDatePickerView() {
        if currentStatus == .hide {
            return
        }
        currentStatus = .hide
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.setViewFrame(toStatus: self.currentStatus)
            self.targetSuperview?.backgroundColor = UIColor.init(white: 0, alpha: 0)
        }, completion: {(finished) in
            if self.hideViewIsRemoveFromSuperview {
                self.targetSuperview?.removeFromSuperview()
            }
        })
    }
    
    func setViewFrame(toStatus: MLSelectorAlertStatus) {
        if targetSuperview == nil {
            return
        }
        let toolViewFrame : CGRect
        let datePickerFrame : CGRect
        let selfFrame = targetSuperview!.frame
        
        switch toStatus {
        case .show:
            datePickerFrame = .init(x: 0, y: selfFrame.height - datePickerHeight, width: selfFrame.width, height: datePickerHeight)
            toolViewFrame = .init(x: 0, y: selfFrame.height - datePickerFrame.height - toolViewHeight, width: selfFrame.width, height: toolViewHeight)
        case .hide:
            toolViewFrame = .init(x: 0, y: selfFrame.maxY, width: selfFrame.width, height: toolViewHeight)
            datePickerFrame = .init(x: 0, y: toolViewFrame.maxY, width: selfFrame.width, height: datePickerHeight)
        }
        if let toolView = self.toolView, !toolView.frame.equalTo(toolViewFrame) {
            toolView.frame = toolViewFrame
        }
        if let datePicker = self.datePicker, !datePicker.frame.equalTo(datePickerFrame) {
            datePicker.frame = datePickerFrame
        }
    }
    
    private var datePickerHeight : CGFloat {
        return 216
    }
    private var toolViewHeight : CGFloat {
        return 44
    }
}
