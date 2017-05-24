//
//  LZBCollectionLayout.swift
//  LZBPageCustomView
//
//  Created by zibin on 2017/5/19.
//  Copyright © 2017年 Apple. All rights reserved.
//

import UIKit

class LZBCollectionLayout: UICollectionViewFlowLayout {
    
    //外界设置属性
    var cols : Int = 4   //默认为4列
    var rows : Int = 2   //默认为2行

    fileprivate lazy var attributes : [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    fileprivate lazy var maxConentSizeWidth : CGFloat = 0
}


//自定义布局
extension LZBCollectionLayout{
    
    //1.准备cell的frame
    override func prepare() {
        super.prepare()
        
        //1.1校验colletionView不为nil
        guard let collectionView = collectionView else {
            return
        }
        //1.2获取collection的组数
        let  sections = collectionView.numberOfSections
        
        let cellWidth = (collectionView.bounds.width - sectionInset.left -  sectionInset.right - CGFloat(cols - 1) * self.minimumInteritemSpacing)/CGFloat(cols)
        let cellHeight = (collectionView.bounds.height - sectionInset.top - sectionInset.bottom - CGFloat(rows - 1) * self.minimumInteritemSpacing)/CGFloat(rows)

        
        
        var  preNumberOfPage = 0
        for section in 0..<sections{
        
            //1.3每一组的行数
            let items = collectionView.numberOfItems(inSection: section)
            
            for item in 0..<items{
               
                //1.4获取某一cell的indexPath
                let indexPath = IndexPath(item: item, section: section)
                let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                
                //1.5设置frame
                let attributeW = cellWidth
                let attributeH = cellHeight
                
                let currentPage = item / (cols * rows) //计算当前页是第几页
                let currentIndex = item % (cols * rows)  //当前页的第几个
                
                let attributeX =  sectionInset.left + CGFloat((preNumberOfPage + currentPage)) * collectionView.bounds.width + CGFloat(currentIndex % cols) * (attributeW + self.minimumInteritemSpacing)
                let attributeY =  sectionInset.top + (attributeH + self.minimumLineSpacing) * CGFloat(currentIndex / cols)
                
                attribute.frame = CGRect(x: attributeX, y: attributeY, width: attributeW, height: attributeH)
                attributes.append(attribute)
            }
            
            preNumberOfPage += (items - 1)/(cols * rows) + 1
            
        }
        
        maxConentSizeWidth = CGFloat(preNumberOfPage) * collectionView.bounds.width
    }
    
    
    //2、返回准备好的数组
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributes
    }
    
    
    
    //3、返回contensize
    override var collectionViewContentSize: CGSize{
         return CGSize(width: maxConentSizeWidth, height: 0)
    }
}
