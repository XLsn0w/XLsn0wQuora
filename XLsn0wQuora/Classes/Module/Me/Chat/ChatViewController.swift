//
//  ChatViewController.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/27.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SnapKit
import QorumLogs

fileprivate let chatBarHeight:CGFloat = 50.0

class ChatViewController: UIViewController {

    
//MARK: 懒加载
    var delegate:ChatViewControllerDelegate?
    //: 录音音量提示
    var voiceView:RecordVoiceView = RecordVoiceView()
    //: 工具条
    var chatBar:ChatBar = { () -> ChatBar in
        let bar = ChatBar()
        bar.viewModel = ChatBarViewModel()
        return bar
    }()
    //: 聊天板
    lazy var chatBoard:ChatBoardView = ChatBoardView(frame: CGRect.zero, style: .plain)
//MARK: 系统方法
    override func viewDidLoad() {
        super.viewDidLoad()

        setupChatView()
      
        setupChatViewSubView()
        
        var i = 0
        for _ in 0...5 {
            i += 1
            let msg = TextMessage()
             msg.text = "呵呵哒,来聊天,呵呵哒,来聊天,呵呵哒,来聊天,呵呵哒,来聊天,呵呵哒,来聊天,摸摸哒,傻逼最傲娇😄"
             msg.owner = .user
             msg.source = .myself
            
            addMessage(withMessageModel: msg)
            
            let msg0 = TextMessage()
            msg0.text = "做什么呀?摸摸哒,傻逼最傲娇😄"
            msg0.owner = .user
            msg0.source = .friends
            msg0.date = Date()
            let usr = UserModel()
            usr.avatarLoc = "me_avatar_boy"
            usr.nickname = "天不怕，地不怕"
            usr.uid = "6666666"
            msg0.fromUsr = usr
            
            addMessage(withMessageModel: msg0)
        }
        
        let msg1 = VoiceMessage()
        msg1.owner = .user
        msg1.source = .friends
        msg1.date = Date()
        let usr = UserModel()
        usr.avatarLoc = "me_avatar_boy"
        usr.nickname = "天不怕，地不怕"
        usr.uid = "6666666"
        msg1.fromUsr = usr
        msg1.status = .normal
        
        let path = Bundle.main.path(forResource: "贝加尔湖畔", ofType: "mp3")
        
        msg1.fileName = "贝加尔湖畔"
        msg1.path = path
        msg1.time = 45.0
        msg1.status = .normal
        
        addMessage(withMessageModel: msg1)
        
        
        let msg2 = VoiceMessage()
        msg2.owner = .user
        msg2.source = .friends
        msg2.date = Date()
        let usr1 = UserModel()
        usr1.avatarLoc = "me_avatar_boy"
        usr1.nickname = "天不怕，地不怕"
        usr1.uid = "6666666"
        msg2.fromUsr = usr1
        msg2.status = .normal
        
        let path1 = Bundle.main.path(forResource: "唐古 - 你懂不懂爱", ofType: "mp3")
        
        msg2.fileName = "唐古 - 你懂不懂爱"
        msg2.path = path1
        msg2.time = 120.0
        msg2.status = .normal
        
        addMessage(withMessageModel: msg2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        delegate?.chatViewControllerDidLoadSubViews(withChatBoard: chatBoard)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupChatViewWhenViewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        setupChatViewWhenViewWillDisappear()
    }
//MARK: 私有方法
    private func setupChatViewWhenViewWillAppear() {
        //: 键盘通知
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(notification:)), name:.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidAppear(notification:)), name: .UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(notification:)), name: .UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardFrameWillChange(notification:)), name: .UIKeyboardWillChangeFrame, object: nil)
        
    
    }
    
    private func setupChatViewWhenViewWillDisappear() {
        
        NotificationCenter.default.removeObserver(self)
        
    }
    
    private func setupChatView() {
        title = "客服"
        delegate = chatBoard
        chatBoard.boardDelegate = self
        chatBar.delegate = self
        view.addSubview(chatBoard)
        view.addSubview(chatBar)
        
    }
    
    private func setupChatViewSubView() {
        chatBoard.snp.makeConstraints { (make) in
           make.left.right.top.equalToSuperview()
           make.bottom.equalTo(chatBar.snp.top)
        }
        
        chatBar.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.greaterThanOrEqualTo(chatBarHeight)
        }
    }
