//
//  RecordVoiceView.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/5/2.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SnapKit
import QorumLogs

public enum RecordingStatus : Int {
    
    case recording    //: 录制
    
    case willCancel   //: 取消录制
    
    case tooShort     //: 录制时间过短
    
}

fileprivate let tipCancelTitle = "手指松开，取消发送"
fileprivate let tipRecordTooShortTitle = "说话时间太短"
fileprivate let tipRecordingTitle = "手指上滑，取消发送"
fileprivate let tipLabelTextColor = UIColor(red: 253.0/255, green: 162.0/255.0, blue: 163.0/255.0, alpha: 1.0)

class RecordVoiceView: UIView {

//MARK: 属性
    var volume:CGFloat = 0 {
        didSet{
            QL2("volume:\(volume)")
            
            var index  = volume*1000/50 + 1
            if index > 20 {
                index = 20
            }
            QL2("index:\(index)")
            
            imageView.image = UIImage(named: String(format: "VoiceSearchFeedback%03d", Int(index)))
        }
    }
    var recordingStatus:RecordingStatus? {
        didSet{
            if recordingStatus == .willCancel{
                tipLabel.text = tipCancelTitle
            }
            else if recordingStatus == .tooShort {
                tipLabel.text = tipRecordTooShortTitle
            }
            else {
                tipLabel.text = tipRecordingTitle
            }
            
        }
    }
//MARK: 懒加载
    lazy var imageView:UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "VoiceSearchFeedback001")
        return image
    }()
    lazy var tipLabel:UILabel = {
        let label = UILabel()
        label.font = fontSize14
        label.textColor = UIColor.white
        label.textAlignment = .center
        return label
    }()
//MARK: 构造方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupRecordVoiceView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//MARK: 私有方法
    private func setupRecordVoiceView() {
        addSubview(imageView)
        addSubview(tipLabel)
        
        recordingStatus = .recording
        
        setupRecordVoiceViewSubView()
    }
    
    private func setupRecordVoiceViewSubView() {
        imageView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(self.snp.width)
            make.bottom.equalTo(tipLabel.snp.top)
        }
        
        tipLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(imageView)
            make.bottom.equalToSuperview()
        }
    }
}
