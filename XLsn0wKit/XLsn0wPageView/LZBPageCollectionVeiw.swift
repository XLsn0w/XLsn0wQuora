

import UIKit
//数据源方法
protocol  LZBPageCollectionVeiwDataSoure : class {

      //获取多少组
      func numberOfSections(in pageCollectionVeiw: LZBPageCollectionVeiw) -> Int
    
      //每一组有多少个
      func pageCollectionVeiw(_ pageCollectionVeiw: LZBPageCollectionVeiw, numberOfItemsInSection section: Int) -> Int
    
      //每个cell样式
     func pageCollectionVeiw(_ pageCollectionVeiw: LZBPageCollectionVeiw, _ collectionView : UICollectionView,cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    
}

class LZBPageCollectionVeiw: UIView {

    weak var dataSoure : LZBPageCollectionVeiwDataSoure?
    
    
    fileprivate var titles : [String]
    fileprivate var style : LZBPageStyleModel
    fileprivate var layout : LZBCollectionLayout
    fileprivate var currenIndexPath : IndexPath = IndexPath(item: 0, section: 0)
    
    fileprivate lazy var titleView : LZBTitleView = {
        let titleViewY = self.style.isTitleViewInTop ? 0 : self.bounds.height -  self.style.titleViewHeight
        let titleViewFrame = CGRect(x: 0, y: titleViewY, width: self.bounds.width, height: self.style.titleViewHeight)
        let titleView = LZBTitleView(frame: titleViewFrame, titles: self.titles, style: self.style)
         titleView.backgroundColor = UIColor.getRandomColor()
        titleView.delegate = self
        return titleView
    }()
    
    fileprivate lazy var collectionView : UICollectionView = {
        
        let collectionViewY = self.style.isTitleViewInTop ? self.style.titleViewHeight : 0
        let collectionViewFrame = CGRect(x: 0, y: collectionViewY, width: self.bounds.width, height: self.bounds.height - self.style.titleViewHeight - self.style.pageControlHeight)
        let collectionView = UICollectionView(frame: collectionViewFrame, collectionViewLayout: self.layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.getRandomColor()
        return collectionView
    
    }()
    
    fileprivate lazy var pageControl : UIPageControl = {

        let pageControlY = self.collectionView.frame.maxY
        let pageControlFrame = CGRect(x: 0, y: pageControlY, width: self.bounds.width, height: self.style.pageControlHeight)
        let pageControl = UIPageControl(frame: pageControlFrame)
        pageControl.numberOfPages = 4
        pageControl.backgroundColor = UIColor.getRandomColor()
        return pageControl
    }()
   
    init(frame: CGRect, titles: [String], style : LZBPageStyleModel, layout : LZBCollectionLayout) {
         self.titles = titles
         self.style = style
         self.layout = layout
         super.init(frame: frame)
         self.setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension LZBPageCollectionVeiw{

    func setupUI(){
        //1.增加titleView
        addSubview(self.titleView)
        
        //2.collectionView
        addSubview(self.collectionView)
        
        //3.增加pageControl
       addSubview(self.pageControl)
       
    }

}

//注册cell
extension LZBPageCollectionVeiw {
    
    func register(_ cellClass: UICollectionViewCell.Type, forCellWithReuseIdentifier identifier: String){
        collectionView.register(cellClass, forCellWithReuseIdentifier: identifier)
    }
    
    func registerNib(_ nib: UINib?, forCellWithReuseIdentifier identifier: String){
          collectionView.register(nib, forCellWithReuseIdentifier: identifier)
    }
    
    func reloadData(){
      collectionView.reloadData()
    }
    
}

//MARK:- common 方法
extension LZBPageCollectionVeiw {
    
    func getNumberOfSections() -> Int{
        return dataSoure?.numberOfSections(in: self) ?? 0
    }
    
    func getItemsSection(_ section : Int) -> Int{
        return dataSoure?.pageCollectionVeiw(self, numberOfItemsInSection: section) ?? 0
    }
  

    func getNumberOfPageInSection(_ section : Int) -> Int{
        let sectionItems = getItemsSection(section)
        
        //3.1 改变pagecontrol的值,计算每一组有多少页
        let sectionNumberofPage = (sectionItems - 1)/(layout.cols * layout.rows) + 1
        
        return sectionNumberofPage
    }
    
}
//MARK:- UICollectionViewDataSource
extension LZBPageCollectionVeiw : UICollectionViewDataSource {
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSoure?.numberOfSections(in: self) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let items = dataSoure?.pageCollectionVeiw(self, numberOfItemsInSection: section) ?? 0
        if section == 0{
           self.pageControl.numberOfPages = getNumberOfPageInSection(section)
        }
        return  items
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return  (dataSoure?.pageCollectionVeiw(self, collectionView, cellForItemAt: indexPath))!
    }
}

//MARK:- UICollectionViewDelegate
extension LZBPageCollectionVeiw : UICollectionViewDelegate{

    //点击的时候结束滚动
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollDidEnd()
    }
    
     //拖拽的时候结束滚动
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate{
        scrollDidEnd()
        }
    }
    
    //结束滚动
    func scrollDidEnd(){
     //1.获取到滚动的indexPath,不是使用在屏幕上的cell,因为有时候不准确,所以可以获取每一组的第一个cell的位置
        let point = CGPoint(x: self.layout.sectionInset.left + 1 + self.collectionView.contentOffset.x, y: self.layout.sectionInset.top + 1)
        
        guard let indexPath = collectionView.indexPathForItem(at: point) else {return}
       
        
     //2.判断组是否有变化
      if indexPath.section != currenIndexPath.section{
        
        //2.1改变了组，切换页面总个数
         self.pageControl.numberOfPages = getNumberOfPageInSection(indexPath.section)
        
        //2.2改变titleView选中状态
        self.titleView.setCurrentIndex(indexPath.section)
        
        //2.3获取最新的组
         currenIndexPath = indexPath
      }
      
      //3.改变当前页的选中
      self.pageControl.currentPage = indexPath.item / (layout.cols * layout.rows)
        
        
    }
 
}

//MARK:- LZBTitleViewDelegate
extension LZBPageCollectionVeiw : LZBTitleViewDelegate{
    func titleView(_ titleView: LZBTitleView, targetIndex: NSInteger) {
        
        //1.获取点击那个组
        let indexPath = IndexPath(item: 0, section: targetIndex)
        
        //2.滚动到选中的组，bug：直接滚动到左边
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
       
        //3.获取当前的indexPath 
        currenIndexPath = indexPath
        
        //4.调整正确的位置,bug最后一组不对
        let sections = getNumberOfSections()
        let sectionItems = getItemsSection(targetIndex)
        
        //4.1 改变pagecontrol的值,计算每一组有多少页
        let sectionNumberofPage = getNumberOfPageInSection(targetIndex)
        self.pageControl.numberOfPages = sectionNumberofPage
        
        //4.2如果是最后一组。并且最后一组的个数小于计划排列的个数
        if targetIndex == sections - 1 && sectionItems <= layout.cols * layout.rows{
            return
        }
        collectionView.contentOffset.x -= layout.sectionInset.left
        
    }
}
