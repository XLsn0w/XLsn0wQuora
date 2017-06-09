//
//  UIImage+Extension.swift
//  PresentGift
//
//  Created by 李莎鑫 on 17/3/18.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit

extension UIImage {
    
    class func image(withColor color: UIColor,withSize size: CGSize) -> UIImage {
        
        let rect = CGRect(x: 0, y: 0, width: size.width == 0 ? 1.0 : size.width, height: size.height == 0 ? 1.0 : size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    class func resize(withImage image:UIImage) -> UIImage {
        return image.resizableImage(withCapInsets: UIEdgeInsets(top: image.size.height*0.5, left: image.size.width*0.5, bottom: image.size.height*0.5, right: image.size.width*0.5))
    }
    
    func resetImageSize(newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    
    }
    
    
}
