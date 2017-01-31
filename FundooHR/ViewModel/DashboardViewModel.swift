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

class DashboardViewModel: NSObject, DashboardViewModelProtocol {

    //Var to store object of DashboardController
    var mDashCONVAR:DashboardController?
    
    //Var to store object of DashboardViewController
    var mDashboard:DashboardViewProtocol?
    
    //Var to store object of LoginViewController
    var mLoginScreen:LoginViewController?
    
    //var holding int value
    var i:Int = 0
    
    //Var to store data of number of employee absent
    var mAbsent:NSDictionary!
    
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
    
    //var to store timestamp
    var mJsonTimeStamp:CLong?

    //Constructor of DashboardViewModel Class
    init(dashboardProtocolObj:DashboardViewProtocol) {
        super.init()
        mDashboard = dashboardProtocolObj
        
        //Initialise object of DashboardController
        mDashCONVAR = DashboardController(viewModelProtocolObj: self)
    }
    
    //Method calls a function of DashboardController
    func getDashboardData() -> Void {
        
        //Method calling a function of DashboardController
        mDashCONVAR?.fetchDashboardDetails()
    }
    
    //Saving Dashboard Data recieved from Controller
    func DashboardDataResponse(markedData:Int?, unmarkedData:String?, attendanceFallNumber:Int?, leave1:String?, totalEmployee11:Int?, timeStamp:CLong?) -> Void {
        mMarkedAttdendance = String(describing: markedData!)
        mUnmarkedAttendance = String(describing: unmarkedData!)
        mAttendanceFallNumberLabel = String(describing: attendanceFallNumber!)
        mLeave = String(describing: leave1!)
        mTotalEmployee = String(describing: totalEmployee11!)
        print(mTotalEmployee!)
        mJsonTimeStamp = timeStamp!
        mDashboard?.reloadAttendance()
    }
    
    //Method to display error message to user
    func errorMessageVM() -> Void {
        mDashboard?.errorMessage()
    }
    
}