//MARK: 内部处理
    @objc private func keyboardWillAppear(notification:Notification) {
        
    }
    
    @objc private func keyboardDidAppear(notification:Notification) {
        
    }
    
    @objc private func keyboardWillDisappear(notification:Notification) {

    }
    
    @objc private func keyboardFrameWillChange(notification:Notification) {
        guard let value = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] else {
            return
        }
        
        let frame = value as! CGRect
    
        QL2("\(frame.origin.y),\(frame.size.height),\(chatBoard.contentSize.height)")
        
        chatBar.snp.updateConstraints { (make) in
            make.bottom.equalToSuperview().offset(frame.origin.y - ScreenHeight)
        }
        
        view.layoutIfNeeded()
        
        chatBoard.scrollChatBoard(keyboardY: frame.origin.y, chatBarHeight: chatBar.bounds.height, false)
        
     
          //: 通过transform方式,由后台进入前台,transform 变成ident 导致bar出问题，不建议使用
//        UIView.animate(withDuration: 0.5) {
//            self.view.transform = CGAffineTransform(translationX: 0, y: frame.origin.y - ScreenHeight)
//        }
        
    }
//MARK: 开放接口
    //: 添加消息
    func addMessage(withMessageModel msg:MessageModel) {
        
        chatBoard.addMsgModel(MessageModel: msg)
        
    }
    
    //: 更新消息
    func updateMessage(withMessageModel msg:MessageModel) {
        
        chatBoard.updateMsgModel(MessageModel: msg)
    }
    
    //: 删除消息
    func deleteMessage(withMessageModel msg:MessageModel) {
        chatBoard.deleteMsgModel(MessageModel: msg, withAnimation: true)
    }
}

//: 代理方法
extension ChatViewController:ChatBoardViewDelegate {
    
    func chatboardViewDidTap() {
       _ = chatBar.resignFirstResponder()
    }
}

extension ChatViewController:ChatBarDelegate {
    func chatBarSendText(text: String) {
        addMessage(withMessageModel: TextMessage.userMessage(text: text))
    }
    
    //: 录音相关
    func chatBarStartRecording() {
        if AudioPlayer.shared.isPlaying {
            AudioPlayer.shared.playAudioStop()
        }
        
        //: 插入提示录音提示
        chatBoard.addSubview(voiceView)
        voiceView.snp.makeConstraints { (make) in
            make.center.equalTo(view)
            make.size.equalTo(CGSize(width: 150, height: 170))
        }
        
        let msg = VoiceMessage.userMessage(status: .recording)
        
        //: 开始录音
        var count = 0
        AudioRecorder.shared.startRecording(volumeChanged: { (volume) in
            count += 1
            if count == 2 {
                self.addMessage(withMessageModel: msg)
            }
            
            //: 设置录音音量
            self.voiceView.volume = volume
        }, complete: { (filePath, time) in
            if time < 1.0 {
                self.voiceView.recordingStatus = .tooShort
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0, execute: {
                     //: 删除消息
                     self.voiceView.removeFromSuperview()
                     self.deleteMessage(withMessageModel: msg)
                })
                
                return
            }
            
            self.voiceView.removeFromSuperview()
            QL2(filePath)
            
            if FileManager.default.fileExists(atPath: filePath) {
                //: .caf-> kAudioFormatAppleIMA4         .m4a -> kAudioFormatMPEG4AAC
                let fileName = String(format: "%.0lf.m4a", Date().timeIntervalSince1970*1000)
                let path = FileManager.userChatVoicePath(voiceName: fileName)
                
                do {
                    try FileManager.default.moveItem(atPath: filePath, toPath: path)
                }
                catch{
                    QL4("录音文件出错")
                    return
                }
                

                msg.fileName = fileName
                msg.path = path
                msg.time = time
                msg.status = .normal
                
                //: 录制完毕发送消息
                msg.status = .normal
                self.updateMessage(withMessageModel: msg)
                
            }
            
        }, cancel: {
            self.deleteMessage(withMessageModel: msg)
            self.voiceView.removeFromSuperview()
        })
        
    }
    
    func chatBarFinshedRecording() {
        AudioRecorder.shared.stopRecording()
    }
    
    func chatBarWillCancelRecording(cancel: Bool) {
        voiceView.recordingStatus = cancel ? .willCancel:.recording
    }
    
    func chatBarDidCancelRecording() {
        AudioRecorder.shared.cancelRecording()
    }
}

//: 控制器的代理方法
protocol ChatViewControllerDelegate:NSObjectProtocol {
    func chatViewControllerDidLoadSubViews(withChatBoard view:ChatBoardView)
}


