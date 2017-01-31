//
//  CalendarProtocol.swift
//  FundooHR
//
//  Created by BridgeLabz Solutions LLP  on 1/29/17.
//  Copyright © 2017 BridgeLabz Solutions LLP . All rights reserved.
//

import Foundation
import UIKit

protocol CalendarViewProtocol {
    func reloadCalendar()
    func showError(message:String)
}

protocol CalendarViewModelProtocol {
    
    func pickerDataResponse(arrayMonth:NSMutableArray, arrayYear:NSMutableArray)
    func monthlyAttendanceDetails(perDayAttendance1:NSArray, totalEmp:Int?)
}

protocol CalendarControllerProtocol {
    
    func recievePickerData(arrayMonth:NSMutableArray, arrayYear:NSMutableArray)
    func recieveMonthlyAttendanceData(perDayAttendance1:NSArray, totalEmp:Int?)
}

