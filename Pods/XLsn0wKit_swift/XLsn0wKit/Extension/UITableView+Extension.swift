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

extension UITableView{
    public func tableViewDisplayWithMsg(_ msg:String, ifNecessaryForRowCount rowCount:Int){
        if rowCount == 0 {
            let msgLabel = UILabel()
            msgLabel.text = msg
            msgLabel.font = UIFont(name: "", size: 14)
            msgLabel.textColor = UIColor.gray
            msgLabel.textAlignment = .center
            
            self.backgroundView = msgLabel
        }
        else{
            self.backgroundView = nil
        }
    }
}
