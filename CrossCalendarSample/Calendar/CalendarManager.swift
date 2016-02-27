//
//  CalendarManager.swift
//  CrossCalendarSample
//
//  Created by Eisuke Sato on 2016/02/19.
//  Copyright © 2016年 Eisuke Sato. All rights reserved.
//

import UIKit
import SwiftDate


class CalendarManager: NSObject {
    
    static let sharedInstance: CalendarManager = CalendarManager()
    
    var currentYear = 0
    var currentMonth = 0
    var currentDay = 0
    var currentWeek = 0
    
//    var start = 0
    
    var dayWeek = 0
    var thisWeekend = 0
    var nextWeekend = 0
    var prevWeekend = 0
    var firstDayWeek = 0
    
    var prevStartday = 0
    var nextStartday = 0
    var startday = 0
    
    var a = 0
    var b = 0
    var c = 0
    
    var weekrows = 0
    
    //今日の、「年」「月」「日にちをとる」
    //今日の"yyyy/MM/dd"とって、要素ごとに分割
    func setCurrentDate() {
        let dateFormatter:NSDateFormatter = NSDateFormatter();
        dateFormatter.dateFormat = "yyyy/MM/dd";
        let dateString:String = dateFormatter.stringFromDate(NSDate());
        var dates:[String] = dateString.componentsSeparatedByString("/")
        currentYear  = Int(dates[0])!
        currentMonth = Int(dates[1])!
        currentDay = Int(dates[2])!
        print("currentYear:\(currentYear)\n currentMonth:\(currentMonth)\n currentDay:\(currentDay)")
    }
    
    //第何週の取得
    class func getWeekDay(year:Int, month:Int, day:Int) -> Int {
        let dateFormatter = NSDateFormatter();
        dateFormatter.dateFormat = "yyyy/MM/dd";
        let date = dateFormatter.dateFromString(String(format:"%04d/%02d/%02d", year, month, day));
        if let date = date {
            let calendar = NSCalendar.currentCalendar()
            let dateComp = calendar.components(NSCalendarUnit.Weekday, fromDate: date)
            
            let nowday = NSDate();
            var start = nowday.firstDayOfWeek()!
            return dateComp.weekday;
            return start
        }
        return 0
    }
    
    //その月の最終日の取得
    class func getLastDay(var year: Int, var month: Int) -> Int {
        let dateFormatter = NSDateFormatter();
        dateFormatter.dateFormat = "yyyy/MM/dd";
        
        if month == 12 {
            month = 0
            year++
        }
        
        let targetDate = dateFormatter.dateFromString(String(format:"%04d/%02d/01", year, month + 1));
        if let targetDate = targetDate {
            //月初から一日前を計算し、月末の日付を取得
            let orgDate = NSDate(timeInterval:(24 * 60 * 60) * (-1), sinceDate: targetDate)
            let str = dateFormatter.stringFromDate(orgDate)
            //lastPathComponentを利用するのは目的として違う気も。。
            return Int((str as NSString).lastPathComponent)!;
        }
        return 0
    }
    
    //曜日の取得
    class func getWeek(year: Int, month: Int, day: Int) -> Int {
        let dateFormatter = NSDateFormatter();
        dateFormatter.dateFormat = "yyyy/MM/dd";
        let date = dateFormatter.dateFromString(String(format:"%04d/%02d/%02d", year, month, day));
        if let date = date {
            let calendar = NSCalendar.currentCalendar()
            let dateComp = calendar.components(NSCalendarUnit.WeekOfMonth, fromDate: date)
            return dateComp.weekOfMonth;
        }
        return 0
    }
    
    //先週の初日ゲット
    class func getMaeWeek(year: Int, month: Int, var day: Int) -> Int {
        let dateFormatter = NSDateFormatter();
        dateFormatter.dateFormat = "yyyy/MM/dd";
        let date = dateFormatter.dateFromString(String(format:"%04d/%02d/%02d", year, month, day));
        let nowday = NSDate()
        let prevSevenday = NSDate() - 7.days
        let weekrow = nowday.weekOfYear
        print("weekrow : \(weekrow)")
        
