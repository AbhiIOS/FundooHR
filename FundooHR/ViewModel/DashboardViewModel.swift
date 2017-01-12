//
//  DashboardViewModel.swift
//  FundooHR
//
//  Created by BridgeLabz Solutions LLP  on 12/29/16.
//  Copyright © 2016 BridgeLabz Solutions LLP . All rights reserved.
//
import Foundation
import UIKit

class DashboardViewModel: NSObject, ViewModelProtocol {

//    var monthArray:NSMutableArray = []
//    var yearArray:NSMutableArray = []
    var DashCONVAR:DashboardController?
    var dashboard:DashboardViewController?
    var loginScreen:ViewController?
    var markedAttdendance:String!
    var unmarkedAttendance:String!
    var attendanceFallNumberLabel:String!
    var leave:String!
    var totalEmployee:String!
    var totalEmployee1:String?
    var totalEmployee3:String?
    var perDayAttendance:NSArray = []
    var unmarkedEmpArray:[UnmarkedEmployee]?
    var i:Int = 0
    var monthsAry:NSMutableArray?
    var yearAry:NSMutableArray?
    var tokenData:String?
    var jsonTimeStamp:CLong?
    
    func CallToViewModel() -> Void {
        
        DashCONVAR = DashboardController()
        loginScreen = ViewController()
        DashCONVAR?.delegate = self
        //tokenData = tokn
        DashCONVAR?.CallToController()
    }
    
    func viewModelCall(timeStamp:Double) -> Void {
        DashCONVAR?.callToController2(timeStamp1: timeStamp)
    }

    func recievePickerDataFromController(arrayMonth:NSMutableArray, arrayYear:NSMutableArray) -> Void {
        monthsAry = arrayMonth
        yearAry = arrayYear
    }
    
    func recieveDashboardDataFromController(markedData:Int?, unmarkedData:String?, attendanceFallNumber:Int?, leave1:String?, totalEmployee11:Int?, timeStamp:CLong?) -> Void {
        markedAttdendance = String(describing: markedData!)
        unmarkedAttendance = String(describing: unmarkedData!)
        attendanceFallNumberLabel = String(describing: attendanceFallNumber!)
        leave = String(describing: leave1!)
        totalEmployee = String(describing: totalEmployee11!)
        jsonTimeStamp = timeStamp!
        DashCONVAR?.callToController1()
    }
    
    func recieveMonthlyAttendanceDataFromController(perDayAttendance1:NSArray, totalEmp:Int?) -> Void {
        self.perDayAttendance = perDayAttendance1
        self.totalEmployee1 = String(describing: totalEmp!)
        //loginScreen?.success()
        //dashboard?.calenderView.reloadData()
    }
    
    func recieveMonthlyAttendanceDataFromController11(perDayAttendance1:NSArray, totalEmp:Int?) -> Void {
        self.perDayAttendance = perDayAttendance1
        self.totalEmployee1 = String(describing: totalEmp!)
        dashboard?.reloadCalendar()
    }
    
    func recieveUnmarkedAttendanceDataFromControlletr(unmarkedEmp1:[UnmarkedEmployee], totalEmployee2:String?) -> Void {
        self.unmarkedEmpArray = unmarkedEmp1
        self.totalEmployee3 = totalEmployee2
        
    }
    
    func dayAttendance() -> String {
        let absent = perDayAttendance.object(at: i) as! NSDictionary
        i+=1
        let unmarkedEmp = absent["unmarked"] as! String
        
        return unmarkedEmp
        
    }
    
}
