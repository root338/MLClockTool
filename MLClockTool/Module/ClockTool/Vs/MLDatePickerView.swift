//
//  MLDatePickerView.swift
//  MLClockTool
//
//  Created by apple on 2018/10/16.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

protocol MLDatePickerViewDelegate: NSObjectProtocol {
    func datePickerView(_ datePickerView: MLDatePickerView, didSelectedDate: Date)
}

class MLDatePickerView: UIView {
    
    var delegate: MLDatePickerViewDelegate?
    
    let datePicker : UIDatePicker
    let toolView : MLDatePickerToolView
    let cancelButton : UIButton
    var hideViewIsRemoveFromSuperview : Bool {
        set {
            datePickerHelper.hideViewIsRemoveFromSuperview = newValue
        }
        get {
            return datePickerHelper.hideViewIsRemoveFromSuperview
        }
    }
    private let datePickerHelper = MLDatePickerHelper.init()
    
    init(dateMode: UIDatePicker.Mode) {
        
        datePicker = UIDatePicker.init()
        datePicker.datePickerMode = dateMode
        datePicker.backgroundColor = UIColor.white
        
        toolView = MLDatePickerToolView.init()
        
        cancelButton = UIButton.init(type: .system)
        
        super.init(frame: .zero)
        
        self.addSubview(cancelButton)
        self.addSubview(datePicker)
        self.addSubview(toolView)
        
        cancelButton.addTarget(self, action: #selector(handleCancelAction(sender:)), for: .touchUpInside)
        toolView.cancelButton.addTarget(self, action: #selector(handleCancelAction(sender:)), for: .touchUpInside)
        toolView.finishButton.addTarget(self, action: #selector(handleFinishAction(sender:)), for: .touchUpInside)
        
        datePickerHelper.toolView       = toolView
        datePickerHelper.datePicker     = datePicker
        datePickerHelper.targetSuperview = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cancelButton.frame = self.bounds
        datePickerHelper.setViewFrame(toStatus: datePickerHelper.currentStatus)
    }
}

extension MLDatePickerView {
    @objc func handleCancelAction(sender: Any) {
        hideDatePickerView()
    }
    @objc func handleFinishAction(sender: Any) {
        self.delegate?.datePickerView(self, didSelectedDate: datePicker.date)
        hideDatePickerView()
    }
}

extension MLDatePickerView {
    func showDatePickerView() {
        datePickerHelper.showDatePickerView()
    }
    
    func hideDatePickerView() {
        datePickerHelper.hideDatePickerView()
    }
}
