//
//  StrategyColumnView.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/21.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SnapKit

fileprivate let cellColumns = 3
fileprivate let cellScale:CGFloat = 340.0/90.0

class StrategyColumnViewCell: UICollectionViewCell {
//MARK： 属性
    fileprivate let identifier = "strategyColumnSubCell"
    weak var delegate:StrategyColumnViewCellDelegate?
    

    var items:Int = 15
//MARK: 懒加载
    lazy var collectionView:UICollectionView = { () -> UICollectionView in
       let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: StrategyColumnViewFlowLayout())
        view.backgroundColor = UIColor.white
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.delegate = self
        view.dataSource = self
        view.register(StrategyColumnSubCell.self, forCellWithReuseIdentifier: self.identifier)
        return view
    }()
    
//MARK: 构造方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStrategyColumnView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        setupStrategyColumnViewSubView()
    }
    
//MARK: 私有方法
    private func setupStrategyColumnView() {
        addSubview(collectionView)
    }
    
    private func setupStrategyColumnViewSubView() {
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
    }
}

//MARK: 代理方法
extension StrategyColumnViewCell:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! StrategyColumnSubCell
        cell.viewModel = StrategyColumnSubCellViewModel(withModel: StrategyColumnSubCellDataModel())
        cell.coverView.isHidden = indexPath.item == 14 ? false: true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.strategyColumnViewCellDidSelectItemAt(withCell: self, indexPath: indexPath)
    }
}

class StrategyColumnViewFlowLayout:UICollectionViewFlowLayout{
    override func prepare() {
        minimumLineSpacing = margin
        minimumInteritemSpacing = margin * 0.5
        let height = (collectionView!.bounds.height - margin * CGFloat(cellColumns + 1))/CGFloat(cellColumns)
        let width = height * cellScale
        
        itemSize = CGSize(width: width, height: height)
        sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        
        scrollDirection = .horizontal
    }
}

//MARk: 协议
protocol StrategyColumnViewCellDelegate:NSObjectProtocol{
    func strategyColumnViewCellDidSelectItemAt(withCell cell:StrategyColumnViewCell, indexPath:IndexPath)
}
