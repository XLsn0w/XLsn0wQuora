//
//  ViewController.swift
//  XLsn0wQuora
//
//  Created by XLsn0w on 2017/5/23.
//  Copyright © 2017年 XLsn0w. All rights reserved.
//

import UIKit


private let kPageCollectionVeiwCellID = "kPageCollectionVeiwCellID"

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
/**************************************************************************************************/
//        self.addCollectionUI();
        self.addButtonUI();
        
//        self.view.backgroundColor = UIColor.black;
        

        
        XLsn0wLog(printObject: "xxxx");
    }
    
    func addCollectionUI() {
        //1.frame
        let frame = CGRect(x: 0, y: 100, width:view.bounds.width, height: 300)
        
        //2.标题
        let titles = ["提姆","火蓝","球女","发条"]
        
        //3.样式
        var model = LZBPageStyleModel()
        model.isShowBottomLine = true
        
        //4.布局
        let layout = LZBCollectionLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.scrollDirection = .horizontal
        layout.cols = 7
        layout.rows = 3
        
        let pageView  = LZBPageCollectionVeiw(frame: frame, titles: titles, style: model, layout: layout)
        pageView.dataSoure = self
        pageView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kPageCollectionVeiwCellID)
        
        self.view.addSubview(pageView)
        
    }

    
    
    func addButtonUI() {
        let button = UIButton(type: .system)
        button.setTitle("Show", for: .normal)
        button.sizeToFit()
        button.addTarget(self, action: #selector(self.showButtonTouchUpInside), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(button)
        self.view.addConstraints([
            NSLayoutConstraint(
                item: button,
                attribute: .top,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .top,
                multiplier: 1,
                constant: 60
            ),
            NSLayoutConstraint(
                item: button,
                attribute: .centerX,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .centerX,
                multiplier: 1,
                constant: 0
            )
            ])
        
        
        self.configureAppearance()
    }
    
    func configureAppearance() {
        let appearance = ToastView.appearance()
        appearance.backgroundColor = .lightGray
        appearance.textColor = .black
        appearance.font = .boldSystemFont(ofSize: 16)
        appearance.textInsets = UIEdgeInsets(top: 15, left: 20, bottom: 15, right: 20)
        appearance.bottomOffsetPortrait = 100
        appearance.cornerRadius = 20
    }
    
    dynamic func showButtonTouchUpInside() {
        XLsn0wToast(text: "Basic Toast").show()
        XLsn0wToast(text: " seconds.\n" + "`Delay.long` means 3.5 seconds.", duration: Delay.long).show()
        XLsn0wToast(text: "With delay, Toaster will be shown after delay.", delay: 1, duration: 5).show()
        
       
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}



extension ViewController :  LZBPageCollectionVeiwDataSoure {
    
    func numberOfSections(in pageCollectionVeiw: LZBPageCollectionVeiw) -> Int {
        return  4
    }
    
    func pageCollectionVeiw(_ pageCollectionVeiw: LZBPageCollectionVeiw, numberOfItemsInSection section: Int) -> Int {
        var count = 0
        switch section {
        case 0:
            count = 15
        case 1:
            count = 25
        case 2:
            count = 35
        case 3:
            count = 7
        default:
            count = 30
        }
        return count
    }
    
    func pageCollectionVeiw(_ pageCollectionVeiw: LZBPageCollectionVeiw, _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPageCollectionVeiwCellID, for: indexPath)
        cell.backgroundColor = UIColor.getRandomColor()
        return cell
    }
}



