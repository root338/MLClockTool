//
//  MLDatePickerToolView.swift
//  MLClockTool
//
//  Created by apple on 2018/10/16.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

class MLDatePickerToolView: UIView {

    let finishButton = UIButton.init(type: .system)
    let cancelButton = UIButton.init(type: .system)
    
    override init(frame: CGRect) {
        
        let contentEdgeInsets = UIEdgeInsets.init(top: 5, left: 8, bottom: 5, right: 8)
        finishButton.contentEdgeInsets = contentEdgeInsets
        cancelButton.contentEdgeInsets = contentEdgeInsets
        
        super.init(frame: frame)
        self.addSubview(finishButton)
        self.addSubview(cancelButton)
        
        setupContentViewsLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MLDatePickerToolView {
    convenience init() {
        self.init(frame: .zero)
        self.backgroundColor = UIColor.white
        self.finishButton.setTitle("确定", for: .normal)
        self.cancelButton.setTitle("取消", for: .normal)
    }
}

private extension MLDatePickerToolView {
    func setupContentViewsLayout() {
        finishButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        finishButton.leadingAnchor.constraint(greaterThanOrEqualTo: cancelButton.trailingAnchor).isActive = true
        finishButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        finishButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        finishButton.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor, constant: 0).isActive = true
        
        cancelButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        cancelButton.centerYAnchor.constraint(greaterThanOrEqualTo: finishButton.centerYAnchor, constant: 0).isActive = true
        cancelButton.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor, constant: 0).isActive = true
    }
}
