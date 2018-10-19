//
//  MLHourDatePickerView.swift
//  MLClockTool
//
//  Created by apple on 2018/10/16.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

protocol MLHourDatePickerViewDelegate {
    func hourDatePickerView(_ hourDatePickerView: MLHourDatePickerView, time: MLHourPickerType)
}

class MLHourDatePickerView: UIView {
    
    var delegate : MLHourDatePickerViewDelegate?
    
    let hourDatePicker : UIPickerView
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
    private let hourDatePickerManger = MLHoursPickerManager.init()

    override init(frame: CGRect) {
        
        hourDatePicker = UIPickerView.init()
        hourDatePicker.backgroundColor = UIColor.white
        
        toolView = MLDatePickerToolView.init()
        
        cancelButton = UIButton.init(type: .system)
        
        super.init(frame: .zero)
        
        self.addSubview(cancelButton)
        self.addSubview(hourDatePicker)
        self.addSubview(toolView)
        
        cancelButton.addTarget(self, action: #selector(handleCancelAction(sender:)), for: .touchUpInside)
        toolView.cancelButton.addTarget(self, action: #selector(handleCancelAction(sender:)), for: .touchUpInside)
        toolView.finishButton.addTarget(self, action: #selector(handleFinishAction(sender:)), for: .touchUpInside)
        
        hourDatePickerManger.pickerView = hourDatePicker
        
        datePickerHelper.toolView       = toolView
        datePickerHelper.datePicker     = hourDatePicker
        datePickerHelper.targetSuperview = self
        
        hourDatePicker.delegate = hourDatePickerManger
        hourDatePicker.dataSource = hourDatePickerManger
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cancelButton.frame = self.bounds
        datePickerHelper.setViewFrame(toStatus: datePickerHelper.currentStatus)
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        if newSuperview != nil {
            hourDatePickerManger.selectorMiddleValue(hourValue: (0,0))
        }
    }
}

extension MLHourDatePickerView {
    @objc func handleCancelAction(sender: Any) {
        hideDatePickerView()
    }
    @objc func handleFinishAction(sender: Any) {
        hideDatePickerView()
        delegate?.hourDatePickerView(self, time: hourDatePickerManger.didSelectedHourValue)
    }
}

extension MLHourDatePickerView {
    func showDatePickerView() {
        datePickerHelper.showDatePickerView()
    }
    
    func hideDatePickerView() {
        datePickerHelper.hideDatePickerView()
    }
}
