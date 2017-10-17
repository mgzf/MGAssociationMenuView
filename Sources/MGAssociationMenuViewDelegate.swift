//
//
//                        _____
//                       / ___/____  ____  ____ _
//                       \__ \/ __ \/ __ \/ __ `/
//                      ___/ / /_/ / / / / /_/ /
//                     /____/\____/_/ /_/\__, /
//                                      /____/
//
//                .-~~~~~~~~~-._       _.-~~~~~~~~~-.
//            __.'              ~.   .~              `.__
//          .'//                  \./                  \\`.
//        .'//                     |                     \\`.
//      .'// .-~"""""""~~~~-._     |     _,-~~~~"""""""~-. \\`.
//    .'//.-"                 `-.  |  .-'                 "-.\\`.
//  .'//______.============-..   \ | /   ..-============.______\\`.
//.'______________________________\|/______________________________`.
//
//
//  MGAssociationEnum.swift
//  MGAssociationMenuView
//
//  Created by song on 2017/8/1.
//  Copyright © 2017年 song. All rights reserved.
//

import UIKit

//MARK: - 多级联动代理实现


public protocol  MGAssociationMenuViewDelegate : class {
    
    
    /// 注册Cell
    ///
    /// - Parameters:
    ///   - tableView:
    ///   - column: 对应列的tableView
    /// - Returns: nil
    func registerCell(_ tableView: UITableView, tableForColumnAt  column: Int)
    
    
    /// 配置每列的cell
    ///
    /// - Parameters:
    ///   - tableView: 对应列的tableView
    ///   - column: 对应的列数
    ///   - indexPath: cell的Indexpath
    ///   - data: cell 对应的数据
    /// - Returns: cell
    func configureCell(_ tableView: UITableView, tableForColumnAt  column: Int, cellForRowAt indexPath: IndexPath , cellForTableAt data: Any) -> UITableViewCell?
    
    
    /// 设置第一列的TableView的数据
    ///
    /// - Returns: 数组
    func configureFirstTableData() -> [Any]
    
    /// 点击cell 配置下列数据
    ///
    /// - Parameters:
    ///   - tableView: 对应列的tableView
    ///   - column: 对应的列数
    ///   - indexPath: cell的Indexpath
    ///   - data: cell 对应的数据
    /// - Returns: 数组即下列tableview显示的数据
    func selectToNextTableData(_ tableView: UITableView, tableForColumnAt  column: Int, cellForRowAt indexPath: IndexPath , cellForTableAt data: Any?) -> [Any]?
    
    /// 显示下列TableView 可以自己设置选中的Cell
    ///
    /// - Parameters:
    ///   - tableView:
    ///   - column: 第几列
    ///   - data: tableView对应的数据
    func didShowNextTableView(_ tableView: UITableView, tableForColumnAt  column: Int, tableAt data: [Any]?)
    
    
    /// 点击最后一列单选的回调
    ///
    /// - Parameter selectData: 选中的每列tableView中对应的数据组合成的数组
    /// - Returns: nil
    func completionWithSelectData(_ selectData : [Any] )
    
    /// 点击最后一列多选数据
    ///
    /// - Parameter selectData: 最后一列中选中的对应的数据组合成的数组
    func completionFinalColumnWithSelectData(_ selectData : [Any], unSelectData : Any?)
}

public extension MGAssociationMenuViewDelegate {
    
    public func didShowNextTableView(_ tableView: UITableView, tableForColumnAt  column: Int, tableAt data: [Any]?) {
        
    }
    
    public func completionWithSelectData(_ selectData : [Any] ) {
        
    }
    
    func completionFinalColumnWithSelectData(_ selectData : [Any], unSelectData : Any?) {
        
    }
}
