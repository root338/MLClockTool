//
//  MLClockDetailView.swift
//  MLClockTool
//
//  Created by apple on 2018/9/21.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

private let cellTitleTextFont = UIFont.systemFont(ofSize: 15)
private let cellTitleTextColor = UIColor.black
private let cellDetailTextFont = UIFont.systemFont(ofSize: 15)
private let cellDetailTextColor = UIColor.black

class MLClockDetailView: UIView {

    let titleLabel = UILabel.init(font: UIFont.systemFont(ofSize: 16), textColor: UIColor.black, text: "时间计算器")
    let startTimeView = MLClockTitleViewCell.init(titleLabel: UILabel.init(font: cellTitleTextFont, textColor: cellTitleTextColor, text: "开始时间"), detailLabel: UILabel.init(font: cellDetailTextFont, textColor: cellDetailTextColor))
    let endTimeView = MLClockTitleViewCell.init(titleLabel: UILabel.init(font: cellTitleTextFont, textColor: cellTitleTextColor, text: "结束时间"), detailLabel: UILabel.init(font: cellDetailTextFont, textColor: cellDetailTextColor))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let views = [titleLabel, startTimeView, endTimeView]
        for view in views {
            self.addSubview(view)
        }
        setLayout(subviews: views)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MLClockDetailView {
    func setLayout(subviews: [UIView]) {
        for (index, view) in subviews.enumerated() {
            if index == 0 {
                
            }
        }
    }
}

class MLClockTitleViewCell : UIView {
    let titleLabel : UILabel
    let detailLabel : UILabel
    init(titleLabel: UILabel, detailLabel: UILabel) {
        self.titleLabel = titleLabel
        self.detailLabel = detailLabel
        super.init(frame: .zero)
        
        self.addSubview(titleLabel)
        self.addSubview(detailLabel)
        setSubviewsLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize.init(width: super.intrinsicContentSize.width, height: 50)
    }
    
    private func setSubviewsLayout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        titleLabel.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor).isActive = true
        
        detailLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        detailLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 15).isActive = true
        detailLabel.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor).isActive = true
        detailLabel.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor, constant: 8).isActive = true
        detailLabel.setContentCompressionResistancePriority(UILayoutPriority(990), for: .horizontal)
    }
}
