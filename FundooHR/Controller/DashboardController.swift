//
//  DashboardController.swift
//  FundooHR
//
//  Created by BridgeLabz Solutions LLP  on 12/29/16.
//  Copyright © 2016 BridgeLabz Solutions LLP . All rights reserved.
//

import UIKit

class DashboardController: NSObject, ControllerProtocol {
    
    var delegate:ViewModelProtocol?
    var dashServiceVAR:DashboardServices?
    
    
    func CallToController() -> Void {
        dashServiceVAR = DashboardServices()
        dashServiceVAR?.delegate = self
        dashServiceVAR?.CallToService()
        
        
    }
    
    func callToController1() -> Void {
        dashServiceVAR?.callToServices1()
    }
    
    func callToController2(timeStamp1:Double) -> Void {
        dashServiceVAR?.callServices2(timestamp: timeStamp1)
    }
    
    func recievePickerDataFromServices(arrayMonth:NSMutableArray, arrayYear:NSMutableArray) -> Void {
        delegate?.recievePickerDataFromController(arrayMonth: arrayMonth, arrayYear: arrayYear)
    }
    
    func recieveDashboardDataFromServices(markedData:Int?, unmarkedData:String?, attendanceFallNumber:Int?, leave1:String?, totalEmployee11 totalEmployee1:Int?, timeStamp:CLong?) -> Void {
        
        delegate?.recieveDashboardDataFromController(markedData: markedData, unmarkedData: unmarkedData, attendanceFallNumber: attendanceFallNumber, leave1: leave1, totalEmployee11: totalEmployee1, timeStamp: timeStamp)
    }
    
    func recieveMonthlyAttendanceDataFromServices(perDayAttendance1:NSArray, totalEmp:Int?) -> Void {
        
        delegate?.recieveMonthlyAttendanceDataFromController(perDayAttendance1: perDayAttendance1, totalEmp:totalEmp)
    }
    
    func recieveMonthlyAttendanceDataFromServices11(perDayAttendance1:NSArray, totalEmp:Int?) -> Void {
        
        delegate?.recieveMonthlyAttendanceDataFromController11(perDayAttendance1: perDayAttendance1, totalEmp: totalEmp)
    }

    
    func recieveUnmarkedAttendanceDataFromServices(unmarkedEmp1:[UnmarkedEmployee], totalEmployee2:String?) -> Void {
        
        delegate?.recieveUnmarkedAttendanceDataFromControlletr(unmarkedEmp1: unmarkedEmp1, totalEmployee2: totalEmployee2)
    }

}
