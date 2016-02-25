//
//  TestViewController.swift
//  CrossCalendarSample
//
//  Created by HIroki Taniguti on 2016/02/25.
//  Copyright © 2016年 Eisuke Sato. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    @IBOutlet weak var calendarWeekView: UIView!
    var calendarAnotherView: CalendarAnotherView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //calendarBaseView表示
    override func viewDidLayoutSubviews() {
        if calendarAnotherView == nil{
            calendarAnotherView = CalendarAnotherView(frame: calendarWeekView.bounds)
            if let calendarAnotherView = calendarAnotherView {
                calendarWeekView.addSubview(calendarAnotherView)
                }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


