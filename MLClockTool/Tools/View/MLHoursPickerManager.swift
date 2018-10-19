//
//  MLHoursPickerManager.swift
//  MLClockTool
//
//  Created by apple on 2018/10/15.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

typealias MLHourPickerType = (hour: Int, minute: Int)

class MLHoursPickerManager: NSObject {
    
    weak var pickerView : UIPickerView?
    var didSelectedHourValue : MLHourPickerType {
        let hourComponentValue = pickerView?.selectedRow(inComponent: 0) ?? 0
        let minuteComponentValue = pickerView?.selectedRow(inComponent: 1) ?? 0
        return (hourComponentValue % 24, minuteComponentValue % 60)
    }
    
    private let hourMaxValue = 24 * 1000
    private let minuteMaxValue = 60 * 1000
}

extension MLHoursPickerManager {
    func selectorMiddleValue(hourValue: MLHourPickerType) {
        pickerView?.selectRow(hourMaxValue / 2 + hourValue.hour, inComponent: 0, animated: false)
        pickerView?.selectRow(minuteMaxValue / 2 + hourValue.minute, inComponent: 1, animated: false)
    }
}

// MARK: - UIPickerViewDataSource
extension MLHoursPickerManager: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let rowCount = component == 0 ? hourMaxValue : minuteMaxValue
        return rowCount
    }
}

// MARK: - UIDocumentPickerDelegate
extension MLHoursPickerManager : UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let factor = component == 0 ? 24 : 60
        return String(format: "%02i", row % factor)
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 60
    }
}
