//
//  CalendarViewModel.swift
//  FundooHR
//
//  Created by BridgeLabz Solutions LLP  on 1/29/17.
//  Copyright © 2017 BridgeLabz Solutions LLP . All rights reserved.
//

import Foundation
import UIKit


class CalendarViewModel: NSObject, CalendarViewModelProtocol {
    
    //Var to store object of CalendarController
    var mCalendarController:CalendarController?

    //Var to store names of months in array
    var mMonthsAry1:NSMutableArray?
    
    //Var to store years in array
    var mYearAry1:NSMutableArray?
    
    //Var to store number of total Employee
    var mTotalEmployeeCal:String?
    
    //Var to store per day attendance data in array
    var mPerDayAttendance:NSArray? = []

    //var holding int value
    var i:Int = 0
    
    //Var to store data of number of employee absent
    var mAbsent:NSDictionary!

    //Var to store object of CalendarViewController
    var mCalenderViewProt:CalendarViewProtocol?

    
    //Constructor of CalendarViewModel Class
    init(calendarProtocolObj:CalendarViewProtocol) {
        super.init()
        mCalenderViewProt = calendarProtocolObj
        
        //Initialise object of CalendarController
        mCalendarController = CalendarController(viewModelProtocolObj: self)
    }
    
    //Fetching monthly attendance data
    func getMonthlyAttendance(timestamp:Int) -> Void {
        mCalendarController?.getMonthlyAttendanceData(timestamp: timestamp)
    }

    //Method Executes when custom picker data recieved from controller
    func pickerDataResponse(arrayMonth:NSMutableArray, arrayYear:NSMutableArray) -> Void {
        mMonthsAry1 = arrayMonth
        mYearAry1 = arrayYear
    }

    //Saving Monthly Attendance data recieved from controller
    func monthlyAttendanceDetails(perDayAttendance1:NSArray, totalEmp:Int?, timestamp:String) -> Void {
        mPerDayAttendance = []
        mPerDayAttendance = perDayAttendance1
        mTotalEmployeeCal = String(describing: totalEmp!)
        i=0
        mCalenderViewProt?.reloadCalendar(timeStamp: timestamp)
        
    }

    //Populate Monthly attendance data into calendar
    func dayAttendance() -> String {
        
        var unmarkedEmp:String!
    //    if (mPerDayAttendance == nil) { return "0" }
    //    if (i+1)<=(mPerDayAttendance?.count)! {
           // print(i)
            mAbsent = mPerDayAttendance?.object(at: i) as! NSDictionary
            unmarkedEmp = mAbsent["unmarked"] as! String
            i+=1
            return unmarkedEmp
//        }
//        else
//        {
//            return "null"
//        }
    }
        
        
        
 //   }

}
