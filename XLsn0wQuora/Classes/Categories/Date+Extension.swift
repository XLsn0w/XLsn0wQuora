//
//  Date+Extension.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/27.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit

fileprivate let  D_MINUTE	= 60.0
fileprivate let  D_HOUR     = 3600.0
fileprivate let  D_DAY      = 86400.0
fileprivate let  D_WEEK     = 604800.0
fileprivate let  D_YEAR     = 31556926.0

extension Date {
//MARK: 转换
    func ToStringInfo() -> String {
        //: 今天的消息
        if isToday() {
            
            if isOneMinuteAgo() {
                return "刚刚"
            }else if isOneHourAgo() {
                return String(format: "%.0f分钟前",minuteBefore())
            }
            else {
                return String(format: "%02lu:%02lu",hour(),minute())
            }
        }
        //: 昨天的消息
        else if isYesterday() {
            return String(format: "昨天 %02lu:%02lu",hour(),minute())
        }
        //: 本周的消息
        else if isThisWeek() {
            return String(format: "%@ %02lu:%02lu",weekDay(),hour(),minute())
        }
        else {
            return String(format: "%lu年%02lu月%02lu日 %02lu:%02lu",year(),month(),day(),hour(),minute())
        }
    }
    
//MARK: 获取日期
    
    func year() -> UInt {
        return UInt(Calendar.current.dateComponents([.year], from: self).year!)
    }
    
    func month() -> UInt {
        return UInt(Calendar.current.dateComponents([.month], from: self).month!)
    }

    func day() -> UInt {
        return UInt(Calendar.current.dateComponents([.day], from: self).day!)
    }
    
    func hour() -> UInt {
        return UInt(Calendar.current.dateComponents([.hour], from: self).hour!)
    }
    
    func minute() -> UInt {
        return UInt(Calendar.current.dateComponents([.minute], from: self).minute!)
    }
    
    func second() -> UInt {
        return UInt(Calendar.current.dateComponents([.second], from: self).second!)
    }
    
    func weak() ->UInt {
        //: 格林尼治时间标准
        let calendar = Calendar(identifier: .gregorian)
        
        return UInt(calendar.dateComponents([.weekday], from: self).weekday!)
    }
    
    func weekDay() -> String {
        switch weak(){
        case 1:
            return "星期天"
        case 2:
            return "星期一"
        case 3:
            return "星期二"
        case 4:
            return "星期三"
        case 5:
            return "星期四"
        case 6:
            return "星期五"
        case 7:
            return "星期六"
        default:
            return ""
        }
    }
    //: 获取距离单前多少分钟
    func minuteBefore() -> TimeInterval {
        let interval = -self.timeIntervalSinceNow
        return interval.divided(by: D_MINUTE)
    }
    //: 获取距当前日期多少天后的日期
    func date(afterDays days:UInt) -> Date {
        var components = DateComponents()
        components.day = Int(days)
        return Calendar.current.date(byAdding: components, to: self)!
    }
    
    //: 获取距当前日期多少天前的日期
    func date(beforeDays days:UInt) -> Date {
        var components = DateComponents()
        components.day = Int(days)
        return Calendar.current.date(byAdding: components, to: self)!
    }
    //: 获取月份距离
    func date(withMonth month:Int) -> Date {
        var components = DateComponents()
        components.month = month
        return Calendar.current.date(byAdding: components, to: self)!
    }
//MARK: 判断
   
    func isOneMinuteAgo() -> Bool {
        let interval = -self.timeIntervalSinceNow
        
        if interval <= D_MINUTE {
            return true
        }
        
        return false
    }
   
    func isOneHourAgo() -> Bool {
       let interval = -self.timeIntervalSinceNow
        
        if interval <= D_HOUR {
            return true
        }
        
        return false
    }
    func isToday() -> Bool {
        return isSameDay(date: Date())
    }
    
    func isYesterday() -> Bool {
        return isSameDay(date: Date().date(beforeDays: 1))
    }
    
    func isTomorrow() -> Bool {
        return isSameDay(date: Date().date(afterDays: 1))
    }
    
    func isThisWeek() -> Bool {
        return isSameWeek(date: Date())
    }
    
    func isNextWeek() -> Bool {
        let interval = Date().timeIntervalSinceReferenceDate + D_WEEK
        return isSameWeek(date: Date(timeIntervalSinceReferenceDate: interval))
    }
    
    func isLastWeek() -> Bool {
        let interval = Date().timeIntervalSinceReferenceDate - D_WEEK
        return isSameWeek(date: Date(timeIntervalSinceReferenceDate: interval))
    }
    
    func isThisMonth() -> Bool{
        return isSameMonth(date: Date())
    }
    
    func isNextMonth() -> Bool {
        return isSameMonth(date: Date().date(withMonth: 1))
    }
    
    func isLastMonth() -> Bool {
        return isSameMonth(date: Date().date(withMonth: -1))
    }
    
    func isThisYear() -> Bool {
        return isSameYear(date: Date())
    }
    
    func isNextYear() -> Bool{
        let current = Calendar.current.dateComponents([.year], from: self)
        let compare = Calendar.current.dateComponents([.year], from: Date())
        
        return current.year == (compare.year! + 1)
    }
    
    func isLastYear() -> Bool {
        let current = Calendar.current.dateComponents([.year], from: self)
        let compare = Calendar.current.dateComponents([.year], from: Date())
        
        return current.year == (compare.year! - 1)
    }
    
    func isLeapYear() -> Bool {
        return Date.isLeapYear(date: self)
    }
    
    //: 判断是否同一天
    func isSameDay(date:Date) -> Bool {
        let current = Calendar.current.dateComponents([.year,.month,.day], from: self)
        let compare = Calendar.current.dateComponents([.year,.month,.day], from: date)
        
        return (current.year == compare.year) &&
               (current.month == compare.month) &&
               (current.day == compare.day)
    }
    
    //: 判断是否同一星期
    func isSameWeek(date:Date) -> Bool {
        let current = Calendar.current.dateComponents([.weekOfYear], from: self)
        let compare = Calendar.current.dateComponents([.weekOfYear], from: date)
       
        if current.weekOfYear != compare.weekOfYear {
            return false
        }
        
        return fabs(Date().timeIntervalSince(date)) < D_WEEK
    }
    
    //: 判断是否同一月
    func isSameMonth(date:Date) -> Bool {
        let current = Calendar.current.dateComponents([.year,.month], from: self)
        let compare = Calendar.current.dateComponents([.year,.month], from: date)
       
        return (current.year == compare.year) &&
               (current.month == compare.month)
    }
    
    //: 判断是否同一年
    func isSameYear(date:Date) -> Bool {
        let current = Calendar.current.dateComponents([.year], from: self)
        let compare = Calendar.current.dateComponents([.year], from: date)
        
        return (current.year == compare.year)
    }
    
    //: 判断是否润年
    static func isLeapYear(date:Date) -> Bool {
         let year = date.year()
        if (year % 4 == 0 && year % 100 != 0) || year % 400 == 0 {
            return true
        }
        
        return false
    }
    

}
