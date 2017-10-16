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
//  AssociationEnum.swift
//  MGAssociationMenuView
//
//  Created by song on 2017/7/31.
//  Copyright © 2017年 song. All rights reserved.
//

import UIKit

/*! 对tableView的操作 */

public extension UITableView {
    
    /*! 选中多个Cell */
    func selectRows(at indexPaths: [IndexPath]?, animated: Bool, scrollPosition: UITableViewScrollPosition = .none) {
        if let `indexPaths` = indexPaths {
            for indexPath in indexPaths {
                if let `delegate` = delegate {
                    if delegate.responds(to: #selector(UITableViewDelegate.tableView(_:willSelectRowAt:))){
                        let _ = delegate.tableView!(self, willSelectRowAt: indexPath)
                    }
                    if delegate.responds(to: #selector(UITableViewDelegate.tableView(_:didSelectRowAt:))){
                        delegate.tableView!(self, didSelectRowAt: indexPath)
                    }
                }
                selectRow(at: indexPath, animated: animated, scrollPosition: scrollPosition)
            }
        }
    }
    /*! 反选多个Cell */
    func deselectRows(at indexPaths: [IndexPath]?, animated: Bool) {
        if let `indexPaths` = indexPaths {
            for indexPath in indexPaths {
                deselectRow(at: indexPath, animated: animated)
            }
        }
    }
    
    /*! 取消所有选中 */
    func cancleSelectRows(animated: Bool) {
        if let indexPaths = indexPathsForSelectedRows {
            for indexPath in indexPaths {
                deselectRow(at: indexPath, animated: animated)
            }
        }
    }
}



//MARK: - 自定义TableView 将数据绑定到TableView上

class MGAssociationTableView: UITableView {
    
    /*! 列表数据 */
    var listData : [Any] = [] {
        didSet{
            self.reloadData()
        }
    }
}

//MARK: - 单列View

class MGAssociationSingleView: UIView {
    
    deinit {
        self.tableView.delegate = nil
        self.tableView.dataSource = nil
    }
    
    //MARK: - 属性UI
    
    lazy public var tableView: MGAssociationTableView = {
        let tableView = MGAssociationTableView(frame: CGRect.zero, style: .plain)
        tableView.backgroundColor = UIColor.clear
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 0.1))
        tableView.separatorColor = UIColor(red: 239.0/255, green: 239.0/255, blue: 239.0/255, alpha: 1)
        tableView.separatorStyle = .none
        tableView.separatorInset  = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return tableView
    }()
    
    lazy public var lineView: UIView = {
        let lineView = UIView(frame:CGRect.zero)
        lineView.backgroundColor = UIColor(red: 239.0/255, green: 239.0/255, blue: 239.0/255, alpha: 1)
        return lineView
    }()
    
    //MARK: - 生命周期
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configView()
    }
    
}

//MARK: - 扩展方法

extension MGAssociationSingleView{

    fileprivate func configView(){
        clipsToBounds = true
        
        addSubview(tableView)
        
        tableView.snp.makeConstraints({ (make) in
            make.edges.equalTo(self)
        })
        
        addSubview(lineView)
        lineView.snp.makeConstraints({ (make) in
            make.left.top.bottom.equalTo(tableView)
            make.width.equalTo(0.5)
        })
    }
}
