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
import Foundation
import UIKit
/**************************************************************************************************/
/**************************************************************************************************/
/**************************************************************************************************/
public extension UISearchBar {
    public func customSearchBar(withPlaceholder placeholder: String) -> () {
        var searchBarFrame = self.frame
        searchBarFrame.size.height = 44
        self.frame = searchBarFrame
        self.barTintColor = UIColor.RGB_Float(r: 0.937255,g: 0.937255,b: 0.956863)
        self.tintColor = UIColor.blue//JKColor_RGB(r: 12, g: 1896, b: 120)
        self.placeholder = placeholder
        self.returnKeyType = .done
        self.setImage(UIImage.init(named: "im_search_image"), for: .search, state: .normal)
        
        let image = UIImage.image(withColor: UIColor.RGB_Float(r: 0.937255,g: 0.937255,b: 0.956863)!, size: CGSize.init(width: getScreenWidth(), height: 66))
        self.setBackgroundImage(image, for: .any, barMetrics: .default)
        
        if let searchTextField: UITextField = self.value(forKey: "searchField") as? UITextField {
            searchTextField.font = UIFont.systemFont(ofSize: 18)
            searchTextField.leftView?.bounds = CGRect.init(x: 0, y: 0, width: 25, height: 25)
            searchTextField.autocapitalizationType = .none
        }
    }
}
/**************************************************************************************************/
/**************************************************************************************************/
/**************************************************************************************************/
