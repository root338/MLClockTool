//
//  MLClockEditNavigationViewController.swift
//  MLClockTool
//
//  Created by apple on 2018/10/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

class MLClockEditNavigationViewController: UINavigationController, MLClockEditContainerManagerProtocol {

    var clockStatus : MLClockStatus!
    var clockDate : MLClockDateProtocol?
    //MARK:- MLClockEditResultProtocol
    weak var resultDelegate : MLClockEditResultDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK:- response Chain
    @objc override func ml_responseChain(identifierKey: String, parameters: [String : Any]?) {
        if identifierKey == MLDismissEditKey {
            self.dismiss(animated: true, completion: nil)
        }else if identifierKey == MLSaveClockDateKey {
            resultDelegate?.saveEdit(parameters: parameters)
        }
        else {
            self.next?.ml_responseChain(identifierKey: identifierKey, parameters: parameters)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if var editObj = segue.destination as? MLClockDetailEditItemProtocol {
            editObj.clockStatus = clockStatus
            editObj.clockDate = clockDate
        }
    }
    

}
