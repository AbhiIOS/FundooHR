//
//  DashboardServices.swift
//  FundooHR
//
//  Created by BridgeLabz Solutions LLP  on 12/29/16.
//  Copyright © 2016 BridgeLabz Solutions LLP . All rights reserved.
//

import UIKit
import CoreData
import Alamofire

class DashboardServices: NSObject {
    
    var pDelegate:ControllerProtocol?
    
    
    var mFallOutNum:Int?
    var mTotalEmployee:Int?
    var mMarked:Int?
    var mUnmarked:String?
    var mLeave:String?
    
    var mTotalEmployee2:String?
    var mUnmarkedNumber:String?
    var mUnmarkedEmployee:NSArray = []
    var mUnmark:[UnmarkedEmployee]?
    
    var mMonthlyAttendance:NSArray = []
    var mPerDayAttendance:NSMutableArray = []
    var mTotalEmp:Int?
    var mToken:String?
    var mTimeStamp:Int?
    var mTimeStamp2:CLong?
    var mIPAddr:String?
    
    var mMonthArray:NSMutableArray = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    var mYearArray:NSMutableArray = ["2016", "2017", "2018", "2019", "2020", "2021", "2022", "2023", "2024", "2025", "2026", "2027", "2028", "2029", "2030", "2031", "2032", "2033", "2034", "2035", "2036", "2037"]
    
    var mUtil = Utility()
    
    
    init(controllerProtocolObj:ControllerProtocol) {
        super.init()
        pDelegate = controllerProtocolObj
    }
    
    func CallToService() -> Void {
        
        self.pDelegate?.recievePickerDataFromServices(arrayMonth: self.mMonthArray, arrayYear: self.mYearArray)
        
        mIPAddr = mUtil.populateData(keyUrl: "RestUrl")
        mToken = mUtil.fetchToken()
        
        mTimeStamp = Int(Date().timeIntervalSince1970 * 1000)
        print(mTimeStamp!)
        
        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        let url = URL(string: "\(mIPAddr!)readDashboardData?token=\(mToken!)&timeStamp=\(mTimeStamp!)")!
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            
            if error != nil {
                
                print(error!.localizedDescription)
                
            } else {
                
                do {
                    
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]
                    {
                        
                        //Implement your logic
                        let dashboardData = json as NSDictionary
                        
                        print(dashboardData)
                        
                        self.mTimeStamp2 = dashboardData["timeStamp"] as? CLong
                        print(self.mTimeStamp2!)
                        let attendanceSummary = dashboardData["attendanceSummary"] as! NSDictionary
                        self.mMarked = attendanceSummary["marked"] as? Int
                        self.mUnmarked = attendanceSummary["unmarked"] as? String
                        
                        let attendanceFallout = dashboardData["attendanceFallout"] as! NSDictionary
                        self.mFallOutNum = attendanceFallout["falloutEmployee"] as? Int
                        self.mTotalEmployee = attendanceFallout["totalEmployee"] as? Int
                        
                        let leaveSummary = dashboardData["leaveSummary"] as! NSDictionary
                        self.mLeave = leaveSummary["leave"] as? String
                        
                        self.pDelegate?.recieveDashboardDataFromServices(markedData: self.mMarked, unmarkedData: self.mUnmarked, attendanceFallNumber: self.mFallOutNum, leave1: self.mLeave, totalEmployee11: self.mTotalEmployee, timeStamp: self.mTimeStamp2)
                        
 
                    }
                    
                } catch {
                    
                    print("error in JSONSerialization")
                    
                }
                
                
            }
            
        })
        task.resume()
        
    }
    
    func callToServices1(timeStamp:Int) -> Void {
        
        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        let url = URL(string: "\(mIPAddr!)readMonthlyAttendanceSummary?token=\(mToken!)&timeStamp=\(timeStamp)")!
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            
            if error != nil {
                
                print(error!.localizedDescription)
                
            } else {
                
                do {
                    
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]
                    {
                        
                        //Implement your logic
                        let monthlyAttendance = json as NSDictionary
                        self.mTotalEmp = monthlyAttendance["totalEmployee"] as? Int
                        self.mMonthlyAttendance = monthlyAttendance["attendance"] as! NSArray
                        for ary in self.mMonthlyAttendance
                        {
                            let attendance = ary as! NSDictionary
                            self.mPerDayAttendance.add(attendance)
                            
                        }
                        print(self.mPerDayAttendance)
                        let sortedArray = self.mPerDayAttendance.sorted{(($0 as! NSDictionary)["day"]as? Int)!<(($1 as! NSDictionary)["day"]as? Int)!}
                        print(sortedArray)
                        
                        self.pDelegate?.recieveMonthlyAttendanceDataFromServices(perDayAttendance1: sortedArray as NSArray, totalEmp: self.mTotalEmp)
                    }
                    
                } catch {
                    
                    print("error in JSONSerialization")
                    
                }
                
                
            }
            
        })
        task.resume()
        
    }
    
    }
    

