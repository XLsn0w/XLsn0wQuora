//
//  Refresh.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/20.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import MJRefresh
import QorumLogs

class Refresh: MJRefreshGifHeader {

    override func prepare() {
        super.prepare()
        
        var idleImages = Array<UIImage>()
        var pullingImages = Array<UIImage>()
        var refreshingImages = Array<UIImage>()
        
        for i in 0...10 {
            
            idleImages.append(UIImage(named: String(format: "loading_dragdown_%02d", i))!.resetImageSize(newWidth: 100))
        }
        
        pullingImages.append(UIImage(named: "loading_00")!.resetImageSize(newWidth: 100))
        
        for i in 0...22 {
            refreshingImages.append(UIImage(named: String(format: "loading_%02d", i))!.resetImageSize(newWidth: 100))
        }
        
        lastUpdatedTimeLabel.isHidden = true
        stateLabel.isHidden = true
        setImages(idleImages, for: .idle)
        setImages(pullingImages, for: .pulling)
        setImages(refreshingImages, for: .refreshing)
    }
}
