//
//  ChatString+Extension.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/27.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import Foundation
import UIKit
import QorumLogs

extension String {
    func fitSize(_ size:CGSize,_ font:UIFont) -> CGSize {
        //: 计算文本尺寸
        return self.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName:font], context: nil).size
    }
    
    func toMsgString() -> NSAttributedString {
        let attributeStr = NSMutableAttributedString(string: self)
        let range = NSRange(location: 0, length: NSString(string: self).length)
        attributeStr.addAttribute(NSFontAttributeName, value: fontSize16, range: range)
        
        //: 正则表达式匹配字符串
        let emojiRegular = "\\[[a-zA-Z0-9\\/\\u4e00-\\u9fa5]+\\]"
        let regular:NSRegularExpression?
        
        do {
            regular = try NSRegularExpression(pattern: emojiRegular, options: .caseInsensitive)
        }
        catch{
            QL4("Catch Error : NSRegularExpression")
            return attributeStr
        }
        
        guard let result = regular?.matches(in: self, options: .init(rawValue: 0), range: range) else {
            QL4("No result: regular.matches")
            return attributeStr
        }
    
        let images = NSMutableArray(capacity: result.count)
        
        //: 匹配图片
        for i in 0..<result.count {
            let match = result[i] as NSTextCheckingResult
            let str = NSString(string: self).substring(with: match.range)
            
            guard let group = ChatExpression.shared.defaultFace else {
                continue
            }
            
            guard let emojis = group.emojis  else {
                continue
            }
            
            for i in 0..<emojis.count {
                let emoji = emojis[i] as! Emoji
                
                if emoji.name == str {
                    //: 新建附件 （ios 7 新出的）
                   let textAt = NSTextAttachment()
                    
                    //: 给附件添加图片
                    textAt.image = UIImage(named: emoji.name!)
                    
                    //: 调整图片位置,如果图片偏上或者偏下，调整一下bounds的y值即可
                    textAt.bounds = CGRect(x: 0, y: -margin*0.4, width: margin*2, height: margin*2)
                    
                    let imageStr =  NSAttributedString(attachment: textAt)
                    let  imageDic:[String:AnyObject] = ["Emoji_Image":imageStr,"Emoji_Range":NSValue(range: range)]
                    
                    images.add(imageDic)
                }
                
            }
        }
    
        //: 从后往前替换，否则会引起位置问题
        let data = images.reversed()
        for i in 0..<data.count  {
            let range = (data[i] as![String:AnyObject])["Emoji_Range"] as! NSRange
            attributeStr.replaceCharacters(in: range, with: (data[i] as![String:AnyObject])["Emoji_Image"] as! String)
        }
        
        return attributeStr
        
    }
}
