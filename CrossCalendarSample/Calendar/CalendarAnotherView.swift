//
//  CalendarAnotherView.swift
//  CrossCalendarSample
//
//  Created by HIroki Taniguti on 2016/02/24.
//  Copyright © 2016年 Eisuke Sato. All rights reserved.
//

import UIKit

class CalendarAnotherView : UIView, UIScrollViewDelegate {
    
    var horizontalScrollView: UIScrollView!
    
    var currentWeekView: CalendarWeekView!
    var prevWeekView: CalendarWeekView!
    var nextWeekView: CalendarWeekView!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit(){
        print(self.frame)
        CalendarManager.sharedInstance.setCurrentDate()
        CalendarManager.sharedInstance.setCurrentweek()
        horizontalScrollView = UIScrollView(frame: frame)
        
        horizontalScrollView.delegate = self
        
        
        // horizontalにaddする
        var ret = CalendarManager.getPrevWeek()
        currentWeekView = CalendarWeekView(frame: CGRect(origin:CGPoint (x: CGRectGetWidth(frame), y: 0), size: frame.size), year: CalendarManager.sharedInstance.currentYear, month: CalendarManager.sharedInstance.currentMonth, week: CalendarManager.sharedInstance.currentWeek)
        prevWeekView = CalendarWeekView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: frame.size), year: ret.year, month: ret.month, week: ret.week)
        ret = CalendarManager.getNextWeek()
        nextWeekView = CalendarWeekView(frame: CGRect(origin: CGPoint(x: CGRectGetWidth(frame) * 2, y: 0), size: frame.size), year: ret.year, month: ret.month, week: ret.week)
        
        self.addSubview(horizontalScrollView)
        
        horizontalScrollView.addSubview(currentWeekView)
        horizontalScrollView.addSubview(prevWeekView)
        horizontalScrollView.addSubview(nextWeekView)

        // scrollViewの設定
        horizontalScrollView.pagingEnabled = true
        horizontalScrollView.contentSize = CGSize(width: CGRectGetWidth(frame) * 3, height: CGRectGetHeight(frame))
        horizontalScrollView.contentOffset = CGPoint(x: CGRectGetWidth(frame), y: 0)
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
            let pos: CGFloat  = scrollView.contentOffset.x / scrollView.bounds.size.width
            let deff: CGFloat = pos - 1.0
            if fabs(deff) >= 1.0 {
                if (deff > 0) {
                    self.showNextWeekView()
                } else {
                    self.showPrevWeekView()
                }
        }
    }
        
    func showNextWeekView (){
        CalendarManager.sharedInstance.currentWeek++;
        if( CalendarManager.sharedInstance.currentWeek > 5 ){
            CalendarManager.sharedInstance.currentWeek = 1;
            CalendarManager.sharedInstance.currentMonth++;
        }
            
        resetWeekView()
        self.resetContentOffSet(horizontalScrollView)
        print("showNextWeekView")
        
        }
        
    func showPrevWeekView () {
        CalendarManager.sharedInstance.currentWeek--
        if( CalendarManager.sharedInstance.currentWeek == 0 ){
            CalendarManager.sharedInstance.currentWeek = 5
            CalendarManager.sharedInstance.currentMonth--
            }
            
        resetWeekView()
        self.resetContentOffSet(horizontalScrollView)
        print("showPrevWeekView")
        
        }
        
    func resetWeekView() {
        currentWeekView.setUpDays(CalendarManager.sharedInstance.currentYear, month: CalendarManager.sharedInstance.currentMonth, week: CalendarManager.sharedInstance.currentWeek)
        
        var ret = CalendarManager.getPrevWeek()
        prevWeekView.setUpDays(ret.year, month: ret.month, week: ret.week)
        
        ret = CalendarManager.getNextWeek()
        nextWeekView.setUpDays(ret.year, month: ret.month, week: ret.week)
        
        
    }
    
    
    func resetContentOffSet (scrollView: UIScrollView) {
        print("resetContentOffSet")
//        prevWeekView.frame = CGRect(origin: CGPointZero, size: frame.size)
//        currentWeekView.frame = CGRect(origin: CGPoint(x: 0, y: CGRectGetHeight(frame)), size: frame.size)
//        nextWeekView.frame = CGRect(origin: CGPoint(x: 0, y: CGRectGetHeight(frame) * 2), size: frame.size)
        
        let scrollViewDelegate:UIScrollViewDelegate = scrollView.delegate!
        scrollView.delegate = nil
            
        // scrollViewDidScrollを呼ばないため
        horizontalScrollView.contentOffset = CGPoint(x: CGRectGetWidth(frame), y: 0)
        scrollView.delegate = scrollViewDelegate
        }
}
