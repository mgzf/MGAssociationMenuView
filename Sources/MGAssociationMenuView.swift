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
//  MGAssociationMenuView.swift
//  MGAssociationMenuView
//
//  Created by song on 2017/7/31.
//  Copyright © 2017年 song. All rights reserved.
//

import UIKit
import SnapKit


//MARK: - 多级联动控件来啦

open class MGAssociationMenuView: UIView ,BottomLineVisible{
    
    
    //MARK: - 外部设置属性
    
    @IBInspectable public var rowHeight:CGFloat = 44.0
    
    @IBInspectable public var contentColor: UIColor = UIColor.white{
        didSet{
            contentView.backgroundColor = contentColor
        }
    }
    
    // @IBInspectable 不支持枚举类型
    public var associationFrameEnum: MGAssociationFrameEnum = .custom{
        didSet{
            contentViewWithFrame()
        }
    }
    // @IBInspectable 不支持 protocol
    public weak var delegate : MGAssociationMenuViewDelegate?{
        didSet{
            reload()
        }
    }
    
    //MARK: - 私有属性
    
    /*! 第一列对应的数据 */
    fileprivate var firstListData : [Any] =  [Any](){
        didSet{
            if firstListData.count > 0 {
                contentViewWithFrame()
                associationViews.forEach({ (view) in
                    view.removeFromSuperview()
                })
                associationViews.removeAll()
                tableViews.removeAll()
                addAssociationView(listData: firstListData, column: 0)
            }
        }
    }
    
    lazy fileprivate var contentView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = self.contentColor
        return view
    }()
    
    
    /*! 存储每列对应的View */
    fileprivate var associationViews: [MGAssociationSingleView] = []{
        didSet{
           tableViews = associationViews.flatMap({ (view) -> MGAssociationTableView? in
              return view.tableView
           })
        }
    }
    
    /*! 存储每列对应的TableView */
    fileprivate var tableViews: [MGAssociationTableView] = []
    
    
    /*! 存储每列对应选中的数据 */
    fileprivate var selectDatas: [Any] = []
    
    
    //MARK: - BottomLineVisible 属性实现
    
    public var lineHeight: CGFloat = 0.5
    
    public var lineColor: UIColor = UIColor(red: 239.0/255, green: 239.0/255, blue: 239.0/255, alpha: 1)
    
    
    //MARK: - 生命周期

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(contentView)
        contentViewWithFrame()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubview(contentView)
        contentViewWithFrame()
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        contentViewWithFrame()
    }
    
    /*! 更新约束 */
    override open func updateConstraints() {
        super.updateConstraints()
        
        for view in associationViews {
            view.snp.updateConstraints({ (make) in
                make.width.equalTo(contentView.frame.width/CGFloat(associationViews.count))
            })
        }
    }
}

//MARK: - 外部调用方法

extension MGAssociationMenuView{

    /*! 刷新第一列数据 */
    public func reload(){
        if let listData = delegate?.configureFirstTableData(){
            firstListData = listData
        }
    }
}


//MARK: - 内部实现方法

extension MGAssociationMenuView{
    
