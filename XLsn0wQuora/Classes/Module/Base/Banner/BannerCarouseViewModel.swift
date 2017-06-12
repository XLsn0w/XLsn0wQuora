
import UIKit

class BannerDataModel: NSObject {
    var bannerImageUrls:Array<String>?
}

class BannerCarouseViewModel: NSObject {
    var dataModel:BannerDataModel?
    
    var pageImage:UIImage
    
    init(withModel model:BannerDataModel) {
        self.dataModel = model
        
        //pageImage = (UIImage(named: "banner-0\(Int(arc4random() % 5) + 1).jpg"))!
  
        
        
        pageImage = (UIImage(named: "banner-1.jpg"))!
        
    }
}
