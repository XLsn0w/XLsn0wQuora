//
//  AllClassifyViewController.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/23.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SnapKit

fileprivate let cellColumns = 1
fileprivate let cellScale:CGFloat = 340.0 / 90.0

class AllClassifyViewController: UIViewController {
//MARK: 属性
    fileprivate let allClassifyIdentifier = "allClassifyCell"
//MARK: 懒加载
    lazy var colleciontView:UICollectionView = { () -> UICollectionView in
       let view  = UICollectionView(frame: CGRect.zero, collectionViewLayout: AllClassifyViewFlowLayout())
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = UIColor.white
        view.showsVerticalScrollIndicator = false
        view.register(StrategyColumnSubCell.self, forCellWithReuseIdentifier: self.allClassifyIdentifier)
        return view
    }()
//MARK: 系统方法
    override func viewDidLoad() {
        super.viewDidLoad()

        setupAllClassifyView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        setupAllClassifyViewSubView()
    }
//MARK: 私有方法
    private func setupAllClassifyView() {
        title = "全部分类"
        view.addSubview(colleciontView)
    }
    
    private func setupAllClassifyViewSubView() {
        colleciontView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
    }

}

//MARK: 代理方法 -> 
extension AllClassifyViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: allClassifyIdentifier, for: indexPath) as! StrategyColumnSubCell
        cell.viewModel = StrategyColumnSubCellViewModel(withModel: StrategyColumnSubCellDataModel())
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}


class AllClassifyViewFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        minimumLineSpacing = margin
        minimumInteritemSpacing = margin * 0.5
        let width = collectionView!.bounds.width - (CGFloat(cellColumns + 1) * cellMargin)
        let height = width / cellScale
         itemSize = CGSize(width: width, height: height)
       
        sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        scrollDirection = .vertical
    }
}
