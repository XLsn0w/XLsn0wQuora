//
//  WRCycleScrollView.swift
//  WRCycleScrollViewDemo
//
//  Created by wangrui on 2017/5/12.
//  Copyright © 2017年 wangrui. All rights reserved.
//
//  Github地址：https://github.com/wangrui460/WRCycleScrollView

import UIKit

enum ImagesType:Int {
    case SERVER = 0
    case LOCAL = 1
}

@objc protocol WRCycleScrollViewDelegate
{
    /// 点击图片回调
    @objc optional func cycleScrollViewDidSelect(at index:Int, cycleScrollView:WRCycleScrollView)
    /// 图片滚动回调
    @objc optional func cycleScrollViewDidScroll(to index:Int, cycleScrollView:WRCycleScrollView)
}

class WRCycleScrollView: UIView
{
    ///////////////////////////////////////////////////////
    // 对外提供的属性
    weak var delegate:WRCycleScrollViewDelegate?
    
    var imgsType:ImagesType = .SERVER     // default SERVER
    var localImgArray :[String]?
    var serverImgArray:[String]?
    var descTextArray :[String]?
    
    override var frame: CGRect {
        didSet {
            flowLayout?.itemSize = frame.size
            collectionView?.frame = bounds
        }
    }
    
    var descLabelFont: UIFont?
    var descLabelTextColor: UIColor?
    var descLabelHeight: CGFloat?
    var descLabelTextAlignment:NSTextAlignment?
    var bottomViewBackgroundColor: UIColor?
    
    // 如果自动轮播，表示轮播间隔时间 default = 1.5s
    var autoScrollInterval: Double = 1.5
    var isEndlessScroll:Bool = true
    var isAutoScroll:Bool = true {
        didSet {
            timer?.invalidate()
            timer = nil
            if isAutoScroll == true {
                setupTimer()
            }
        }
    }
    var showPageControl: Bool = true {
        didSet {
//            self.pageControl?.isHidden = !showPageControl
            setupPageControl()
        }
    }
    var currentDotColor: UIColor = UIColor.orange {
        didSet {
            self.pageControl?.currentPageIndicatorTintColor = currentDotColor
        }
    }
    var otherDotColor: UIColor = UIColor.gray {
        didSet {
            self.pageControl?.pageIndicatorTintColor = otherDotColor
        }
    }
    
    ///////////////////////////////////////////////////////
    // 对外提供的方法
    func reloadData() {
        timer?.invalidate()
        timer = nil
        collectionView?.reloadData()
        changeToFirstCycleCell(animated: false)
        setupPageControl()
        if isAutoScroll == true {
            setupTimer()
        }
    }
    
    
    ///////////////////////////////////////////////////////
    // 内部属性
    fileprivate var flowLayout:UICollectionViewFlowLayout?
    fileprivate var collectionView:UICollectionView?
    fileprivate let CellID = "WRCycleCell"
    // 标识子控件是否布局完成，布局完成后在layoutSubviews方法中就不执行 changeToFirstCycleCell 方法
    fileprivate var isLoadOver = false
    fileprivate var pageControl:UIPageControl?
    fileprivate var timer:Timer?
    fileprivate var imgsCount:Int {
        if imgsType == .LOCAL {
            guard let local = localImgArray else {
                return 0
            }
            return local.count
        }
        else {
            guard let server = serverImgArray else {
                return 0
            }
            return server.count
        }
    }
    fileprivate var realItemCount:Int {
        if imgsType == .LOCAL {
            guard let local = localImgArray else {
                return 0
            }
            return (isEndlessScroll == true) ? local.count * 128 : local.count
        }
        else {
            guard let server = serverImgArray else {
                return 0
            }
            return (isEndlessScroll == true) ? server.count * 128 : server.count
        }
    }
    
    /// 构造方法
    ///
    /// - Parameters:
    ///   - frame: frame
    ///   - type:  ImagesType                         default:Server
    ///   - imgs:  localImgArray / serverImgArray     default:nil
    ///   - descs: descTextArray                      default:nil
    init(frame: CGRect, type:ImagesType = .SERVER, imgs:[String]? = nil, descs:[String]? = nil)
    {
        super.init(frame: frame)
        imgsType = type
        if imgsType == .SERVER {
            if let server = imgs {
                serverImgArray = server
            }
        }
        else {
            if let local = imgs {
                localImgArray = local
            }
        }
        
        if let descTexts = descs {
            descTextArray = descTexts
        }
        setupCollectionView()
        setupPageControl()
        if isAutoScroll == true {
            setupTimer()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("WRCycleScrollView  deinit")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 解决WRCycleCell自动偏移问题
        collectionView?.contentInset = .zero
        if isLoadOver == false {
            changeToFirstCycleCell(animated: false)
        }
        if showPageControl == true {
            let pageW = bounds.width
            let pageH:CGFloat = 20
            let pageX = bounds.origin.x
            let pageY = bounds.height -  pageH
            self.pageControl?.frame = CGRect(x:pageX, y:pageY, width:pageW, height:pageH)
        }
    }
    
    // 解决定时器导致的循环引用
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        // 展现的时候newSuper不为nil，离开的时候newSuper为nil
        guard let _ = newSuperview else {
            timer?.invalidate()
            timer = nil
            return
        }
    }
}


