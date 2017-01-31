//
//  CalendarServices.swift
//  FundooHR
//
//  Created by BridgeLabz Solutions LLP  on 1/29/17.
//  Copyright © 2017 BridgeLabz Solutions LLP . All rights reserved.
//

import UIKit

class CalendarServices: NSObject {
    
    //Var to store delegate(protocol) object
    var pDelegate:CalendarControllerProtocol?
    
    //Var to store IP Address
    var mIPAddr:String?
    
    //Var to store token
    var mToken:String?
    
    //Var to store number of total employee
    var mTotalEmp:Int?
    
    //Var to store data of monthly attendance in array
    var mMonthlyAttendance:NSArray = []
    
    //Var to store data of each day attendance in array
    var mPerDayAttendance:NSMutableArray = []
    
    
    //array holding the names of months
    var mMonthArray:NSMutableArray = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    //array holding the years
    var mYearArray:NSMutableArray = ["2016", "2017", "2018", "2019", "2020", "2021", "2022", "2023", "2024", "2025", "2026", "2027", "2028", "2029", "2030", "2031", "2032", "2033", "2034", "2035", "2036", "2037"]
    
    //Initialised utility object
    var mUtil = Utility()
    
    //Constructor of CalendarServices
    init(controllerProtocolObj:CalendarControllerProtocol) {
        super.init()
        pDelegate = controllerProtocolObj
    }

    //Method making a REST call to get Monthly Attendance data from server
    func monthlyAttendanceRestService(timeStamp:Int) -> Void {
        
        //protocol sending picker data from CalendarServices to CalendarController
        self.pDelegate?.recievePickerData(arrayMonth: self.mMonthArray, arrayYear: self.mYearArray)
        
        //Get IP Address from Plist
        mIPAddr = mUtil.populateData(keyUrl: "RestUrl")
        
        //Get token value from UserDefaults
        mToken = mUtil.getUserDefaultData(key: "tokenData")

        
        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        let url = URL(string: "\(mIPAddr!)readMonthlyAttendanceSummary?timeStamp=\(timeStamp)")!
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
                        
                        self.pDelegate?.recieveMonthlyAttendanceData(perDayAttendance1: sortedArray as NSArray, totalEmp: self.mTotalEmp)
                    }
                    
                } catch {
                    
                    print("error in JSONSerialization")
                    
                }
            }
            
        })
        task.resume()
        
    }

}
