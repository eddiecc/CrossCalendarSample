//
//  ViewController.swift
//  CrossCalendarSample
//
//  Created by Eisuke Sato on 2016/02/19.
//  Copyright © 2016年 Eisuke Sato. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var calendarBaseView: UIView!
    var calendarView: CalendarView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidLayoutSubviews() {
        if calendarView == nil {
            calendarView = CalendarView(frame: calendarBaseView.bounds)
            if let calendarView = calendarView {
                calendarBaseView.addSubview(calendarView)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

