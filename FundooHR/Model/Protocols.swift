//
//  Protocols.swift
//  FundooHR
//
//  Created by BridgeLabz Solutions LLP  on 12/29/16.
//  Copyright © 2016 BridgeLabz Solutions LLP . All rights reserved.
//

import Foundation
import UIKit

protocol ViewModelProtocol {
    
    func recievePickerDataFromController(arrayMonth:NSMutableArray, arrayYear:NSMutableArray)
    
    func recieveDashboardDataFromController(markedData:Int?, unmarkedData:String?, attendanceFallNumber:Int?, leave1:String?, totalEmployee11:Int?, timeStamp:CLong?)
    
    func recieveMonthlyAttendanceDataFromController(perDayAttendance1:NSArray, totalEmp:Int?)
    
    func recieveUnmarkedAttendanceDataFromControlletr(unmarkedEmp1:[UnmarkedEmployee], totalEmployee2:String?)
    
    func recieveMonthlyAttendanceDataFromController11(perDayAttendance1:NSArray, totalEmp:Int?)
}

protocol ControllerProtocol {
    
    func recievePickerDataFromServices(arrayMonth:NSMutableArray, arrayYear:NSMutableArray)
    
    func recieveDashboardDataFromServices(markedData:Int?, unmarkedData:String?, attendanceFallNumber:Int?, leave1:String?, totalEmployee11 totalEmployee1:Int?, timeStamp:CLong?)
    
    func recieveMonthlyAttendanceDataFromServices(perDayAttendance1:NSArray, totalEmp:Int?)
    
    func recieveUnmarkedAttendanceDataFromServices(unmarkedEmp1:[UnmarkedEmployee], totalEmployee2:String?)
    
    func recieveMonthlyAttendanceDataFromServices11(perDayAttendance1:NSArray, totalEmp:Int?)
}

protocol LoginVMProtocol {
    
    func userLoginStatus(token1:String, status1:Int, message1:String)
    func errorMessageVM()
}

protocol LoginContrllrProtocol {
    
    func recieveLoginStatus(token:String, status:Int, message:String)
    func errorMessageCNTRLR()
}
