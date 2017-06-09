//
//  SingleGiftViewController.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/21.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SnapKit

fileprivate let cellColumns = 3
fileprivate let cellScale:CGFloat = 100.0 / 140.0
fileprivate let scale = 0.25

class SingleGiftViewController: UIViewController {

    fileprivate let singleGiftColumnIndentifier = "singleGiftColumnCell"
    fileprivate let singleGiftIndentifier = "singleGiftCell"
    fileprivate let singleGiftSectionIndentifier = "singleGiftSectionCell"
    
    fileprivate var isSelectedColumn = false
    fileprivate var selectedColumnRow = 0
//MARK: 懒加载
    lazy var tableView:UITableView = { () -> UITableView in
        let view = UITableView(frame: CGRect.zero, style: .plain)
        
        view.backgroundColor = SystemGlobalBackgroundColor
        view.separatorStyle = .none
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.sectionFooterHeight = 0.0001
        view.sectionHeaderHeight = 0.0001
        view.delegate = self
        view.dataSource = self
        
        view.register(SingleGiftColumnCell.self , forCellReuseIdentifier: self.singleGiftColumnIndentifier)
        
        return view
    }()
    
    lazy var collectionView:UICollectionView = { () -> UICollectionView in
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: SingleGiftViewFlowLayout())
        
        view.backgroundColor = UIColor.white
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.dataSource = self
        view.delegate = self
        
        view.register(SingleGiftCell.self, forCellWithReuseIdentifier: self.singleGiftIndentifier)
        view.register(SingleGiftSectionView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: self.singleGiftSectionIndentifier)
        
        return view
    }()
//MARK: 系统方法
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSingleGiftView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        setupSingleGiftViewSubView()
    }
//MARK: 私有方法
    private func setupSingleGiftView() {
        view.backgroundColor = UIColor.white
        view.addSubview(tableView)
        view.addSubview(collectionView)

    }
    
    private func setupSingleGiftViewSubView() {
        tableView.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(scale)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.left.equalTo(tableView.snp.right)
            make.top.right.bottom.equalToSuperview()
        }
    }
    
    fileprivate func tableViewScrollToAt(indexPath:IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else {
            return
        }
        
        
        if cell.center.y < tableView.bounds.height * 0.5 {
            tableView.setContentOffset(CGPoint.zero, animated: true)
        }
        //: 滚动按钮居中
        else if (tableView.contentSize.height > tableView.bounds.height)
        && (cell.center.y > tableView.bounds.height * 0.5)
        && (cell.center.y < (tableView.contentSize.height - tableView.bounds.height * 0.5)) {
        
            tableView.setContentOffset(CGPoint(x: 0, y: cell.frame.origin.y + cell.bounds.height * 1.0 - tableView.bounds.height * 0.5), animated: true)
        }else{
        
            tableView.setContentOffset(CGPoint(x: 0, y: (tableView.contentSize.height + cell.bounds.height - tableView.bounds.size.height )), animated: true)
        }
    }
}

//MARK: 代理方法 ->
extension SingleGiftViewController:UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 18
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: singleGiftColumnIndentifier, for: indexPath) as! SingleGiftColumnCell
        cell.viewModel = SingleGiftColumnCellViewModel(withModel: SingleGiftColumnCellDataModel(withIndex: indexPath.row))
        
        cell.selectedCell(select: selectedColumnRow == indexPath.row ? true: false)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        isSelectedColumn = true
        selectedColumnRow = indexPath.row
        tableView.reloadData()
        
        //: 滚动居中
        tableViewScrollToAt(indexPath:indexPath)
        
        collectionView.scrollToItem(at: IndexPath(item: 0, section: indexPath.row), at: .top, animated: true)
    }
}

extension SingleGiftViewController:UICollectionViewDelegate,UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 18
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: singleGiftIndentifier, for: indexPath) as!SingleGiftCell
        
        cell.viewModel = SingleGiftCellViewModel(withModel: SingleGiftCellDataModel())
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: singleGiftSectionIndentifier, for: indexPath) as! SingleGiftSectionView
        cell.viewModel = SingleGiftSectionViewModel(withModel: SingleGiftSectionDataModel(withIndex: indexPath.section))
        
        updateTableViewWhenScrollCollectionView()
        
        return cell
    }
    
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isSelectedColumn = !scrollView.isKind(of: UICollectionView.self)
        updateTableViewWhenScrollCollectionView()
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        updateTableViewWhenScrollCollectionView()
    }
    
    func updateTableViewWhenScrollCollectionView() {
        guard let currentIndexPath = collectionView.indexPathsForVisibleItems.last else {
            return
        }

        
        if !isSelectedColumn && selectedColumnRow != currentIndexPath.section {
            selectedColumnRow = currentIndexPath.section
            tableView.reloadData()
            //: 滚动居中
            tableViewScrollToAt(indexPath:IndexPath(row: currentIndexPath.section, section: 0))
        }
        
       
    }
    
}


class SingleGiftViewFlowLayout:UICollectionViewFlowLayout{
    override func prepare() {
        super.prepare()
        minimumLineSpacing = margin
        minimumInteritemSpacing = margin * 0.5
        
        let width = (collectionView!.bounds.width - (margin * CGFloat(cellColumns + 1))) / CGFloat(cellColumns)
        let height = width / cellScale
        itemSize = CGSize(width: width, height: height)
        sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        headerReferenceSize = CGSize(width: ScreenWidth, height: 44)
        scrollDirection = .vertical
    }
}
