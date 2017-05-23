//
//  LZBPageView.swift
//  LZBPageView
//
//  Created by zibin on 2017/5/12.
//  Copyright © 2017年 项目共享githud地址：https://github.com/lzbgithubcode/LZBPageView 简书详解地址：http://www.jianshu.com/p/3170d0d886a2  作者喜欢分享技术与开发资料，如果你也是喜欢分享的人可以加入我们iOS资料demo共享群：490658347. All rights reserved.
//

import UIKit

class LZBPageView: UIView {
    //MARK - 属性保存
    var titles : [String]
    var pageStyle : LZBPageStyleModel
    var childVcs  : [UIViewController]
    var parentVc  : UIViewController
    
    init(frame: CGRect, titles : [String], pageStyle : LZBPageStyleModel, childVcs : [UIViewController] , parentVc: UIViewController) {
        self.titles = titles
        self.pageStyle = pageStyle
        self.childVcs = childVcs
        self.parentVc = parentVc
        super.init(frame:frame)
        self.setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: UI初始化
extension LZBPageView {
    
  fileprivate func setupUI(){
      //1.创建titleView
    let titleViewFrame = CGRect(x: 0, y: 0, width: bounds.width, height: self.pageStyle.titleViewHeight)
    let titleView = LZBTitleView(frame: titleViewFrame, titles: self.titles, style: self.pageStyle)
     titleView.backgroundColor = UIColor.orange
    self.addSubview(titleView)
      //2.创建内容View
    let contentFrame = CGRect(x: 0, y: titleView.frame.maxY, width: bounds.width, height: bounds.height - titleView.frame.maxY)
    let contentView = LZBContentView(frame: contentFrame, childVcs: childVcs, parentVc: parentVc, style: pageStyle)
    contentView.backgroundColor = UIColor.blue
    self.addSubview(contentView)
    
    //3.设置代理对象
      titleView.delegate = contentView
      contentView.delegate = titleView
    
    }
}
