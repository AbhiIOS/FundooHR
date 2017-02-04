//
//  DashboardDataModel.swift
//  FundooHR
//
//  Purpose:
//  1. It is a DataModel class of Dashboard
//  2. It stores all data required by the dashboard
//
//  Created by BridgeLabz Solutions LLP  on 2/3/17.
//  Copyright © 2017 BridgeLabz Solutions LLP . All rights reserved.
//

import UIKit

class DashboardDataModel: NSObject {
    
    var mMarkedData:Int?                //Var to store marked attendance data
    var mUnmarkedData:String?           //Var to store unmarked attendance data
    var mAttendanceFallNumber:Int?      //Var to store data of attendance fallout
    var mLeave1:String?                 //Var to store data of number of leave
    var mTotalEmployee1:Int?            //Var to store total number of employee
    var mTimeStamp:CLong?               //Var to store timestamp
    
    //Constructor of Dashboard DataModel
    init(markedData:Int, unmarkedData:String, fallNum:Int, leave:String, totalEmp:Int, timestamp:CLong) {
        
        self.mMarkedData = markedData
        self.mUnmarkedData = unmarkedData
        self.mAttendanceFallNumber = fallNum
        self.mLeave1 = leave
        self.mTotalEmployee1 = totalEmp
        self.mTimeStamp = timestamp
    }

}
