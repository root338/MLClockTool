//
//  UIResponder+MLAdd.swift
//  MLClockTool
//
//  Created by apple on 2018/10/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

extension UIResponder {
    @objc func ml_responseChain(identifierKey: String, parameters: [String : Any]?) {
        self.next?.ml_responseChain(identifierKey: identifierKey, parameters: parameters)
    }
}
