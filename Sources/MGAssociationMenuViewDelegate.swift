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
    
    
    /// 点击最后一列的回调
    ///
    /// - Parameter selectData: 选中的每列tableView中对应的数据组合成的数组
    /// - Returns: nil
    func completionWithSelectData(_ selectData : [Any] )
}
