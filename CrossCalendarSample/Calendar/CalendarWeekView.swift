//
//  CalendarWeekView.swift
//  CrossCalendarSample
//
//  Created by HIroki Taniguti on 2016/02/24.
//  Copyright © 2016年 Eisuke Sato. All rights reserved.
//

import UIKit

class CalendarWeekView: UIView{
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect, year: Int, month: Int, week: Int) {
        super.init(frame:frame)
        setUpDays(year,month:month, week:week)
    }
    
    func setUpDays(year:Int, month:Int, week:Int){
        // 既にセットされてるdayViewの削除
        let subViews:[UIView] = self.subviews as [UIView]
        for view in subViews {
            if view.isKindOfClass(CalendarDayView) {
                view.removeFromSuperview()
            }
        }
        
        let day = CalendarManager.getLastDay(year, month:month);
        let daySize = CGSize(width: Int(frame.size.width / 7.0), height: Int(frame.size.width / 7.0))
        
        let nowday = NSDate();
        
        var start = nowday.firstDayOfWeek()!
        
        //初日の曜日を取得
        var weekday = CalendarManager.getWeekDay(year, month: month, day: 1)
        
        
        //        var weekday = CalendarManager.sharedInstance.setCurrentweek()
        //        print("setUpDays")
        //        print("\(firstdayweek)")
//        var start = CalendarManager.getStartWeekDay(start)
//        print("start \(start)")
        
        // dayViewをaddする
        for var i = 0; i < 7; i++ {
            let x = (weekday - 1) * Int(daySize.width)
            let y = Int(daySize.height)
            let frame = CGRect(origin: CGPoint(x: x, y: y), size: daySize)
            
//            let dayView = CalendarDayView(frame: frame, year: year, month: month, day: i + 1, weekday: weekday)
            let dayView = CalendarDayView(frame: frame, year: year, month: month, day: start + 1 + i, weekday: weekday)
            self.addSubview(dayView)
            weekday++
            if weekday > 7 {
                weekday = 1
            }
        }
    }
}

