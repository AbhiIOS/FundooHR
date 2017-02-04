//
//  CalendarController.swift
//  FundooHR
//
//  Created by BridgeLabz Solutions LLP  on 1/29/17.
//  Copyright © 2017 BridgeLabz Solutions LLP . All rights reserved.
//

import UIKit

class CalendarController: NSObject, CalendarControllerProtocol {
    
    //Var to hold protocol object
    var pDelegate:CalendarViewModelProtocol?
    
    //Var to store CalendarServices Object
    var mCalendarServiceVar:CalendarServices?
    
    //Constructor of CalendarController Class
    init(viewModelProtocolObj:CalendarViewModelProtocol) {
        super.init()
        pDelegate = viewModelProtocolObj
        mCalendarServiceVar = CalendarServices(controllerProtocolObj: self)
    }

    //Fetching Monthly attendance Data
    func getMonthlyAttendanceData(timestamp:Int) -> Void {
        mCalendarServiceVar?.monthlyAttendanceRestService(timeStamp: timestamp)
    }
    
    //Passing Custom Picker Data from CalendarController to CalendarViewModel
    func recievePickerData(arrayMonth:NSMutableArray, arrayYear:NSMutableArray) -> Void {
        pDelegate?.pickerDataResponse(arrayMonth: arrayMonth, arrayYear: arrayYear)
    }
 
    //Passing Monthly Attendance Data from CalendarController to CalendarViewModel
    func recieveMonthlyAttendanceData(perDayAttendance1:NSArray, totalEmp:Int?, timestamp:String) -> Void {
        
        pDelegate?.monthlyAttendanceDetails(perDayAttendance1: perDayAttendance1, totalEmp: totalEmp, timestamp: timestamp)
    }

}
