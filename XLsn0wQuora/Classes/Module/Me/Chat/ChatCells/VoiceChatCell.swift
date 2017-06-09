//
//  VoiceChatCell.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/28.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SnapKit

class VoiceChatCell: BaseChatCell {

//MARK: 属性
    weak var delegate:VoiceChatCellDelegate?
    
    var viewModel:VoiceChatCellViewModel?{
        didSet{
            
            super.baseViewModel = viewModel
            
            backView.image = viewModel?.voicebackImage
            backView.highlightedImage = viewModel?.voicebackHightLightImage
    
            voiceTimeLabel.text = viewModel?.voiceTimeLabelText
            voiceTimeLabel.font = viewModel?.voiceTimeLabelFont
            
            guard let viewFrame = viewModel?.viewFrame else {
                return
            }
            layoutVoiceChatCell(viewFrame)
        }
    }
    private var isRecordigAnimation:Bool = false
    private var isPlayingAnimation:Bool = false
    private var backViewAlpha:CGFloat = 1.0
//MARK: 懒加载
    lazy var voiceImage:VoiceView = { () -> VoiceView in
       let image = VoiceView(frame: CGRect.zero)
        image.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(voiceImageViewDidTap))
        image.addGestureRecognizer(tap)
        return image
    }()
    lazy var voiceTimeLabel:UILabel = { () -> UILabel in
        let label = UILabel()
        label.textColor = UIColor.gray
        return label
    }()
//MARK: 构造方法
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupVoiceChatCell()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//MARK: 私有方法
    private func setupVoiceChatCell() {
        addSubview(voiceImage)
        addSubview(voiceTimeLabel)
    }
    
    private func layoutVoiceChatCell(_ viewFrame:ViewFrame) {
        voiceImage.viewLocation = self.viewModel?.viewLocation
        
        if self.viewModel?.viewLocation == .right {
            voiceTimeLabel.snp.remakeConstraints({ (make) in
                make.centerY.equalTo(backView.snp.centerY)
                make.right.equalTo(voiceImage.snp.left).offset(-margin)
            })
            
            voiceImage.snp.remakeConstraints({ (make) in
                make.right.equalTo(backView).offset(-margin*2.0)
                make.width.height.equalTo(20)
            })
            
            backView.snp.remakeConstraints { (make) in
                make.left.equalTo(voiceTimeLabel).offset(-margin*2.0)
                make.bottom.equalTo(voiceImage).offset(margin*2.0)
                
                make.right.equalTo(avatarButton.snp.left).offset(-margin*0.5)
                make.top.equalTo(nameLabel.snp.bottom).offset(-margin*0.1)
            }
        }
        else {
            voiceTimeLabel.snp.remakeConstraints({ (make) in
                make.left.equalTo(voiceImage.snp.right).offset(margin)
                make.centerY.equalTo(backView.snp.centerY)
            })
            
            voiceImage.snp.remakeConstraints({ (make) in
                make.left.equalTo(backView).offset(margin*2.0)
                make.width.height.equalTo(20)
            })
            
            backView.snp.remakeConstraints { (make) in
                make.right.equalTo(voiceTimeLabel).offset(margin*2.0)
                make.bottom.equalTo(voiceImage).offset(margin*2.0)
                
                make.top.equalTo(nameLabel.snp.bottom).offset(-margin*0.1)
                make.left.equalTo(avatarButton.snp.right).offset(margin*0.5)
            }
        }
        
       
        
        if viewModel?.voiceStatus == .recording {
            voiceTimeLabel.isHidden = true
            voiceImage.isHidden = true
            startRecordingAnimation()
        }
        else{
            voiceTimeLabel.isHidden = false
            voiceImage.isHidden = false
            stopRecordingAnimation()
        }
        
        
        if viewModel?.voiceStatus == .playing {
            voiceImage.startPlaying()
        }
        else {
            voiceImage.stopPlaying()
        }
        
    }
    
    private func startRecordingAnimation() {
        isRecordigAnimation = true
        backViewAlpha = 0.4
        
        recordingAnimation()
    }
    
    private func stopRecordingAnimation() {
        isRecordigAnimation = false
        backViewAlpha = 1.0
        
        backView.alpha = backViewAlpha
    }
    
    private func recordingAnimation() {
        UIView.animate(withDuration: 1.0, animations: {
            self.backView.alpha = self.backViewAlpha
        }) { (finished) in
            self.backViewAlpha = self.backViewAlpha > 0.9 ? 0.4:1.0
            if finished && self.isRecordigAnimation {
                self.recordingAnimation()
            }
            else{
                self.backView.alpha = 1.0
            }
        }
    }
    
    private func voicePlayingAnimation() {
        if isPlayingAnimation {
            voiceImage.startPlaying()
        }
        else{
            voiceImage.stopPlaying()
        }
        

    }
    
//MARK: 内部响应
    @objc private func voiceImageViewDidTap() {
        isPlayingAnimation = !isPlayingAnimation
        
        //: 播放
        voicePlayingAnimation()
    
        
        delegate?.didTapVoiceChatCell(cell: self ,isStart: isPlayingAnimation)         
    }
 
}

//MARK: 协议
protocol VoiceChatCellDelegate:NSObjectProtocol {
    func didTapVoiceChatCell(cell:VoiceChatCell, isStart:Bool)
}
