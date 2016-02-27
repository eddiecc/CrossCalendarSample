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
    
    init(frame: CGRect, year: Int, month: Int, week: Int, day: Int) {
        super.init(frame:frame)
        setUpDays(year,month:month, week:week, day:day)
    }
    
    func setUpDays(year:Int, month:Int, week:Int, day: Int){
        // 既にセットされてるdayViewの削除
        let subViews:[UIView] = self.subviews as [UIView]
        for view in subViews {
            if view.isKindOfClass(CalendarDayView) {
                view.removeFromSuperview()
            }
        }

        let daySize = CGSize(width: Int(frame.size.width / 7.0), height: Int(frame.size.width / 7.0))
        
        //初日の曜日を取得
        var weekday = CalendarManager.getWeekDay(year, month: month, day: day)
        
        //今日を含む週の先頭（日曜日）の日にちをゲット
        let nowday = NSDate();
        var day = nowday.firstDayOfWeek()!
        print("day : \(day)")
        
        // dayViewをaddする
        for var i = 0; i < 6; i++ {
            let x = (weekday - 1) * Int(daySize.width)
            let y = Int(daySize.height)
            let frame = CGRect(origin: CGPoint(x: x, y: y), size: daySize)

            let dayView = CalendarDayView(frame: frame, year: year, month: month, day: day + 1 + i, weekday: weekday)
            self.addSubview(dayView)
            weekday++
            if weekday > 7 {
                weekday = 1
            }
        }
    }
}

