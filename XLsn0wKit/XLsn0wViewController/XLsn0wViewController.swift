//
//  XLsn0wViewController.swift
//  XLsn0wQuora
//
//  Created by XLsn0w on 2017/5/24.
//  Copyright © 2017年 XLsn0w. All rights reserved.
//

import UIKit

class XLsn0wViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
    }
    
    lazy var dataArray = { return [AnyObject]() }()

    
    deinit {//在Swift中, 有一个类似dealloc方法, 就是deinit, deinit是在实例不再引用的自动调用, 并且不用手动去管理引用计数
        NSLog("\(self.classForCoder)已释放")
    }
    
    
    open func jk_pushViewController(viewController: UIViewController) -> Void {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    open func jk_popViewController(animated: Bool) -> Void {
        _ = self.navigationController?.popViewController(animated: animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
