//
//  ViewController.swift
//  XLsn0wQuora
//
//  Created by XLsn0w on 2017/5/23.
//  Copyright © 2017年 XLsn0w. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        
//        XLsn0wNetwork.request(.get, URLString:"http://192.168.0.218:8085/CityPark/upgrade/upgradeBundle", parameters: ["versionCode":1, "platform":2]) { (JSON) in
//            //JSON即服务器返回的JSON
//            print("\(JSON)")
//        }
        
        
        
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
        Toast(text: "Basic Toast").show()
        Toast(text: "You can set duration. `Delay.short` means 2 seconds.\n" +
            "`Delay.long` means 3.5 seconds.",
              duration: Delay.long).show()
        Toast(text: "With delay, Toaster will be shown after delay.", delay: 1, duration: 5).show()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

