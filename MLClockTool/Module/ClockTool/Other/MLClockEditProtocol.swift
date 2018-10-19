//
//  MLClockDetailEditItemProtocol.swift
//  MLClockTool
//
//  Created by apple on 2018/10/17.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

enum MLClockStatus {
    case add
    case edit
}

//MARK:- 数据协议
/// 编辑所需要的数据协议
protocol MLClockEditDateProtocol {
    var clockDate : MLClockDateProtocol? {get set}
    var clockStatus : MLClockStatus! {get set}
}

//MARK:- 编辑管理器协议
/// 管理编辑视图的容器所要实现的协议
protocol MLClockEditContainerManagerProtocol: MLClockEditResultProtocol, MLClockEditDateProtocol {
}

//MARK:- 编辑详情页协议
/// 编辑详细页的代理协议
protocol MLClockEditDetailDelegate : NSObjectProtocol {
    
//    func save(clockDate: MLClockDateProtocol)
    func remove(clockDate: MLClockDateProtocol)
}

/// 具体的日期编辑页，需要实现的协议
protocol MLClockDetailEditItemProtocol : MLClockEditDateProtocol {
    var delegate : MLClockEditDetailDelegate? {get set}
    var editType : MLClockEditType {get}
}

//MARK:- 结果处理协议

/// 进行处理编辑结果的协议
protocol MLClockEditResultProtocol {
    var resultDelegate : MLClockEditResultDelegate? {get set}
}

/// 编辑完成后的结果回调代理协议
protocol MLClockEditResultDelegate : NSObjectProtocol {
    func saveEdit(parameters: [String : Any]?)
    func cancelEdit(clockDate: MLClockDateProtocol)
}
