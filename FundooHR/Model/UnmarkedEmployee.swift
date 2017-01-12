//
//  UnmarkedEmployee.swift
//  FundooHR
//
//  Created by BridgeLabz Solutions LLP  on 1/2/17.
//  Copyright © 2017 BridgeLabz Solutions LLP . All rights reserved.
//

import UIKit

class UnmarkedEmployee: NSObject {
    
    var company:String?
    var email:String?
    var employeeName:String?
    var employeeStatus:String?
    var mobile:String?
    
    init(CompanyName company:String, Emailid email1:String, EmpName name:String, EmpStatus status:String, MobileNumber number:String)
    {
        self.company = company
        self.email = email1
        self.employeeName = name
        self.employeeStatus = status
        self.mobile = number
        
    }

}
