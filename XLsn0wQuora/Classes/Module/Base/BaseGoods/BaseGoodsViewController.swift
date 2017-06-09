//
//  BaseGoodsViewController.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/20.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SnapKit

let collectionViewRow:CGFloat = 2.0
let fixedHeight:CGFloat = 78.0

class BaseGoodsViewController: UIViewController {
//MARK: 属性
    fileprivate let identifier = "baseGoods"
//MARK: 懒加载
    lazy var mainView:UICollectionView = { () -> UICollectionView in
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: BaseGoodsFlowLayout())
        
        view.backgroundColor = SystemGlobalBackgroundColor
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.delegate = self
        view.dataSource = self
        
        view.register(BaseGoodsViewCell.self, forCellWithReuseIdentifier:self.identifier)
        
        return view
    }()
//MARK: 系统方法
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBaseGoodsView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        setupBaseGoodsViewSubView()
    }
//MARK: 私有方法
    private func setupBaseGoodsView() {
        view.addSubview(mainView)
    }
    
    private func setupBaseGoodsViewSubView() {
        mainView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
    }

}
//MARK: 代理方法 ->
extension BaseGoodsViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! BaseGoodsViewCell
        
        cell.viewModel = BaseGoodsViewModel(withModel: BaseGoodsDataModel())
        
        return cell
    }
}

//MARK: 布局相关
class BaseGoodsFlowLayout:UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        
        minimumLineSpacing = margin
        minimumInteritemSpacing = margin*0.5
        sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        scrollDirection = .vertical
        
        let width = (ScreenWidth - (margin * CGFloat(collectionViewRow + 1))) / CGFloat(collectionViewRow)
        let height = width + fixedHeight
        
        itemSize = CGSize(width: width, height: height)
    }
}
