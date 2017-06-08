//
//  UITableView+.swift
//  Timi
//
//  Created by 田子瑶 on 16/8/30.
//  Copyright © 2016年 田子瑶. All rights reserved.
//

import UIKit

extension UITableView {
    
    public func tableViewDisplayWithMsg(_ msg:String, ifNecessaryForRowCount rowCount:Int){
        if rowCount == 0 {
            let msgLabel = UILabel()
            msgLabel.text = msg
            msgLabel.font = UIFont(name: "", size: 14)
            msgLabel.textColor = UIColor.gray
            msgLabel.textAlignment = .center
            
            self.backgroundView = msgLabel
        }
        else{
            self.backgroundView = nil
        }
    }
    
}
