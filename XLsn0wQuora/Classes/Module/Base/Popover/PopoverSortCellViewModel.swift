//
//  PopoverSortCellViewModel.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/24.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit

class PopoverSortCellViewModel: NSObject {

    var titleLabelText:String?
    var buttonImage:UIImage?
    var isSelected:Bool = false
    
    
    init(withText text:String,isSelected selected:Bool) {
        titleLabelText = text
        buttonImage = #imageLiteral(resourceName: "icon_giftlist_checked")
        isSelected = selected
    }
}