    /*! 设置contentView的高度 */
    fileprivate func contentViewWithFrame(){
        var contentViewHeight:CGFloat =  self.frame.height
        if associationFrameEnum == .autoLayout {
            let maxHeight =  CGFloat(firstListData.count)*rowHeight
            if maxHeight > contentViewHeight {
                let maxCount = floor(contentViewHeight/rowHeight)
                contentViewHeight = CGFloat(maxCount)*rowHeight
            }
            else{
                contentViewHeight = maxHeight
            }
        }
        contentView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: contentViewHeight)
    }
    
    /*! 添加或者刷新一列 */
    fileprivate func addAssociationView(listData:[Any],column:Int ,isReload: Bool = true){
        
        if column < associationViews.count {
            
            if column != associationViews.count - 1 {
                var views = [MGAssociationSingleView]()
                for (index, view) in associationViews.enumerated() {
                    if index > column {
                        view.removeFromSuperview()
                    }
                    else
                    {
                        views.append(view)
                    }
                }
                associationViews = views
                animateWithTables()
            }
            
            if isReload {
                let lastView = associationViews.last!
                lastView.tableView.contentOffset = CGPoint.zero
                lastView.tableView.listData = listData
            }
        }
        else
        {
            addAssociationView(listData:listData)
        }
    }
    
    
    /*! 添加选中数据到数组 */
    fileprivate func addSelectCellData(indexOfTables:Int,data:Any){
        if indexOfTables < selectDatas.count {
            selectDatas = Array(selectDatas.prefix(upTo: indexOfTables))
        }
         selectDatas.append(data)
    }
    
    /*! 添加一列View */
    fileprivate func addAssociationView(listData:[Any]){
        
        let associationView = MGAssociationSingleView(frame: CGRect.zero)
        associationView.tableView.listData = listData
        associationView.tableView.delegate = self
        associationView.tableView.dataSource = self
        contentView.addSubview(associationView)
        
        if associationViews.count == 0 {
            associationViews.append(associationView)
            tableViews.append(associationView.tableView)
            
            associationView.snp.makeConstraints({ (make) in
                make.left.top.bottom.equalTo(contentView)
                make.width.equalTo(contentView.frame.width)
            })
            layoutIfNeeded()
        }
        else{
            
            associationView.frame = CGRect(x: contentView.frame.width, y: 0, width: contentView.frame.width, height: contentView.frame.height)
            associationViews.append(associationView)
            tableViews.append(associationView.tableView)
            
            let lastView = associationViews.last!
            associationView.snp.remakeConstraints({ (make) in
                make.width.equalTo(contentView.frame.width)
                make.top.bottom.equalTo(contentView)
                make.left.equalTo(lastView.snp.right)
            })
            animateWithTables()
        }
    }
    
    /*! 展示出来的动画 */
    fileprivate func animateWithTables(){
        
        setNeedsUpdateConstraints()
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.75, initialSpringVelocity: 10, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.layoutIfNeeded()
        }, completion:nil)
    }
    
}

//MARK: - UITableViewDelegate

extension MGAssociationMenuView : UITableViewDelegate{
    
    public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath?{
        if tableView.indexPathForSelectedRow == indexPath {
            return indexPath
        }

        guard let `delegate` = delegate else {
            assertionFailure("老大，实现delegate去吧")
            return indexPath
        }
        
        let listData = (tableView as! MGAssociationTableView).listData
        guard let indexOfTables = tableViews.index(of: tableView as! MGAssociationTableView) else { return  indexPath }
        
        addSelectCellData(indexOfTables: indexOfTables, data: listData[indexPath.row])
        
        if let nextListData = delegate.selectToNextTableData(tableView, tableForColumnAt: indexOfTables, cellForRowAt: indexPath, cellForTableAt: listData[indexPath.row]),
            nextListData.count > 0 {
            addAssociationView(listData: nextListData, column: indexOfTables + 1)
        }
        else
        {
            addAssociationView(listData: listData, column: indexOfTables,isReload: false)
            delegate.completionWithSelectData(selectDatas)
        }
        
        return indexPath
    }
}

//MARK: - UITableViewDataSource

extension MGAssociationMenuView : UITableViewDataSource{
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        let listData = (tableView as! MGAssociationTableView).listData
        return listData.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        guard let `delegate` = delegate else {
            assertionFailure("老大，实现delegate去吧")
            return UITableViewCell()
        }
        
        let listData = (tableView as! MGAssociationTableView).listData
        guard let indexOfTables = tableViews.index(of: tableView as! MGAssociationTableView) else { return  UITableViewCell() }
        
        if let cell = delegate.configureCell(tableView, tableForColumnAt: indexOfTables, cellForRowAt: indexPath, cellForTableAt: listData[indexPath.row]) {
            deleteLineTo(view: cell)
            addLineTo(view: cell, edge: nil)
            return cell
        }
        return UITableViewCell()
    }
}
