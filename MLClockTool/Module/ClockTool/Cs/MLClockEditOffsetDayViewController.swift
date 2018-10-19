//
//  MLClockEditOffsetDayViewController.swift
//  MLClockTool
//
//  Created by apple on 2018/10/16.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

class MLClockEditOffsetDayViewController: UIViewController, MLClockDetailEditItemProtocol {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var fromDateButton: UIButton!
    @IBOutlet weak var offsetDayTextField: UITextField!
    @IBOutlet weak var hourTimeButton: UIButton!
    
    //MARK:- MLClockDetailEditItemProtocol
    var clockDate: MLClockDateProtocol? {
        set {
            _clockOffsetDayDate = newValue as? MLClockOffsetDayDateModel
        }
        get {
            if let offsetDayDate = _clockOffsetDayDate {
                offsetDayDate.offsetDay = Int(offsetDayTextField.text ?? "0") ?? 0
            }
            return _clockOffsetDayDate
        }
    }
    
    weak var delegate: MLClockEditDetailDelegate?
    
    var editType: MLClockEditType {
        return .offsetDay
    }
    var clockStatus: MLClockStatus!
    
    private let datePickerView : MLDatePickerView =  {
        let datePicker = MLDatePickerView.init(dateMode: .dateAndTime)
        return datePicker
    }()
    private let hoursPickerView : MLHourDatePickerView = {
        let hourDatePicker = MLHourDatePickerView.init()
        return hourDatePicker
    }()
    private var _clockOffsetDayDate: MLClockOffsetDayDateModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if #available(iOS 11.0, *) {
            self.scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
    }
    
    //MARK:- Handle Action
    @IBAction func handleSelectedFromDate(_ sender: Any) {
        if offsetDayTextField.isFirstResponder {
            offsetDayTextField.resignFirstResponder()
        }
        
        let targetView : UIView! = self.navigationController?.view
        if datePickerView.superview != targetView {
            set(pickerView: datePickerView)
            if datePickerView.delegate == nil {
                datePickerView.delegate = self
            }
        }
        datePickerView.showDatePickerView()
    }
    
    @IBAction func handleSelectedHourDateAction(_ sender: Any) {
        if offsetDayTextField.isFirstResponder {
            offsetDayTextField.resignFirstResponder()
        }
        let targetView : UIView! = self.navigationController?.view
        if hoursPickerView.superview != targetView {
            set(pickerView: hoursPickerView)
            if hoursPickerView.delegate == nil {
                hoursPickerView.delegate = self
            }
        }
        hoursPickerView.showDatePickerView()
    }
}

extension MLClockEditOffsetDayViewController : MLDatePickerViewDelegate, MLHourDatePickerViewDelegate {
    //MARK:- MLDatePickerViewDelegate
    func datePickerView(_ datePickerView: MLDatePickerView, didSelectedDate: Date) {
        offsetDayModel.fromDate = didSelectedDate
        fromDateButton.setTitle(offsetDayModel.fromDateText, for: .normal)
    }
    //MARK:- MLHourDatePickerViewDelegate
    func hourDatePickerView(_ hourDatePickerView: MLHourDatePickerView, time: MLHourPickerType) {
        offsetDayModel.hour = time.hour
        offsetDayModel.minute = time.minute
        hourTimeButton.setTitle("\(String(format: "%02i", time.hour)):\(String(format: "%02i", time.minute))", for: .normal)
    }
}

private extension MLClockEditOffsetDayViewController {
    
    private var offsetDayModel : MLClockOffsetDayDateModel {
        if clockDate == nil {
            clockDate = MLClockOffsetDayDateModel.init()
        }
        return clockDate as! MLClockOffsetDayDateModel
    }
    
    private func set(pickerView: UIView) {
        guard let targetView = self.navigationController?.view else {
            return
        }
        
        targetView.addSubview(pickerView)
        pickerView.frame = targetView.frame
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.topAnchor.constraint(equalTo: targetView.topAnchor).isActive = true
        pickerView.leadingAnchor.constraint(equalTo: targetView.leadingAnchor).isActive = true
        pickerView.bottomAnchor.constraint(equalTo: targetView.bottomAnchor).isActive = true
        pickerView.trailingAnchor.constraint(equalTo: targetView.trailingAnchor).isActive = true
    }
}
