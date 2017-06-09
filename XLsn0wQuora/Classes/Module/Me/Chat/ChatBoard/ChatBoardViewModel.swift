//
//  ChatBoardViewModel.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/5/3.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import QorumLogs

class ChatBoardViewModel: NSObject {

    var dataModel:ChatBoardDataModel?
//: 构造方法
    override init() {
        super.init()
    }
}

//: 代理方法 -> 让视图模型去处理界面上播放的业务逻辑
extension ChatBoardViewModel:VoiceChatCellDelegate {
    func didTapVoiceChatCell(cell:VoiceChatCell,isStart: Bool) {
        
        guard let id = cell.id else {
            return
        }
        
        guard let type = cell.type else {
            return
        }
        
        var index = 0
        var result = false
        
        dataModel?.indexForMsgModel(withID: id, withType: type, finshed: { (i, rel) in
            index = i
            result = rel
        })
        
        if isStart && result {
            
            let msg = dataModel!.msgModels[index] as! VoiceMessage
            
            guard let path = msg.path else {
                return
            }
            
            msg.status = .playing
            //: 先跟新一次数据源
            dataModel!.indexForMsgModel(msg, finshed: { [unowned self] (index, result) in
                if result {
                    self.dataModel!.msgModels.replaceObject(at: index, with: msg)
                }
            })
            
            QL2("\(path)")
        
           AudioPlayer.shared.playAudio(atPath: path) { [unowned self] (finished) in
                msg.status = .normal
                //: 更新界面
                cell.viewModel = VoiceChatCellViewModel(withVoiceMessage: msg)
            
                //: 跟新数据源
                self.dataModel!.indexForMsgModel(msg, finshed: { [unowned self] (index, result) in
                    if result {
                        self.dataModel!.msgModels.replaceObject(at: index, with: msg)
                    }
                })
            }
        
        }
        else{
            //: 停止播放
            AudioPlayer.shared.playAudioStop()
        }
    }
}
