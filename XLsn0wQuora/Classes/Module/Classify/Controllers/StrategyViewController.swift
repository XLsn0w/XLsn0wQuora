//
//  StrategyViewController.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/21.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SnapKit
import QorumLogs

fileprivate let cellColumns = 2
fileprivate let columnCellHeight:CGFloat = 250.0
fileprivate let cellScale:CGFloat = 2

class StrategyViewController: UIViewController {

//MARK: 属性
    fileprivate let strategyIdentifier = "strategyCell"
    fileprivate let strategyClassifyIdentifier = "strategyClassifyCell"
    fileprivate let sectionIdentifier = "strategySectionCell"
//MARK: 懒加载
    lazy var mainView:UICollectionView = { () -> UICollectionView in
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: StrategyCollectionViewFlowLayout())
        view.backgroundColor = UIColor.white
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.delegate = self
        view.dataSource = self
        view.register(StrategyColumnViewCell.self, forCellWithReuseIdentifier: self.strategyIdentifier)
        view.register(StrategyClassifyViewCell.self, forCellWithReuseIdentifier: self.strategyClassifyIdentifier)
        view.register(StrategySectionView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: self.sectionIdentifier)
        return view
    }()
//MARK: 系统方法
    override func viewDidLoad() {
        super.viewDidLoad()

        setupStrategyView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        setupStrategyViewSubView()
    }
//MARK: 私有方法
    private func setupStrategyView() {
        view.backgroundColor = UIColor.white
        view.addSubview(mainView)
    }
    
    private func setupStrategyViewSubView() {
        mainView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
    }


}

//MARK: 布局样式
class StrategyCollectionViewFlowLayout:UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        
        minimumLineSpacing = margin
        minimumInteritemSpacing = margin * 0.5
        scrollDirection = .vertical
        
        itemSize = CGSize(width: collectionView!.bounds.width, height: columnCellHeight)
        headerReferenceSize = CGSize(width: ScreenWidth, height: 44)
        sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
    }
        
}

//MARK: 代理方法
extension StrategyViewController:UICollectionViewDelegate,UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: strategyIdentifier, for: indexPath) as! StrategyColumnViewCell
            cell.delegate = self
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: strategyClassifyIdentifier, for: indexPath) as! StrategyClassifyViewCell
        
        cell.viewModel = StrategyClassifyViewCellViewModel(withModel: StrategyClassifyViewCellDataModel())
      
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let section = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: sectionIdentifier, for: indexPath) as! StrategySectionView
        section.delegate = self
        return section
    }
    
    
}

//MARK: 代理方法 -> StrategyColumnViewCellDelegate
extension StrategyViewController:StrategyColumnViewCellDelegate {
    func strategyColumnViewCellDidSelectItemAt(withCell cell: StrategyColumnViewCell, indexPath: IndexPath) {
        
        if indexPath.item == cell.items - 1 {
            QL1("\(indexPath.section)")
            navigationController?.pushViewController(AllClassifyViewController(), animated: true)
            
        }else{
            QL2("\(indexPath.section)")
             navigationController?.pushViewController(ClassifySingleListViewController(), animated: true)
        }
    }
}
//MARK: 代理方法 -> StrategyColumnViewCellDelegate
extension StrategyViewController:StrategySectionViewDelegate {
    func strategySectionViewRightButtonClick() {
        navigationController?.pushViewController(AllClassifyViewController(), animated: true)
    }
}
