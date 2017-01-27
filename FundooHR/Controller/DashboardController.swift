//
//  DashboardController.swift
//  FundooHR
//
//  Purpose:
//  1. It is a Controller Class of Dashboard
//  2. It implements ControllerProtocol to pass data
//     from DashboardController to DashboardViewModel

//  Created by BridgeLabz Solutions LLP  on 12/29/16.
//  Copyright © 2016 BridgeLabz Solutions LLP . All rights reserved.
//

import UIKit

class DashboardController: NSObject, ControllerProtocol {
    
    //Var to hold protocol object
    var pDelegate:ViewModelProtocol?
    
    //Var to store DashboardServices Object
    var mDashServiceVAR:DashboardServices?
    
    //Constructor of DashboardController Class
    init(viewModelProtocolObj:ViewModelProtocol) {
        super.init()
        pDelegate = viewModelProtocolObj
        mDashServiceVAR = DashboardServices(controllerProtocolObj: self)
    }
    
    //Method Calling a function of DashboardServices for making REST call
    func CallToController() -> Void {
        
        mDashServiceVAR?.CallToService()
    }
    
    //Method Calling a function of DashboardServices for making REST call
    func callToController1(timeStamp:Int) -> Void {
        mDashServiceVAR?.callToServices1(timeStamp: timeStamp)
    }
    
    //Passing Custom Picker Data from DashboardController to DashboardViewModel
    func recievePickerDataFromServices(arrayMonth:NSMutableArray, arrayYear:NSMutableArray) -> Void {
        pDelegate?.recievePickerDataFromController(arrayMonth: arrayMonth, arrayYear: arrayYear)
    }
    
    //Passing Dashboard Data from DashboardController to DashboardViewModel
    func recieveDashboardDataFromServices(markedData:Int?, unmarkedData:String?, attendanceFallNumber:Int?, leave1:String?, totalEmployee11 totalEmployee1:Int?, timeStamp:CLong?) -> Void {
        
        pDelegate?.recieveDashboardDataFromController(markedData: markedData, unmarkedData: unmarkedData, attendanceFallNumber: attendanceFallNumber, leave1: leave1, totalEmployee11: totalEmployee1, timeStamp: timeStamp)
    }
    
    //Passing Monthly Attendance Data from DashboardController to DashboardViewModel
    func recieveMonthlyAttendanceDataFromServices(perDayAttendance1:NSArray, totalEmp:Int?) -> Void {
        
        pDelegate?.recieveMonthlyAttendanceDataFromController(perDayAttendance1: perDayAttendance1, totalEmp:totalEmp)
    }
    
    
    //Display Error message to user
    func errorMessageCNTRLR() -> Void {
        pDelegate?.errorMessageVM()
    }

}
