/*********************************************************************************************
 *   __      __   _         _________     _ _     _    _________   __         _         __   *
 *	 \ \    / /  | |        | _______|   | | \   | |  |  ______ |  \ \       / \       / /   *
 *	  \ \  / /   | |        | |          | |\ \  | |  | |     | |   \ \     / \ \     / /    *
 *     \ \/ /    | |        | |______    | | \ \ | |  | |     | |    \ \   / / \ \   / /     *
 *     /\/\/\    | |        |_______ |   | |  \ \| |  | |     | |     \ \ / /   \ \ / /      *
 *    / /  \ \   | |______   ______| |   | |   \ \ |  | |_____| |      \ \ /     \ \ /       *
 *   /_/    \_\  |________| |________|   |_|    \__|  |_________|       \_/       \_/        *
 *                                                                                           *
 *********************************************************************************************/

import UIKit

fileprivate let kTapGentureKey       = UnsafeRawPointer(bitPattern: "kTapGentureKey".hashValue)
fileprivate let kTapGentureActionKey = UnsafeRawPointer(bitPattern: "kTapGentureActionKey".hashValue)

public extension UIView {
    
    public var x: CGFloat {
        set(newValue) {
            var tempRect = self.frame
            tempRect.origin.x = newValue
            self.frame = tempRect
        }
        
        get {
            return self.frame.origin.x
        }
    }
    
    public var y: CGFloat {
        set(newValue) {
            var tempRect = self.frame
            tempRect.origin.y = newValue
            self.frame = tempRect
        }
        
        get {
            return self.frame.origin.y
        }
    }
    
    public var width: CGFloat {
        set(newValue) {
            var tempRect = self.frame
            tempRect.size.width = newValue
            self.frame = tempRect
        }
        
        get {
            return self.frame.size.width
        }
    }
    
    public var height: CGFloat {
        set(newValue) {
            var tempRect = self.frame
            tempRect.size.height = newValue
            self.frame = tempRect
        }
        
        get {
            return self.frame.size.height
        }
    }
    
    public var centerX: CGFloat {
        set(newValue) {
            var tempCenter = self.center
            tempCenter.x = newValue
            self.center = tempCenter
        }
        
        get {
            return self.center.x
        }
    }
    
    
    public var size: CGSize {
        set {
            self.frame.size = newValue
        }
        get {
            return self.frame.size
        }
    }
    
    public var centerY: CGFloat {
        set(newValue) {
            var tempCenter = self.center
            tempCenter.y = newValue
            self.center = tempCenter
        }
        
        get {
            return self.center.y
        }
    }
    
    public var maxX: CGFloat {
        get {
            return self.frame.maxX
        }
    }
    
    public var maxY: CGFloat {
        get {
            return self.frame.maxY
        }
    }
    
    public var midX: CGFloat {
        get {
            return self.frame.midX
        }
    }
    
    public var midY: CGFloat {
        get {
            return self.frame.midY
        }
    }
    
    
    var xl_height:CGFloat{
        get{
            return self.frame.height
        }
        set(newValue){
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    
    var xl_width:CGFloat{
        get{
            return self.frame.width
        }
        set(newValue){
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    
    var xl_x:CGFloat{
        get{
            return self.frame.origin.x
        }
        set(newValue){
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    
    var xl_y:CGFloat{
        get{
            return self.frame.origin.y
        }
        set(newValue){
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    
    var xl_centerX:CGFloat{
        get{
            return self.center.x
        }
        set(newValue){
            var center = self.center
            center.x = newValue
            self.center = center
        }
    }
    
    var xl_centerY:CGFloat{
        get{
            return self.center.y
        }
        set(newValue){
            var center = self.center
            center.y = newValue
            self.center = center
        }
    }
    
    func setTapActionWithBlock(tapBlock:(()->())) {
        let tapGesture = objc_getAssociatedObject(self, kTapGentureKey)
        if (tapGesture == nil)
        {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onClickEvent))
            self.addGestureRecognizer(tapGesture)
            objc_setAssociatedObject(self, kTapGentureKey, tapGesture, .OBJC_ASSOCIATION_RETAIN)
        }
        objc_setAssociatedObject(self, kTapGentureActionKey, (tapBlock as AnyObject) , .OBJC_ASSOCIATION_COPY)
    }
    
    func onClickEvent(tapGesture:UITapGestureRecognizer) {
        if (tapGesture.state == UIGestureRecognizerState.recognized) {
            if let tapBlock = objc_getAssociatedObject(self, kTapGentureActionKey) as? (()->()) {
                tapBlock()
            }
        }
    }
}
