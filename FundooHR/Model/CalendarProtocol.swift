//
//  CalendarProtocol.swift
//  FundooHR
//
//  Purpose:
//  1. It is a Protocol Class for calendar ViewController

//  Created by BridgeLabz Solutions LLP  on 1/29/17.
//  Copyright © 2017 BridgeLabz Solutions LLP . All rights reserved.
//

import Foundation
import UIKit

//Protocol for Calendar View Class
protocol CalendarViewProtocol {
    func reloadCalendar(timeStamp:String)
    func showError(message:String)
}

//Protocol for Calendar ViewModel Class
protocol CalendarViewModelProtocol {
    
    func pickerDataResponse(arrayMonth:NSMutableArray, arrayYear:NSMutableArray)
    func monthlyAttendanceDetails(perDayAttendance1:NSArray, totalEmp:Int?, timestamp:String)
}

//Protocol for Calendar Controller Class
protocol CalendarControllerProtocol {
    
    func recievePickerData(arrayMonth:NSMutableArray, arrayYear:NSMutableArray)
    func recieveMonthlyAttendanceData(perDayAttendance1:NSArray, totalEmp:Int?, timestamp:String)
}

