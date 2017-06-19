//
//  HomeViewController.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/15.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit

let popoverViewHeight:CGFloat = 44.0


class GiftHomeViewController: UIViewController {
//MARK： 属性列表
    var classifyTitles: Array<String> {
        return ["精选", "海淘", "创意生活", "送女票", "科技范", "送爸妈", "送基友", "送闺蜜", "送同事", "送宝贝", "设计感", "文艺范", "奇葩搞怪", "萌萌哒"]
    }
    
    //: 分类列表View缓存池
     var cacheClassifyViews = Array<UIView>()
//MARK: 懒加载
    private lazy var titleView: UIImageView = { () -> UIImageView in
        let view = UIImageView(image: #imageLiteral(resourceName: "logo"))
        view.contentMode = .scaleAspectFit
        let scale = view.image!.size.width/view.image!.size.height
        view.bounds = CGRect(x: 0, y: 0, width:20 * scale , height: 20)
        return view
    }()
    
    //: 主滚动视图
    fileprivate lazy var scrollView:UIScrollView = { () -> UIScrollView in
        let view = UIScrollView()
       
        view.delegate = self
        view.showsHorizontalScrollIndicator = false
        //: 允许分页
        view.isPagingEnabled = true
        return view
    }()
    
    fileprivate lazy var popoverView:PopoverClassifyView = {
       let view = PopoverClassifyView()
        view.backgroundColor = UIColor.white
        view.titles = self.classifyTitles
        view.delegate = self
        
        return view
    }()
//MARK: 系统方法
    
    var pullView:WXPullView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupHomeView()
        
        
        pullView =  WXPullView.init(frame: CGRect(x: UIScreen.main.bounds.width/2-25, y: -64, width:50, height: 30))
        
        
        scrollView.addSubview(pullView!)
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        setupHomeViewSubView()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pullView?.animation(with: scrollView.contentOffset.y)
        //[self.pullView animationWith:scrollView.contentOffset.y];
    }
 
//MARK: 私有方法
    private func setupHomeView() {
        view.backgroundColor = SystemGlobalBackgroundColor
        
        self.title = "xxxx";
        
        navigationItem.leftBarButtonItem = UIBarButtonItem("ico_camera", target: self, action: #selector(scanButtonClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem("icon_navigation_search",target: self,action: #selector(searchButtonClick))
        
        //: 设置中间视图
        navigationItem.titleView = titleView
        
        view.addSubview(scrollView)
        view.addSubview(popoverView)
        
        //: 添加子控制器
        for i in 0..<classifyTitles.count {
            let controller = i == 0 ? mainClassifyViewController() : BaseClassifyViewController()
            
//  controller.tableView.backgroundColor = UIColor.init(red: CGFloat(arc4random_uniform(255))/CGFloat(255.0), green: CGFloat(arc4random_uniform(255))/CGFloat(255.0), blue: CGFloat(arc4random_uniform(255))/CGFloat(255.0), alpha: 1.0)
            

            addChildViewController(controller)
            scrollView.addSubview(controller.view)
            cacheClassifyViews.append(controller.view)
        }
        
    }
    
    private func setupHomeViewSubView() {
        popoverView.snp.makeConstraints { (make) in
            make.left.top.width.equalToSuperview()
            make.height.equalTo(popoverViewHeight)
        }
        
        scrollView.snp.makeConstraints { (make) in
            make.left.width.equalToSuperview()
            make.top.equalTo(popoverView.snp.bottom)
            make.height.equalTo(view.bounds.height - popoverViewHeight)
        }
        
        
        for i in 0..<classifyTitles.count {
            let view = cacheClassifyViews[i]
            
            view.frame = CGRect(x:scrollView.bounds.width * CGFloat(i), y: 0, width: scrollView.bounds.width, height: scrollView.bounds.height)
        }
        
        scrollView.contentSize = CGSize(width: CGFloat(classifyTitles.count) * scrollView.bounds.width, height: 0)
    }
//MARK: 响应事件
    @objc private func scanButtonClick() {
        present(UINavigationController(rootViewController: LSXQRCodeViewController()), animated: true, completion: nil)
    }
    
    @objc private func searchButtonClick() {
        navigationController!.pushViewController(SearchViewController(), animated: true)
    }
}

//MARK: 代理方法 -> UIScrollViewDelegate
extension GiftHomeViewController:UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x / scrollView.bounds.width
        
        popoverView.scrollButtonSelected(index: Int(index))
    }
}

extension GiftHomeViewController:PopoverClassifyViewDelegate{
    func popoverSrcollViewSelectedClassifyEndIndex(index: Int) {
        
        scrollView.setContentOffset(CGPoint(x: CGFloat(index) * scrollView.bounds.width, y: 0), animated: true)
    }
}
