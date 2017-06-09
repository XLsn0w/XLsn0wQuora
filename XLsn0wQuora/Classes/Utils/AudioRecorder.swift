//
//  AudioRecorder.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/5/2.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import AVFoundation
import QorumLogs

fileprivate let filePath = FileManager.caches().appending("/rec.caf")
class AudioRecorder: NSObject {
//MARK: 单例
    static let shared = AudioRecorder()
    
    //: 录音
    var recorder:AVAudioRecorder? = {
        let session = AVAudioSession.sharedInstance()
        //: 播放与录制
        do {
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        }
        catch {
            QL4("创建录音会话失败!")
            return nil
        }
        
        do {
            try session.setActive(true)
        }
        catch {
            QL4("录音会话无法启动!")
            return nil
        }
        
        
        session.requestRecordPermission({ (allowed) in
            if !allowed {
                QL2("无法访问您的麦克风")
            }
        })
        
    
        
        let setting = [AVFormatIDKey:NSNumber(value:Int32(kAudioFormatMPEG4AAC)), //: 录音格式
                       AVSampleRateKey:NSNumber(value: Float(44100.0)),              //: 录音采样率
                       AVNumberOfChannelsKey:NSNumber(value: 1),            //: 录音通道数
                       AVLinearPCMBitDepthKey:NSNumber(value: 8),           //: 录音线性音频的位深
                       AVEncoderAudioQualityKey:NSNumber(value: Int32(AVAudioQuality.high.rawValue))]  //: 录音的质量
        
        var record:AVAudioRecorder?
        
        do {
            
            record = try AVAudioRecorder(url: URL(fileURLWithPath: filePath), settings: setting)
        }
        catch {
            QL4("创建录音失败")
        }
        

        record!.isMeteringEnabled = true
        
        return record
    }()
    var timer:Timer?
    
    var volumeChangedOperation:((_ volume:CGFloat) -> ())?
    var completeOperation:((_ path:String,_ time:CGFloat) -> ())?
    var cancelOperation:(() -> ())?
//MARK: 内部响应
    @objc private func scheduledTimerExecute(timer:Timer) {
        recorder?.updateMeters()
        
        let peak = pow(10,recorder!.peakPower(forChannel: 0)*0.015)
        
        self.volumeChangedOperation!(CGFloat(peak))
    }
   
//MARK: 外部接口
    
    func startRecording(volumeChanged:@escaping (_ volume:CGFloat) -> (),complete:@escaping (_ path:String,_ time:CGFloat) -> (),
                        cancel:@escaping () -> ()) {
        
        self.volumeChangedOperation = volumeChanged
        self.completeOperation = complete
        self.cancelOperation = cancel
        
        if FileManager.default.fileExists(atPath: filePath) {
            do {
                try FileManager.default.removeItem(atPath: filePath)
            }
            catch{
                QL4("移除录音文件失败！")
            }
        }
        
        guard let _ = recorder else {
            QL4("获取录音对象失败！")
            return
        }
        
        if !recorder!.prepareToRecord() {
            QL4("启动录音失败！")
            return
        }
        recorder?.record()
        recorder?.delegate = self
        
        if self.timer != nil  && (self.timer?.isValid)! {
            self.timer!.invalidate()
        }
        
        timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(scheduledTimerExecute(timer:)), userInfo: nil, repeats: true)
        
    }
    
    func stopRecording() {
        guard let _ = recorder else {
            QL4("获取录音对象失败！")
            return
        }
        
        timer?.invalidate()
        let time = recorder!.currentTime
        
        recorder?.stop()
        
        let session = AVAudioSession.sharedInstance()
        
        do {
            try session.setActive(false)
        }
        catch {
            QL4("录音会话无法结束!")
            return 
        }
        
        guard let complete = completeOperation else {
            return
        }
        
        complete(filePath,CGFloat(time))
        self.completeOperation = nil
    }
    
    func cancelRecording() {
        guard let _ = recorder else {
           QL4("获取录音对象失败！")
            return
        }
        timer?.invalidate()
        
        recorder?.stop()
        
        guard let cancel = cancelOperation else {
            return
        }
        
        cancel()
        self.cancelOperation = nil
    }
}

//MARK: 代理方法
extension AudioRecorder:AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            QL2("录音成功！")
        }
        else {
            QL4("失败")
        }
    }
    
    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        QL4("录音失败,\(error)")
    }
}
