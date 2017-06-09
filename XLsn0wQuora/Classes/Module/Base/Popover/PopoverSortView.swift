//
//  PopoverSortView.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/24.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit

fileprivate let SeparatorColor = UIColor(red: 120.0/255.0, green: 120.0/255.0, blue: 120.0/255.0, alpha: 1.0)

class PopoverSortView: UIView {
//MARK: 属性
    fileprivate let cellIdentifier = "popoverSortCell"
    
    var selectedRow:Int = 0
    let titles:Array<String> = ["默认排序", "按热度排序", "价格从低到高", "价格从高到低"]
//MARK: 懒加载
    lazy var backgoundImage:UIImageView = UIImageView(image: #imageLiteral(resourceName: "popover_background_right"))
    lazy var tableView:UITableView = { () -> UITableView in
        let view = UITableView(frame: CGRect.zero, style: .plain)
        
        view.sectionHeaderHeight = 0.0001
        view.sectionFooterHeight = 0.0001
        view.backgroundView = nil
        view.backgroundColor = UIColor.clear
        view.separatorInset = UIEdgeInsets.zero
        view.layoutMargins = UIEdgeInsets.zero
        view.separatorColor = SeparatorColor
        
        view.delegate = self
        view.dataSource = self
        
        view.register(PopoverSortCell.self, forCellReuseIdentifier: self.cellIdentifier)
        
        
        return view
    }()
//MARK: 构造方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPopoverView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupPopoverViewSubView()
    }
    
//MARK: 私有方法
    private func setupPopoverView() {
        isHidden = true
        addSubview(backgoundImage)
        addSubview(tableView)
    }
    
    private func setupPopoverViewSubView() {
        backgoundImage.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(margin * 0.5)
            make.right.bottom.equalToSuperview().offset(-margin*0.5)
            make.top.equalToSuperview().offset(margin)
            
        }
    }
    
//MARK: 开放接口
    func show() {
        let oldposition = layer.position
        let oldanchor = layer.anchorPoint
        let newanchor = CGPoint(x: 0.5, y: 0.0)
        let newX = oldposition.x + (newanchor.x - oldanchor.x) * bounds.size.width
        let newY = oldposition.y + (newanchor.y - oldanchor.y) * bounds.size.height
        
        isHidden = false
        transform = CGAffineTransform(scaleX: 1.0, y: 0.0)
        layer.anchorPoint = newanchor
        layer.position = CGPoint(x: newX, y: newY)
        
        UIView.animate(withDuration: 0.2) {
            self.transform = .identity
        }
    }
    
    
    func hide() {
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform(scaleX: 1.0, y: 0.000001)
        }) { (_) in
            self.isHidden = true
        }
    }

}

//MARK: 代理方法
extension PopoverSortView:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ItemWidth
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PopoverSortCell
        
        cell.viewModel = PopoverSortCellViewModel(withText: titles[indexPath.row], isSelected: indexPath.row == selectedRow ? true : false)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
        tableView.reloadData()
    }
    
}
