//
//  MLClockEditView.swift
//  MLClockTool
//
//  Created by apple on 2018/10/12.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

protocol MLClockEditViewDelegate : NSObjectProtocol {
    func editView(_ editView: MLClockEditView, viewAtType: MLClockEditType) -> UIView
}

struct MLClockEditViewItem : Equatable {
    /// 是否是活动的编辑视图
    var isActive = false
    let type : MLClockEditType
    let editView : UIView
    
}

class MLClockEditView: UIView {

    weak var delegate : MLClockEditViewDelegate?
    
    /// 到哪个编辑视图类型
    private var toEditViewType : MLClockEditType?
    private var currentActiveEditViewItem : MLClockEditViewItem? {
        didSet {
            if currentActiveEditViewItem != nil && oldValue == nil {
                add(activeEditItem: currentActiveEditViewItem!)
            }else if currentActiveEditViewItem == nil && oldValue != nil {
                remove(activeEditItem: oldValue!)
            }else {
                replace(fromActiveEditItem: oldValue!, toActivieEditItem: currentActiveEditViewItem!)
            }
        }
    }
    /// 存储的编辑视图
    private var editViews = [MLClockEditType : MLClockEditViewItem]()
    
    func reloadData(toEditViewType: MLClockEditType?, completion: ((Bool) -> Void)? = nil) {
        let currentActiveEditViewItemIsNull = self.currentActiveEditViewItem == nil
        if currentActiveEditViewItemIsNull && toEditViewType == nil {
            return
        }
        if self.delegate == nil && currentActiveEditViewItemIsNull {
            return
        }
        
        self.toEditViewType = toEditViewType
        reloadData(completion: completion)
    }
}

private extension MLClockEditView {
    
    func remove(activeEditItem: MLClockEditViewItem) {
        
    }
    
    func add(activeEditItem: MLClockEditViewItem) {
        let activeEditView = activeEditItem.editView
        if activeEditView.superview == nil {
            self.addSubview(activeEditView)
            activeEditView.translatesAutoresizingMaskIntoConstraints = false
            activeEditView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            activeEditView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            activeEditView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            activeEditView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        }
        if activeEditView.isHidden == true {
            activeEditView.isHidden = false
        }
    }
    
    func replace(fromActiveEditItem: MLClockEditViewItem, toActivieEditItem: MLClockEditViewItem) {
        
    }
    
    func reloadData(completion: ((Bool) -> Void)? = nil) {
        
        var toItem : MLClockEditViewItem? = nil
        if let toEditViewType = self.toEditViewType, let delegate = self.delegate {
            let toEditView = delegate.editView(self, viewAtType: toEditViewType)
            toItem = MLClockEditViewItem.init(isActive: false, type: toEditViewType, editView: toEditView)
        }
        self.currentActiveEditViewItem = toItem
    }
    
    
}
