//
//  MLTitleTextFieldItem.swift
//  MLClockTool
//
//  Created by apple on 2018/10/15.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

@available(iOS 9.0, *)
class MLTitleTextFieldItem: NSObject {

    var title : String?
    var attributedTitle: NSAttributedString?
    
    var marginInsets = UIEdgeInsets.zero
    var space = CGFloat(0)
    
    let titleLabel: UILabel = {
        return UILabel.init()
    }()
    let textField: UITextField = {
        return UITextField.init()
    }()
    
    var translatesAutoresizingMaskIntoConstraints = true {
        didSet {
            titleLabel.translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints
            textField.translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints
        }
    }
    
    var itemLayoutGuide : UILayoutGuide = {
        return UILayoutGuide.init()
    }()
}

extension MLTitleTextFieldItem {
    
    func updateAllLayoutGuide() {
        updateMarginLayoutGuide()
        updateSubviewsLayoutGuide()
    }
    func updateMarginLayoutGuide() {
        itemLayoutGuide.topAnchor.constraint(greaterThanOrEqualTo: titleLabel.topAnchor, constant: marginInsets.top).isActive = true
        itemLayoutGuide.topAnchor.constraint(greaterThanOrEqualTo: textField.topAnchor, constant: marginInsets.top).isActive = true
        itemLayoutGuide.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: marginInsets.left).isActive = true
        itemLayoutGuide.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: marginInsets.right).isActive = true
        itemLayoutGuide.bottomAnchor.constraint(lessThanOrEqualTo: titleLabel.bottomAnchor, constant: marginInsets.bottom).isActive = true
        itemLayoutGuide.bottomAnchor.constraint(lessThanOrEqualTo: textField.bottomAnchor, constant: marginInsets.bottom).isActive = true
    }
    func updateSubviewsLayoutGuide() {
        textField.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor, constant: space).isActive = true
    }
    
    func setTitleLabelLayout(margin: UIEdgeInsets) {
        if titleLabel.translatesAutoresizingMaskIntoConstraints {
           titleLabel.translatesAutoresizingMaskIntoConstraints = false
        }
        titleLabel.topAnchor.constraint(equalTo: itemLayoutGuide.topAnchor, constant: margin.top).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: itemLayoutGuide.leadingAnchor, constant: margin.left).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: itemLayoutGuide.bottomAnchor, constant: margin.bottom)
        titleLabel.setContentHuggingPriority(.required, for: .horizontal)
    }
    func setTextFieldLayout(margin: UIEdgeInsets) {
        if textField.translatesAutoresizingMaskIntoConstraints {
            textField.translatesAutoresizingMaskIntoConstraints = false
        }
        titleLabel.topAnchor.constraint(equalTo: itemLayoutGuide.topAnchor, constant: margin.top).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: itemLayoutGuide.leadingAnchor, constant: margin.left).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: itemLayoutGuide.bottomAnchor, constant: margin.bottom)
        titleLabel.setContentHuggingPriority(.required, for: .horizontal)
    }
}
