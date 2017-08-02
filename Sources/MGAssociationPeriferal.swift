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
//  BottomLineVisible.swift
//  MGAssociationMenuView
//
//  Created by song on 2017/8/1.
//  Copyright © 2017年 song. All rights reserved.
//

import UIKit


//MARK: - MenuView 高度控制

public enum MGAssociationFrameEnum: Int{
    
    /*!根据高度自动计算出最多显示多少行 */
    case autoLayout = 0
    /*! 直接显示本身高度 */
    case custom
}


//MARK: - view加线 Protocol

public protocol BottomLineVisible : class {
    
    var lineColor: UIColor { get set }
    
    var lineHeight: CGFloat { get set }
    
    func addLineTo(view:UIView, edge:UIEdgeInsets?)
    
    func deleteLineTo(view:UIView)
}


extension BottomLineVisible{
    
    public func addLineTo(view:UIView, edge:UIEdgeInsets?){
        
        let lineEdge = edge ?? UIEdgeInsets.zero
        
        let lineView = UIView()
        lineView.tag = 135792
        lineView.backgroundColor = lineColor
        view.addSubview(lineView)
        
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(lineEdge.left)
            make.right.equalTo(view).offset(lineEdge.right)
            make.bottom.equalTo(view).offset(lineEdge.bottom)
            make.height.equalTo(lineHeight)
        }
    }
    
    public func deleteLineTo(view:UIView){
        if let subView = view.viewWithTag(135792) {
            subView.removeFromSuperview()
        }
    }
}

