//
//  DashboardViewModel.swift
//  FundooHR
//
//  Purpose:
//  1. It is View Model Class of Dashboard ViewController
//  2. It stores all data required by the Dashboard
//  3. It implements Delegate pattern to pass the data

//  Created by BridgeLabz Solutions LLP  on 12/29/16.
//  Copyright © 2016 BridgeLabz Solutions LLP . All rights reserved.
//
import Foundation
import UIKit

//Var to store names of months in array
var mMonthsAry:NSMutableArray?

//Var to store years in array
var mYearAry:NSMutableArray?

//Var to store marked Attendance data
var mMarkedAttdendance:String!

//Var to store unmarked Attendance data
var mUnmarkedAttendance:String!

//Var to store number of fallout Employee
var mAttendanceFallNumberLabel:String!

//Var to store data of number of people taken leave
var mLeave:String!

//Var to store number of total Employee
var mTotalEmployee:String?

//Var to store number of total Employee
var mTotalEmployee1:String?

//Var to store number of total employee
var mTotalEmployee3:String?

//Var to store per day attendance data in array
var mPerDayAttendance:NSArray = []

//Var to store number of unmarked Employee in array
var mUnmarkedEmpArray:[UnmarkedEmployee]?

//var to store timestamp
var mJsonTimeStamp:CLong?

//a boolean variable
var mTemp:Bool = true


class DashboardViewModel: NSObject, ViewModelProtocol {

    //Var to store object of DashboardController
    var mDashCONVAR:DashboardController?
    
    //Var to store object of DashboardViewController
    var mDashboard:DashboardViewController?
    
    //Var to store object of LoginViewController
    var mLoginScreen:LoginViewController?
    
    //var holding int value
    var i:Int = 0
    var j:Int = 0
    
    //Var to store data of number of employee absent
    var mAbsent:NSDictionary!
    
    //Constructor of DashboardViewModel Class
    init(dashboardVCObj:DashboardViewController) {
        super.init()
        mDashboard = dashboardVCObj
        
        //Initialise object of DashboardController
        mDashCONVAR = DashboardController(viewModelProtocolObj: self)
    }
    
    //Method calls a function of DashboardController
    func CallToViewModel() -> Void {
        
        //Set DashboardController delegate(variable of ViewModel protocol type) to self
        mDashCONVAR?.pDelegate = self
        
        //Method calling a function of DashboardController
        mDashCONVAR?.CallToController()
    }
    
    //Method calling a function of DashboardController by passing timestamp as parameter
    func viewModelCall(timeStamp:Int) -> Void {
        mDashCONVAR?.callToController1(timeStamp: timeStamp)
    }

    //Method Executes when custom picker data recieved from controller
    func recievePickerDataFromController(arrayMonth:NSMutableArray, arrayYear:NSMutableArray) -> Void {
        mMonthsAry = arrayMonth
        mYearAry = arrayYear
    }
    
    //Saving Dashboard Data recieved from Controller
    func recieveDashboardDataFromController(markedData:Int?, unmarkedData:String?, attendanceFallNumber:Int?, leave1:String?, totalEmployee11:Int?, timeStamp:CLong?) -> Void {
        mMarkedAttdendance = String(describing: markedData!)
        mUnmarkedAttendance = String(describing: unmarkedData!)
        mAttendanceFallNumberLabel = String(describing: attendanceFallNumber!)
        mLeave = String(describing: leave1!)
        mTotalEmployee = String(describing: totalEmployee11!)
        print(mTotalEmployee!)
        mJsonTimeStamp = timeStamp!
        mDashboard?.reloadAttendance()
        let timeStamp2 = Int(Date().timeIntervalSince1970 * 1000)
        mDashCONVAR?.callToController1(timeStamp: timeStamp2)
    }
    
    //Saving Monthly Attendance data recieved from controller
    func recieveMonthlyAttendanceDataFromController(perDayAttendance1:NSArray, totalEmp:Int?) -> Void {
        mPerDayAttendance = []
        mPerDayAttendance = perDayAttendance1
        mTotalEmployee1 = String(describing: totalEmp!)
        mDashboard?.reloadCalendar()
        i=0
        
    }
    
    
    //Populate Monthly attendance data into calendar
    func dayAttendance() -> String {
        
        mAbsent = mPerDayAttendance.object(at: i) as! NSDictionary
        let unmarkedEmp = mAbsent["unmarked"] as! String
        i+=1
        return unmarkedEmp
        
    }
    
    //Method to display error message to user
    func errorMessageVM() -> Void {
        mDashboard?.errorMessage()
    }
    
}
