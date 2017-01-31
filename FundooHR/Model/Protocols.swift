//
//  Protocols.swift
//  FundooHR
//
//  Created by BridgeLabz Solutions LLP  on 12/29/16.
//  Copyright © 2016 BridgeLabz Solutions LLP . All rights reserved.
//

import Foundation
import UIKit

protocol DashboardViewModelProtocol {
    
    
    func DashboardDataResponse(markedData:Int?, unmarkedData:String?, attendanceFallNumber:Int?, leave1:String?, totalEmployee11:Int?, timeStamp:CLong?)
    
    func errorMessageVM()
}

protocol DashboardControllerProtocol {
    
    func recieveDashboardData(markedData:Int?, unmarkedData:String?, attendanceFallNumber:Int?, leave1:String?, totalEmployee11 totalEmployee1:Int?, timeStamp:CLong?)
    
    func errorMessageCNTRLR()
}

protocol LoginViewModelProtocol {
    
    func userLoginStatus(token1:String, status1:Int, message1:String)
    func errorMessageVM()
}

protocol LoginContrllrProtocol {
    
    func recieveLoginStatus(token:String, status:Int, message:String)
    func errorMessageCNTRLR()
}

protocol LoginViewProtocol {
    func LoginResponse(tokn1:String, status:Int, messg:String)
    func errorMessage()
}

protocol DashboardViewProtocol {
    func reloadAttendance()
    func errorMessage()
}
