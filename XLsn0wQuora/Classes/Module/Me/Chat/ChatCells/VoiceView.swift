//
//  VoiceView.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/5/2.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit

class VoiceView: UIImageView {
    
//MARK: 属性
    var viewLocation:layoutLocation? {
        didSet{
            
            if viewLocation == .right {
                images = [#imageLiteral(resourceName: "message_voice_sender_playing_1"),#imageLiteral(resourceName: "message_voice_sender_playing_2"),#imageLiteral(resourceName: "message_voice_sender_playing_3")]
                normalImage = #imageLiteral(resourceName: "message_voice_sender_normal")
            }
            else{
                images = [#imageLiteral(resourceName: "message_voice_receiver_playing_1"),#imageLiteral(resourceName: "message_voice_receiver_playing_2"),#imageLiteral(resourceName: "message_voice_receiver_playing_3")]
                normalImage = #imageLiteral(resourceName: "message_voice_receiver_normal")
            }
            
            image = normalImage
        }
    }
    
    var normalImage:UIImage?
    var images:NSArray?
//MARK: 懒加载
    
//MARK: 构造方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupVoiceView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//MARK: 私有方法
    private func setupVoiceView() {
        viewLocation = .right
    }
//MARK: 外部接口
    func startPlaying() {
        guard let imagesArray = images as! [UIImage]? else {
            return
        }
        
        animationImages = imagesArray
        animationRepeatCount = 0
        animationDuration = 1.0
        startAnimating()
    }
    
    func stopPlaying() {
        stopAnimating()
    }
}
