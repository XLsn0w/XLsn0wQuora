//
//  MeViewController.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/15.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SnapKit


public enum barButtonType : Int {
    
    case Message
    
    case Alarm
    
    case Setting
    
    case Calender
    
}

class MeViewController: UIViewController {

//MARK: 属性

    
    fileprivate let meIdentifier = "meCell"
    
   
//MARK: 懒加载
    lazy var headerView:MeHeaderView = MeHeaderView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 300.0))
    lazy var footerView:MeFooterView = MeFooterView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 300.0))
    lazy var footerSectionView:MeFooterSectionView = MeFooterSectionView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 60.0))
    lazy var tableView:UITableView = { () -> UITableView in
        let view = UITableView(frame: CGRect.zero, style: .grouped)
        view.backgroundColor = SystemGlobalBackgroundColor
        view.sectionHeaderHeight = 0.001
        view.sectionFooterHeight = 0.001
        view.delegate = self
        view.dataSource = self
        
        view.register(UITableViewCell.self , forCellReuseIdentifier: self.meIdentifier)
        return view
    }()
//MARK: 系统方法
    override func viewDidLoad() {
        super.viewDidLoad()

        setupMeView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupMeViewWhenWillAppear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        setupMeViewWhenWillDisappear()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        setupMeViewSubView()
       
    }
    

//MARK: 私有方法
    private func setupUpdateViewSubViewData() {
        if AccountModel.isLogin() {
            let model = MeHeaderDataModel()
            
            model.headIconUrl = AccountModel.shareAccount()!.avatar
            model.userName = AccountModel.shareAccount()!.nickname
            model.sex = AccountModel.shareAccount()!.sex
            
            headerView.viewModel = MeHeaderViewModel(withModel: model)
            footerView.viewModel = MeFooterViewModel(isLogin: true)
        }
        else{
            headerView.viewModel = MeHeaderViewModel(withModel: nil)
            footerView.viewModel = MeFooterViewModel(isLogin: false)
        }
    }
    
    private func setupMeViewWhenWillAppear() {
        hideNavigationBar(isHiden: true)
        setupUpdateViewSubViewData()
    }
    
    private func setupMeViewWhenWillDisappear() {
        hideNavigationBar(isHiden: false)
    }
    
    private func setupMeView() {
        view.backgroundColor = UIColor.white
        
        
        let msgBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "me_message").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(barButtonClick(item:)))
        msgBarButtonItem.tag = barButtonType.Message.rawValue
        
        let alrmBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "me_giftremind").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(barButtonClick(item:)))
        alrmBarButtonItem.tag = barButtonType.Alarm.rawValue
        
       
        let dateBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "feed_signin").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(barButtonClick(item:)))
        dateBarButtonItem.tag = barButtonType.Calender.rawValue
        
        let setBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "iconSettings").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(barButtonClick(item:)))
        setBarButtonItem.tag = barButtonType.Setting.rawValue
    
        navigationItem.leftBarButtonItems = [dateBarButtonItem,msgBarButtonItem]
        
        navigationItem.rightBarButtonItems = [setBarButtonItem,alrmBarButtonItem]
        
        
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = footerView
        headerView.delegate = self
        footerView.delegate = self
        
        
        view.addSubview(tableView)
       
    }
    
    private func setupMeViewSubView() {
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
        
        tableView.contentInset = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
    }
//MARK: 内部响应处理
    @objc private func barButtonClick(item:UIBarButtonItem) {
        
        switch item.tag {
        case barButtonType.Message.rawValue:
            print("message")
        case barButtonType.Alarm.rawValue:
            print("alarm")
        case barButtonType.Calender.rawValue:
            print("calender")
        case barButtonType.Setting.rawValue:
            
            navigationController?.pushViewController(SettingViewController(), animated: true)
        default:
            break
        }
        
    }

}

//MARK: 懒加载
extension MeViewController:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: meIdentifier, for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ItemWidth
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return footerSectionView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y - 20
        if offsetY > 0 {
            return
        }
        
        if offsetY >= 0.0 {
            headerView.backgroundImageView.transform = CGAffineTransform(translationX: 0, y: offsetY * 0.8)
        }
        else {
            let transform = CGAffineTransform(translationX: 0, y: offsetY)
            let scale = 1 - offsetY * 0.01
            
            //: 在固定的形变中缩放
            headerView.backgroundImageView.transform = transform.scaledBy(x: 1, y: scale)
        
        }
        
    }
    
}

//MARK: 代理方法

extension MeViewController:MeHeaderViewDelegate,MeHeadFooterViewDelegate,MeFooterViewDelegate{
    func meHeaderViewHeadIconButtonClick(button: UIButton) {
        if !AccountModel.isLogin() {
            present(loginViewController(), animated: true, completion: nil)
        }
    }
    
    func meHeadFooterViewButtonClick(withType type:OptionButtonType) {
        if !AccountModel.isLogin() {
            present(loginViewController(), animated: true, completion: nil)
        }
        else{
            
            switch type {
            case OptionButtonType.Custemer:
              _ = navigationController?.pushViewController(ChatViewController(), animated: true)
            default:
                break
            }
        }
    }
    
    func meFooterViewLoginButtonClick() {
        if !AccountModel.isLogin() {
            present(loginViewController(), animated: true, completion: nil)
        }
    }
}
