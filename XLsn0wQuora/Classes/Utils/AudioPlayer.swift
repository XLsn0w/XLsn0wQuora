
import UIKit
import AVFoundation
import XLsn0wKit_swift

class AudioPlayer: NSObject {
//MARK: 单例
    static let shared = AudioPlayer()
    
    var completeOperation:((_ finished:Bool) -> ())?
    
    var isPlaying:Bool {
        get{
            guard let _ = player else {
                return false
            }
            
            return player!.isPlaying
        }
    }
//MARK: 懒加载
    var player:AVAudioPlayer?
//MARK: 外部接口
    func playAudio(atPath path:String,complete:@escaping (_ finished:Bool) -> ()) {
        
        let session = AVAudioSession.sharedInstance()
        //: 播放与录制
        do {
//            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: AVAudioSessionCategoryOptions.defaultToSpeaker)
        }
        catch {
            XLsn0wLog("播放会话失败!")
            return
        }
        
        do {
            try session.setActive(true)
        }
        catch {
            XLsn0wLog("播放会话无法启动!")
            return
        }
        
        if player != nil && (player?.isPlaying)! {
            playAudioStop()
        }
        
        self.completeOperation = complete
        
        do {
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
        }
        catch{
            complete(false)
        }
        
        player!.delegate = self
        
    
        if player!.prepareToPlay() {
            player!.play()
        }
    }
    
    func playAudioStop() {
        player?.stop()
        
        let session = AVAudioSession.sharedInstance()
        
        do {
            try session.setActive(false)
        }
        catch {
            XLsn0wLog("播放会话无法结束!")
            return
        }
        
        guard let complete = completeOperation else {
            return
        }
        
        complete(false)
    }
    
    
}

//MARK: 代理方法
extension AudioPlayer:AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
        if flag {
            self.completeOperation!(true)
            self.completeOperation = nil
        }else{
            XLsn0wLog("播放音频失败")
        }
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        XLsn0wLog("音频播放出现错误：\(error)")
        
        self.completeOperation!(false)
        self.completeOperation = nil
    }
}
