//
//  MLClockNullView.swift
//  MLClockTool
//
//  Created by apple on 2018/9/27.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

class MLClockNullView: UIView {

    let titleLabel : UILabel = {
        let label = UILabel.init()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(titleLabel)
        
        titleLabel.textAlignment = .center
        
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor)
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
