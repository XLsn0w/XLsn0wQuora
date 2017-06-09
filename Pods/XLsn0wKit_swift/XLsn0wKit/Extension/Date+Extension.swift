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

public extension Date {
    
    
    static func intervalToChinaCalander(_ interval:TimeInterval) ->String{
        let date = Date(timeIntervalSince1970: interval)
        let cal = Calendar.current
        let calCom = (cal as NSCalendar).components([.year, .month, .day], from: date)
//        let currentDate = "\(calCom.year)年\(calCom.month)月\(calCom.day)日"
        let currentDate = "\(String(describing: calCom.year))年\(String(describing: calCom.month))月\(String(describing: calCom.day))日"
        return currentDate
    }
    
   public static func intervalToDateComponent(_ interval:TimeInterval) -> DateComponents {
        let date = Date(timeIntervalSince1970: interval)
        return dateToDateComponent(date)
    }
    
   public static func dateToDateComponent(_ date:Date) -> DateComponents{
        let cal = Calendar.current
        let calCom = (cal as NSCalendar).components([.year, .month, .day], from: date)
        return calCom
    }
    
   public static func numberOfDaysInMonthWithDate(_ date:Date)->Int{
        let comp = (Calendar.current as NSCalendar).range(of: .day, in: .month, for: date)
        return comp.length
    }
    
   public static func numberOfDaysInMonthWithInterval(_ interval:TimeInterval)->Int{
        let date = Date(timeIntervalSince1970: interval)
        return numberOfDaysInMonthWithDate(date)
    }
    
   public static func getFirstDayOfMonthWithDate(_ date:Date)->Date?{
        let cal = Calendar.current
        var comp = (cal as NSCalendar).components([.year, .month, .day], from: date)
        comp.day = 1
        return cal.date(from: comp)
    }
    
    
}

