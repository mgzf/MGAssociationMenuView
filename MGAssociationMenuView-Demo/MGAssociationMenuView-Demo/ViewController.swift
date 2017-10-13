//
//  ViewController.swift
//  MGAssociationMenuView
//
//  Created by song on 2017/7/31.
//  Copyright © 2017年 song. All rights reserved.
//

import UIKit

struct OneModel {
    
    var text : String = ""
    
    var twoModels : [TwoModel]
    
}

struct TwoModel {
    
    var text : String = ""
    
    var threeModels : [ThreeModel]
    
}

struct ThreeModel {
    
    var text : String = ""
    
     var frouModels : [FrouModel]
    
}

struct FrouModel {
    
    var text : String = ""
    
}


class ViewController: UIViewController {
    
    var oneModels : [OneModel] = {
        var oneModels = [OneModel]()
        for index in 0...10 {
            var twoModels : [TwoModel] = []
            for index1 in 0...11 {
                var threeModels : [ThreeModel] = []
                for index2 in 0...12 {
                    
                    var frouModels : [FrouModel] = []
                    for index3 in 0...13 {
                        
                        frouModels.append(FrouModel(text: "\(index):\(index1):\(index2):\(index3)"))
                        
                    }
                    
                    threeModels.append(ThreeModel(text: "\(index):\(index1):\(index2)", frouModels: frouModels))
                    
                }
                if index1 < 2 {
                   twoModels.append(TwoModel(text: "\(index):\(index1)", threeModels: []))
                }
                else
                {
                   twoModels.append(TwoModel(text: "\(index):\(index1)", threeModels: threeModels))
                }
            }
            
            oneModels.append(OneModel(text: "one:\(index)", twoModels: twoModels))
        }
        return oneModels
    }()

    @IBOutlet weak var associationMenuView: MGAssociationMenuView!{
        didSet{
           associationMenuView.delegate = self
        }
    }
    
    @IBAction func reloadEvent(_ sender: Any) {
        associationMenuView.reload()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.


        
        associationMenuView.associationFrameEnum = .autoLayout

        associationMenuView.reload()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: MGAssociationMenuViewDelegate{
    
    func registerCell(_ tableView: UITableView, tableForColumnAt  column: Int){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }
    
    func configureFirstTableData() -> [Any] {
        return oneModels
    }
    
    func configureCell(_ tableView: UITableView, tableForColumnAt  column: Int, cellForRowAt indexPath: IndexPath , cellForTableAt data: Any) -> UITableViewCell?{
        let cell = UITableViewCell(style: .default, reuseIdentifier: "UITableViewCell")
        cell.backgroundColor = UIColor.clear
        if let oneModel = data as? OneModel {
            cell.textLabel?.text = oneModel.text
        }
        else if let twoModel = data as? TwoModel {
            cell.textLabel?.text = twoModel.text
        }
        else if let threeModel = data as? ThreeModel {
            cell.textLabel?.text = threeModel.text
        }
        else if let frouModel = data as? FrouModel {
            cell.textLabel?.text = frouModel.text
        }
        
        return cell
    }
    
    func selectToNextTableData(_ tableView: UITableView, tableForColumnAt  column: Int, cellForRowAt indexPath: IndexPath , cellForTableAt data: Any?) -> [Any]?{
        tableView.allowsMultipleSelection = column == 3
        if column == 3 && indexPath.row == 0 {
            tableView.selectRow(at: IndexPath.init(row: 9, section: 0), animated: false, scrollPosition: .none)
        }
        if let oneModel = data as? OneModel {
            return oneModel.twoModels
        }
        else if let twoModel = data as? TwoModel {
            return twoModel.threeModels
        }
        else if let threeModel = data as? ThreeModel {
            return threeModel.frouModels
        }
        return nil
    }
    
    func completionWithSelectData(_ selectData : [Any] ){
        print("多列信息数组:\(String(describing: selectData.last))")
    }
    
    func completionFinalColumnWithSelectData(_ selectData : [Any] ) {
        print("只存储最后一列的信息:\(selectData)")
    }

}

