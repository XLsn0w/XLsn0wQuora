//
//  CodeNativeLayoutViewController.swift
//  AutoLayoutDemo
//
//  Created by 董知樾 on 2017/3/27.
//  Copyright © 2017年 董知樾. All rights reserved.
//

import UIKit

class CodeNativeLayoutViewController: UIViewController {
    var layoutWays : [Dictionary<String, String>]!
    var tableView = UITableView()
    let identifier = "CodeNativeLayoutViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "原生代码布局"
        view.backgroundColor = .white
        
        layoutWays = [
            ["title":"常规布局","className":"CNGeneralViewController"],
            ["title":"动画","className":"CNAnimationViewController"],
            ["title":"NSLayoutAnchor","className":"CNLayoutAnchorViewController"],
            ["title":"UILayoutGuide","className":"CNLayoutGuideViewController"]
        ]
        
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let topAnchor = tableView.topAnchor.constraint(equalTo: view.topAnchor)
        let bottomAnchor = tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        let leadingAnchor = tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let trailingAnchor = tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        NSLayoutConstraint.activate([topAnchor,bottomAnchor,leadingAnchor,trailingAnchor])
        
        tableView.separatorInset = .zero
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: identifier)
        
    }
    
}

extension CodeNativeLayoutViewController : UITableViewDelegate, UITableViewDataSource{
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

