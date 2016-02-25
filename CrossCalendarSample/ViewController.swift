//
//  ViewController.swift
//  CrossCalendarSample
//
//  Created by Eisuke Sato on 2016/02/19.
//  Copyright © 2016年 Eisuke Sato. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var toggleWeek: Bool = false

    @IBOutlet weak var calendarBaseView: UIView!
    @IBOutlet weak var calendarWeekView: UIView!
    
    
    var calendarView: CalendarView?
    var calendarAnotherView: CalendarAnotherView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //calendarBaseView表示
    override func viewDidLayoutSubviews() {
//        if calendarAnotherView == nil{
//            calendarAnotherView = CalendarAnotherView(frame: calendarWeekView.bounds)
//            if let calendarAnotherView = calendarAnotherView {
//                calendarWeekView.addSubview(calendarAnotherView)
        
        if calendarView == nil {
            calendarView = CalendarView(frame: calendarBaseView.bounds)
            if let calendarView = calendarView {
                calendarBaseView.addSubview(calendarView)
        
//                if weekConstraint == true{
//                    calendarAnotherView = CalendarAnotherView(frame: calendarWeekView.bounds)
//                    if let calendarAnotherView = calendarAnotherView {
//                        calendarWeekView.addSubview(calendarAnotherView)
                    }
                }
            }
//    }

//    override func viewDidLayoutSubviews() {
//        if calendarAnotherView == nil {
//            calendarAnotherView = CalendarAnotherView(frame: calendarAnotherView.bounds)
//            if let calendarAnotherView = calendarAnotherView {
//                calendarAnotherView.addSubview(calendarAnotherView)
//            }
//        }
//    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    @IBOutlet weak var weekConstraint: NSLayoutConstraint!
    @IBOutlet weak var monthConstraint: NSLayoutConstraint!
    
    
    @IBAction func toggle(sender: AnyObject) {
        print("toggle", toggleWeek)
        toggleWeek = !toggleWeek
        monthConstraint.priority = toggleWeek ? UILayoutPriorityDefaultLow : UILayoutPriorityDefaultHigh
        weekConstraint.priority = toggleWeek ? UILayoutPriorityDefaultHigh : UILayoutPriorityDefaultLow
        UIView.animateWithDuration(0.5) { () -> Void in
            self.calendarBaseView.alpha = self.toggleWeek ? 0.0 : 1.0
            self.view.layoutIfNeeded()
        }

        
        
    }
    
}