// MARK: - 无限轮播相关
extension WRCycleScrollView
{
    func setupTimer()
    {
        timer = Timer(timeInterval: autoScrollInterval, target: self, selector: #selector(changeCycleCell), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .commonModes)
    }
    
    fileprivate func changeToFirstCycleCell(animated:Bool)
    {
        guard realItemCount  != 0 ,
            let collection = collectionView,
            let _ = flowLayout else {
                return
        }
        let firstItem = (isEndlessScroll == true) ? (realItemCount / 2) : 0
        let indexPath = IndexPath(item: firstItem, section: 0)
        collection.scrollToItem(at: indexPath, at: .init(rawValue: 0), animated: animated)
    }
    
    // 执行这个方法的前提是 isAutoScroll = true
    func changeCycleCell()
    {
        guard realItemCount  != 0 ,
            let collection = collectionView,
            let layout = flowLayout else {
                return
        }
        let curItem = Int(collection.contentOffset.x / layout.itemSize.width)
        if curItem == realItemCount - 1
        {
            let animated = (isEndlessScroll == true) ? false : true
            changeToFirstCycleCell(animated: animated)
        }
        else
        {
            let indexPath = IndexPath(item: curItem + 1, section: 0)
            collection.scrollToItem(at: indexPath, at: .init(rawValue: 0), animated: true)
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timer?.invalidate()
        timer = nil
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if isAutoScroll == true {
            setupTimer()
        }
        guard realItemCount  != 0 ,
            let collection = collectionView,
            let layout = flowLayout else {
                return
        }
        let curItem = Int(collection.contentOffset.x / layout.itemSize.width)
        let indexOnPageControl = (curItem % imgsCount + 1 == imgsCount) ? 0 : curItem % imgsCount + 1
        delegate?.cycleScrollViewDidScroll?(to: indexOnPageControl, cycleScrollView: self)
        pageControl?.currentPage = indexOnPageControl
    }
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView)
    {
        guard realItemCount  != 0 ,
            let collection = collectionView,
            let layout = flowLayout else {
                return
        }
        let curItem = Int(collection.contentOffset.x / layout.itemSize.width)
        let firstItem = (isEndlessScroll == true) ? (realItemCount / 2) : 0
        if curItem >= firstItem {
            isLoadOver = true
        }
        let indexOnPageControl = curItem % imgsCount
        delegate?.cycleScrollViewDidScroll?(to: indexOnPageControl, cycleScrollView: self)
        pageControl?.currentPage = indexOnPageControl
    }
}


// MARK: - pageControl页面
extension WRCycleScrollView
{
    fileprivate func setupPageControl()
    {
        pageControl?.removeFromSuperview()
        if showPageControl == true
        {
            pageControl = UIPageControl()
            pageControl?.numberOfPages = imgsCount
            pageControl?.hidesForSinglePage = true
            pageControl?.currentPageIndicatorTintColor = self.currentDotColor
            pageControl?.pageIndicatorTintColor = self.otherDotColor
            pageControl?.isUserInteractionEnabled = false
            addSubview(pageControl!)
        }
    }
}


// MARK: - WRCycleCell 相关
extension WRCycleScrollView: UICollectionViewDelegate,UICollectionViewDataSource
{
    fileprivate func setupCollectionView()
    {
        flowLayout = UICollectionViewFlowLayout()
        flowLayout?.itemSize = frame.size
        flowLayout?.minimumLineSpacing = 0
        flowLayout?.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: flowLayout!)
        collectionView?.register(WRCycleCell.self, forCellWithReuseIdentifier: CellID)
        collectionView?.isPagingEnabled = true
        collectionView?.bounces = false
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.delegate = self
        collectionView?.dataSource = self
        addSubview(collectionView!)
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return realItemCount
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let curItem = indexPath.item
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID, for: indexPath) as! WRCycleCell
        let imgsCount:Int!
        if imgsType == .SERVER {
            imgsCount = serverImgArray?.count
            cell.serverImgPath = serverImgArray?[curItem % imgsCount]
        } else {
            imgsCount = localImgArray?.count
            cell.localImgPath = localImgArray?[curItem % imgsCount]
        }
        cell.descText = descTextArray?[curItem % imgsCount]
        
        if let _ = descTextArray
        {
            cell.descLabelFont = (descLabelFont == nil) ? cell.descLabelFont : descLabelFont!
            cell.descLabelTextColor = (descLabelTextColor == nil) ? cell.descLabelTextColor : descLabelTextColor!
            cell.descLabelHeight = (descLabelHeight == nil) ? cell.descLabelHeight : descLabelHeight!
            cell.descLabelTextAlignment = (descLabelTextAlignment == nil) ? cell.descLabelTextAlignment : descLabelTextAlignment!
            cell.bottomViewBackgroundColor = (bottomViewBackgroundColor == nil) ? cell.bottomViewBackgroundColor : bottomViewBackgroundColor!
        }
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let indexOnPageControll = indexPath.item % imgsCount
        delegate?.cycleScrollViewDidSelect?(at: indexOnPageControll, cycleScrollView: self)
    }
}


