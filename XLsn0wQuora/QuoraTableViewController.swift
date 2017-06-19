//
//  QuoraTableViewController.swift
//  XLsn0wQuora
//
//  Created by XLsn0w on 2017/6/19.
//  Copyright © 2017年 XLsn0w. All rights reserved.
//

import UIKit

class QuoraTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        add_tableView()
    }
    
    var titleArr: [[[String: String]]] = [[
        ["clsName":"YWBasicAnimController","title":"CABasicAnimation基础动画"],
        ["clsName":"YWKeyframeAnimController","title":"CAKeyframeAnimation基础动画"],
        ["clsName":"YWDrawLineController","title":"画线动画、线条递增、递减动画"],
        ["clsName":"YWTransitionViewController","title":"CATransition转场动画"],
        ["clsName":"YWSpringAnimViewController","title":"CASpringAnimation弹簧动画"]],
                                          [["clsName":"YWDrawLineController","title":"画线动画"],
                                           ["clsName":"YWWaterWaveController","title":"水波纹效果"],
                                           ["clsName":"YWFireAnimController","title":"粒子动画-火苗效果"]]
    ]
    
    var sectionTitleArr = ["动画基础示例","动画常见经典案例"]
    
    func add_tableView() {
        let tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier:"cell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return titleArr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let tempArr = self.titleArr[section]
        return tempArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tempArr = titleArr[indexPath.section]
        let tempDic = tempArr[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tempDic["title"]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tempArr = titleArr[indexPath.section]
        let tempDic = tempArr[indexPath.row]
        let nameSpace = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String
        guard let clsName = tempDic["clsName"], let cls = NSClassFromString(nameSpace + "." + clsName) as? UIViewController.Type else {
            return
        }
        
        
        let vc = cls.init()
        vc.title = tempDic["title"]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitleArr[section]
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}



//extension ViewController: UITableViewDelegate, UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return titleArr.count
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let tempArr = self.titleArr[section]
//        return tempArr.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let tempArr = titleArr[indexPath.section]
//        let tempDic = tempArr[indexPath.row]
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = tempDic["title"]
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let tempArr = titleArr[indexPath.section]
//        let tempDic = tempArr[indexPath.row]
//        let nameSpace = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String
//        guard let clsName = tempDic["clsName"], let cls = NSClassFromString(nameSpace + "." + clsName) as? UIViewController.Type else {
//            return
//        }
//
//
//        let vc = cls.init()
//        vc.title = tempDic["title"]
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return sectionTitleArr[section]
//    }
//}
