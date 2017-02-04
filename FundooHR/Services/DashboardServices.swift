//
//  DashboardServices.swift
//  FundooHR
//
//  Purpose:
//  1. It is a Services class of Dashboard
//  2. It makes a REST call to get Dashboard Data & Monthly Attendance Data
//  3. It implements a Delegate pattern to pass data from DashboardServices 
//     to DashboardController

//  Created by BridgeLabz Solutions LLP  on 12/29/16.
//  Copyright © 2016 BridgeLabz Solutions LLP . All rights reserved.
//

import UIKit
import CoreData
import Alamofire

class DashboardServices: NSObject {
    
    //Var to store delegate(protocol) object
    var pDelegate:DashboardControllerProtocol?
    
    //Var to store data of number of fallout employee
    var mFallOutNum:Int?
    
    //Var to store number of total employee
    var mTotalEmployee:Int?
    
    //Var to store data of marked attendance
    var mMarked:Int?
    
    //Var to store data of unmarked attendance
    var mUnmarked:String?
    
    //Var to store data of number of leave
    var mLeave:String?
    
    //Var to store data of monthly attendance in array
    var mMonthlyAttendance:NSArray = []
    
    //Var to store data of each day attendance in array
    var mPerDayAttendance:NSMutableArray = []
    
    //Var to store number of total employee
    var mTotalEmp:Int?
    
    //Var to store token
    var mToken:String?
    
    //Var to store timestamp
    var mTimeStamp:Int?
    
    //Var to store timestamp
    var mTimeStamp2:CLong?
    
    //Var to store IP Address
    var mIPAddr:String?
    
    //Initialised utility object
    var mUtil = Utility()
    
    //Constructor of DashboardServices
    init(controllerProtocolObj:DashboardControllerProtocol) {
        super.init()
        pDelegate = controllerProtocolObj
    }
    
    //Method making a REST call to get Dashboard data from server
    func dashboardRestService() -> Void {
        
        //Get IP Address from Plist
        mIPAddr = mUtil.populateData(keyUrl: "RestUrl")
        
        //Get token value from UserDefaults
        mToken = mUtil.getUserDefaultData(key: "tokenData")
        
        //Generating timestamp from current date
        mTimeStamp = Int(Date().timeIntervalSince1970 * 1000)
        print(mTimeStamp!)
        
        //Making REST call
        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        let url = URL(string: "\(mIPAddr!)readDashboardData?timeStamp=\(mTimeStamp!)")!
        var request = URLRequest(url: url)
        request.addValue(mToken!, forHTTPHeaderField: "x-token")
        
        let task = session.dataTask(with: request, completionHandler: {
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
                        
                        //Saving timestamp from json
                        self.mTimeStamp2 = dashboardData["timeStamp"] as? CLong
                        print(self.mTimeStamp2!)
                        
                        //Get data of attendance summary from json
                        let attendanceSummary = dashboardData["attendanceSummary"] as! NSDictionary
                        
                        //Saving marked attendance data from json
                        self.mMarked = attendanceSummary["marked"] as? Int
                        //Saving unmarked attendance data from json
                        self.mUnmarked = attendanceSummary["unmarked"] as? String
                        
                        //Get data of attendance fallout from json
                        let attendanceFallout = dashboardData["attendanceFallout"] as! NSDictionary
                        
                        self.mFallOutNum = attendanceFallout["falloutEmployee"] as? Int
                        self.mTotalEmployee = attendanceFallout["totalEmployee"] as? Int
                        
                        let leaveSummary = dashboardData["leaveSummary"] as! NSDictionary
                        self.mLeave = leaveSummary["leave"] as? String
                        
                        let dashboardDataModel1 = DashboardDataModel(markedData: self.mMarked!, unmarkedData: self.mUnmarked!, fallNum: self.mFallOutNum!, leave: self.mLeave!, totalEmp: self.mTotalEmployee!, timestamp: self.mTimeStamp2!)
                        
                        self.pDelegate?.recieveDashboardData(dashDataModel:dashboardDataModel1)
                        
                        
                    }
                    
                } catch {
                    
                    print("error in JSONSerialization")
                    
                }
            }
        })
        task.resume()
        
    }
    
}
    