        print("prevSevenday : \(prevSevenday)")
        
        let prevStartday = prevSevenday.firstDayOfWeek()
        day = prevStartday!
        
        print("prevStartday : \(prevStartday)")
        if let date = date {
            let calendar = NSCalendar.currentCalendar()
            let dateComp = calendar.components(NSCalendarUnit.WeekOfMonth, fromDate: date)
            return dateComp.weekOfMonth;
        }
        return 0
        print("getPrevWeekのday: \(day)")
    }
    
    //来週の初日ゲット
    class func getAtoWeek(year: Int, month: Int, day: Int) -> Int {
        let dateFormatter = NSDateFormatter();
        dateFormatter.dateFormat = "yyyy/MM/dd";
        let date = dateFormatter.dateFromString(String(format:"%04d/%02d/%02d", year, month, day));
        let nowday = NSDate()
        let prevSevenday = NSDate() + 7.days
        let nextSevenday = NSDate() - 7.days
        let weekrow = nowday.weekOfYear
        print("weekrow : \(weekrow)")
        
        print("prevSevenday : \(prevSevenday)")
        print("nextSevenday : \(nextSevenday)")
        
        let prevStartday = prevSevenday.firstDayOfWeek()
        let nextStartday = nextSevenday.firstDayOfWeek()
        print("prevStartday : \(prevStartday)")
        print("nextStartday : \(nextStartday)")
        
        if let date = date {
            let calendar = NSCalendar.currentCalendar()
            let dateComp = calendar.components(NSCalendarUnit.WeekOfMonth, fromDate: date)
            return dateComp.weekOfMonth;
        }
        return 0
    }


    
    class func getNextYearAndMonth () -> (year: Int, month: Int){
        var next_year:Int = CalendarManager.sharedInstance.currentYear
        var next_month:Int = CalendarManager.sharedInstance.currentMonth + 1
        if next_month > 12 {
            next_month=1
            next_year++
        }
        return (next_year,next_month)
    }
    
    
    
    class func getPrevYearAndMonth () -> (year: Int, month: Int){
        var prev_year:Int = CalendarManager.sharedInstance.currentYear
        var prev_month:Int = CalendarManager.sharedInstance.currentMonth - 1
        if prev_month == 0 {
            prev_month = 12
            prev_year--
        }
        return (prev_year,prev_month)
    }
    
    class func getNextWeek () -> (year: Int, month: Int, week: Int, day: Int){
        print("getNextWeek")
        var next_year:Int = CalendarManager.sharedInstance.currentYear
        var next_month:Int = CalendarManager.sharedInstance.currentMonth
        var next_week:Int = (NSDate() + 7.days).firstDayOfWeek()!
//        var next_week:Int = CalendarManager.sharedInstance.currentWeek + 1
        var next_day:Int = CalendarManager.sharedInstance.currentDay
        if next_week == 5{
            next_week = 1
            next_month++
            next_year++
        }
        return (next_year,next_month,next_week,next_day)
    }
    
    class func getPrevWeek () -> (year: Int, month: Int, week: Int, day: Int){
        print("getPrevWeek")
        var prev_year:Int = CalendarManager.sharedInstance.currentYear
        var prev_month:Int = CalendarManager.sharedInstance.currentMonth
        var prev_week:Int = CalendarManager.sharedInstance.currentWeek + 1
        var prev_day:Int = CalendarManager.sharedInstance.currentDay

        if prev_week == 0{
            prev_week = 5
            prev_month = 12
            prev_year--
        }
        return (prev_year,prev_month,prev_week,prev_day)

    }
    
    class func getNextYear () -> (year: Int, month: Int){
        return (CalendarManager.sharedInstance.currentYear + 1, CalendarManager.sharedInstance.currentMonth)
    }
    
    class func getLastYear () -> (year: Int, month: Int){
        return (CalendarManager.sharedInstance.currentYear - 1, CalendarManager.sharedInstance.currentMonth)
    }
}
