//
//  SnapKitLayoutViewController.swift
//  AutoLayoutDemo
//
//  Created by 董知樾 on 2017/3/27.
//  Copyright © 2017年 董知樾. All rights reserved.
//

import UIKit
import SnapKit

class SnapKitLayoutViewController: UIViewController {

    var layoutWays : [Dictionary<String, String>]!
    var tableView = UITableView()
    let identifier = "SnapKitLayoutViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "SnapKit代码布局"
        view.backgroundColor = .white
        
        layoutWays = [
            ["title":"常规布局","className":"SKGeneralViewController"],
            ["title":"动画","className":"SKAnimationViewController"],
            ["title":"UIScrollView","className":"SKScrollViewController"],
            ["title":"UITableView","className":"SKTableViewController"],
            ["title":"UILayoutGuide","className":"SKLayoutGuideViewController"],
            ["title":"抗压缩、拉伸","className":"SKHugCompressViewController"],
            ["title":"自有尺寸-IntrinsicSzie","className":"SKIntrinsicSizeViewController"]
            ]
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view);
        }
        tableView.separatorInset = .zero
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: identifier)
        
    }
    
}

extension SnapKitLayoutViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return layoutWays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.text = layoutWays[indexPath.row]["title"]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vClass = layoutWays[indexPath.row]["className"] {
            let vc = NSClassFromString("AutoLayoutDemo."+vClass) as! UIViewController.Type
            navigationController?.pushViewController(vc.init(), animated: true)
        }
    }
}
