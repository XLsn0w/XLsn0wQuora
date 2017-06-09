//
//  StrategyClassifyViewCellViewModel.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/21.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
class StrategyClassifyViewCellDataModel: NSObject {
    
}


class StrategyClassifyViewCellViewModel: NSObject {
    var dataModel:StrategyClassifyViewCellDataModel?
    var photoImage:UIImage?
    var titleLabelText:String?
    var detialLabelText:String?
    
    init(withModel model:StrategyClassifyViewCellDataModel) {
        self.dataModel = model
        photoImage = UIImage(named: "strategy_\(Int(arc4random() % 17) + 1).jpg")
        let title  = ["港真！送给男票的礼物也许潮流个性","女神信封包，请收下我的膝盖","嘘！别出声，这里是公主的城堡","送闺蜜就选卡通合作款，萌系少女的真爱"]
        let detial = ["有些女孩总会送男友礼物上很是伤神！她们不知道应该送些什么类型的礼物！而你们可以送一些个性饰品啊！在如今追求时尚和潮流的社会，男人的配饰早已不仅仅是手表那么简单！适当的佩戴首饰，一些个性的小饰品！可以增添男人魅力，搭配出时尚范！给男人的生活带去更多的色彩！"
                   ,"信封包的魅力真的是超级棒，时尚感爆棚，是各种明星大牌和秀场的宠儿，拿上信封包，立刻气质就不一样了，一秒变女神，没的说。真真的好看啊，尤其想要有改变的妹子，信封包是首选，气场的改变也会让你身边的人惊艳哦。所以亲爱的，和编编一起感受美吧。"
                   ,"衣服和化妆品大概是女人毕生追求的两样东西吧，当化妆品越来越多，桌面越来越乱，就会很烦躁。其实有了漂亮的化妆盒，化妆品、首饰都能在其中找到自己的位置，让清晨不再匆忙，让夜晚安然入睡。"
                   ,"现如今的彩妆护肤品牌，个个都像开了挂，不仅使用起来效果超赞，外观也是不肯甘于平凡，纷纷推出了与卡通品牌的合作款，颜值那叫一个高！姑娘们都是剁手也必须买的节奏，毕竟谁能扛得住卖萌的诱惑啊！"]
        let index = Int(arc4random() % 4)
        titleLabelText = title[index]
        detialLabelText =  detial[index]
    }
}
