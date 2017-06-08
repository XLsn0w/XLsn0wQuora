//
//  ViewController.swift
//  XLsn0wQuora
//
//  Created by XLsn0w on 2017/5/23.
//  Copyright © 2017年 XLsn0w. All rights reserved.
//

import UIKit
import SnapKit

// 通过类别给对象拓展属性，使用Runtime绑定属性值
extension ViewController0 {
    
    // 平常写法【不推荐】
    //    var jkPro: String? {
    //        set {
    //            objc_setAssociatedObject(self, "key", newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
    //        }
    //
    //        get {
    //            return objc_getAssociatedObject(self, "key") as? String
    //        }
    //    }
    
    
    
    
    // 改进写法【推荐】
    
    struct RuntimeKey {
        static let jkKey = UnsafeRawPointer.init(bitPattern: "JKKey".hashValue)
        /// ...其他Key声明
    }
    
    var jkPro: String? {
        set {
            objc_setAssociatedObject(self, ViewController0.RuntimeKey.jkKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        
        get {
            return objc_getAssociatedObject(self, ViewController0.RuntimeKey.jkKey) as? String
        }
    }
}


private let kPageCollectionVeiwCellID = "kPageCollectionVeiwCellID"

class ViewController0: UIViewController, JKEmployerDelegate {
    
    var employer: JKEmployer?

    override func viewDidLoad() {
        super.viewDidLoad()
/**************************************************************************************************/
//        self.addCollectionUI();
        self.addButtonUI();
        
        self.employer = JKEmployer.init()
        self.employer?.delegate = self
        
//        self.view.backgroundColor = UIColor.black;
        

        
       
        
        XLsn0wLog(printObject: "xxxx");
        
        
        self.jkPro = "通过类别拓展的属性"
        NSLog(self.jkPro!)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "iTem", style: .plain, target: nil, action: nil)
        
        _ = UIColor.RGB("#ff21af64")
        _ = UIColor.RGB("#21af64")
        _ = UIColor.RGB("0x21af64")
        
        //        let text = "大黄金卡加的我回家看的黄金卡案件和卡号及大家很快哈哈啊环境的骄傲的健康大加快大家很快大家看大海阿卡丽几哈大家哈达"
        
        //        let rect = CGRect.init(x: self.view.midX - 100,
        //                               y: self.view.midY - 100,
        //                               width: 200, height: 200)
        //
        //        let frame = CGRect.init(x: self.view.midX - 100,
        //                                y: self.view.midY + 150,
        //                                width: 200, height: 50)
        
        //        let image = UIImage.image(withColor: UIColor.blue, size: CGSize.init(width: 300, height: 300))
        
        
        //        let image_R = image?.rounding()
        
        //        let image_R = UIImage.roundingImage(withColor: UIColor.blue, size: CGSize.init(width: 300, height: 300), radius: 80)
        
        //        let image_R = UIImage.roundingImage(withColor: UIColor.blue, size: CGSize.init(width: 300, height: 300), radius: 80, borderColor: UIColor.red, borderWidth: 10)
        
        //        let view = UIView.view(withFrame: rect, backgroundColor: UIColor.red)
        
        //        let view = UIImageView.imageView(withFrame: rect, image: image_R)
        
        //        let view = UILabel.label_WordWrap(withFrame: rect,
        //                                             text: text,
        //                                             font: UIFont.systemFont(ofSize: 18))
        
        //        let view = UIButton.button(withFrame: rect,
        //                                   title: "按钮",
        //                                   selectedText: nil,
        //                                   color: UIColor.red,
        //                                   target: self,
        //                                   action: #selector(touch))
        
        //        let view = UIButton.button(withFrame: rect,
        //                                   title: "按钮",
        //                                   selectedTitle: "选中",
        //                                   backgroundImage: UIImage.init(named: "im_message_error"),
        //                                   selectedBgImage: nil,
        //                                   target: self,
        //                                   action: #selector(touch))
        //        self.view.addSubview(view)
        
        
        //        let button = UIButton.button(withFrame: frame,
        //                                     title: "按钮",
        //                                     image: UIImage.image(named: "im_message_error"),
        //                                     titleColor: UIColor.blue,
        //                                     target: self, action: #selector(touch))
        
        //        let button = UIButton.button(withFrame: frame,
        //                                     image: UIImage.image(named: "im_message_error"),
        //                                     highlightImage: UIImage.image(named: "im_message_error"),
        //                                     target: self, action: #selector(touch))
        
        //        let button = UIButton.roundedButton(withFrame: frame,
        //                                            title: "圆角边框按钮",
        //                                            titleColor: UIColor.red,
        //                                            fillColor: UIColor.green,
        //                                            borderColor: UIColor.darkGray,
        //                                            borderRaduis: 10,
        //                                            target: self, action: #selector(touch))
        
        //        let button = UIButton.roundedButton(withFrame: frame,
        //                                            title: "圆角按钮",
        //                                            color: UIColor.red,
        //                                            highlightColor: UIColor.lightGray,
        //                                            radius: 25,
        //                                            target: self, action: #selector(touch))
        
        //        let button = UIButton.universalRoundedButton(withTitle: "通用型按钮",
        //                                                     originY: 300,
        //                                                     target: self, action: #selector(touch))
        //        self.view.addSubview(button)
    }
    

    
    func touch() {
       
        
        
    }
    
    // 必须实现的协议方法
    func jkDelegateFunc(str: String) {
        
        
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
        pageView.dataSoure = self as! LZBPageCollectionVeiwDataSoure
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


    let IBLayoutButton = UIButton()
    let codeNativeLayoutButton = UIButton()
    let snapKitLayoutButton = UIButton()
    
    
    func AutoLayout() {
        
        title = "AutoLayout"

        
        
        codeNativeLayoutButton.backgroundColor = UIColor.hexValue(0x40a0ff);
        codeNativeLayoutButton.setTitle("原生代码布局", for: .normal)
        codeNativeLayoutButton.setTitleColor(UIColor.hexValue(0xf8f8f8), for: .normal)
        codeNativeLayoutButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        codeNativeLayoutButton.layer.cornerRadius = 6
        codeNativeLayoutButton.layer.masksToBounds = true
        view.addSubview(codeNativeLayoutButton)
        codeNativeLayoutButton.snp.makeConstraints { (make) in
            make.trailing.equalTo(self.view.layoutMarginsGuide)
            make.top.equalTo(IBLayoutButton)
            make.leading.equalTo(IBLayoutButton.snp.trailing).offset(10)
            make.height.width.equalTo(IBLayoutButton)
        }
        codeNativeLayoutButton.addTarget(self, action: #selector(didClickCodeNativeLayoutButton(button:)), for: .touchUpInside)
        
        snapKitLayoutButton.backgroundColor = UIColor.hexValue(0xfd84ea);
        snapKitLayoutButton.setTitle("SnapKit代码布局", for: .normal)
        snapKitLayoutButton.setTitleColor(UIColor.hexValue(0xf8f8f8), for: .normal)
        snapKitLayoutButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        snapKitLayoutButton.layer.cornerRadius = 6
        snapKitLayoutButton.layer.masksToBounds = true
        view.addSubview(snapKitLayoutButton)
        snapKitLayoutButton.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(self.view.layoutMarginsGuide)
            make.top.equalTo(IBLayoutButton.snp.bottom).offset(10)
            make.bottom.equalTo(-10)
            make.height.equalTo(IBLayoutButton)
        }
        snapKitLayoutButton.addTarget(self, action: #selector(didSnapKitLayoutButton(button:)), for: .touchUpInside)
        
    }
    
    

    
    
    func didClickCodeNativeLayoutButton(button:UIButton) {
        navigationController?.pushViewController(CodeNativeLayoutViewController(), animated: true)
    }
    
    func didSnapKitLayoutButton(button:UIButton) {
        navigationController?.pushViewController(SnapKitLayoutViewController(), animated: true)
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



