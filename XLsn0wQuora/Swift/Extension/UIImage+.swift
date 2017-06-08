//
//  UIImage+.swift
//  Timi
//
//  Created by 田子瑶 on 16/8/30.
//  Copyright © 2016年 田子瑶. All rights reserved.
//

import UIKit

extension UIImage{
    public class func cropImage(_ original:UIImage, scale:CGFloat)->UIImage{
        let originalSize = original.size
        let newSize = CGSize(width: originalSize.width * scale, height: originalSize.height * scale)
        
        //在画布里画原始图
        UIGraphicsBeginImageContext(newSize)
        original.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let cropedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return cropedImage!
    }
    public class func compressImage(_ original:UIImage, compressionQuality:CGFloat)->Data?{
        let imageData = UIImageJPEGRepresentation(original, compressionQuality)
        return imageData
    }
    public class func cropAndCompressImage(_ original:UIImage, scale:CGFloat, compressionQualiy:CGFloat)->Data?{
        let cropImage = UIImage.cropImage(original, scale: scale)
        let imageData = compressImage(cropImage, compressionQuality: compressionQualiy)
        return imageData
    }
    public class func generateImageWithFileName(_ fileName:String)->UIImage?{
        let imagePath = String.createFilePathInDocumentWith(fileName) ?? ""
        if let data = try? Data(contentsOf: URL(fileURLWithPath: imagePath)){
            return UIImage(data: data)
        }
        else{
            return nil
        }
    }
}
