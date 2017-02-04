//
//  Protocols.swift
//  FundooHR
//
//  Purpose:
//  1. It is a Protocol class

//  Created by BridgeLabz Solutions LLP  on 12/29/16.
//  Copyright © 2016 BridgeLabz Solutions LLP . All rights reserved.
//

import Foundation
import UIKit

//Protocol for Dashboard ViewModel
protocol DashboardViewModelProtocol {
    
    
    func DashboardDataResponse(dashDataModel:DashboardDataModel)
    
    func errorMessageVM()
}

//Protocol for Dashboard Controller
protocol DashboardControllerProtocol {
    
    func recieveDashboardData(dashDataModel:DashboardDataModel)
    
    func errorMessageCNTRLR()
}

//Protocol for Login ViewModel
protocol LoginViewModelProtocol {
    
    func userLoginStatus(token1:String, status1:Int, message1:String)
    func errorMessageVM(message:String)
}

//Protocol for Login Controller
protocol LoginContrllrProtocol {
    
    func recieveLoginStatus(token:String, status:Int, message:String)
    func errorMessageCNTRLR(message:String)
}

//Protocol for Login View
protocol LoginViewProtocol {
    func LoginResponse(tokn1:String, status:Int, messg:String)
    func errorMessage(message:String)
}

//Protocol for Dashboard View
protocol DashboardViewProtocol {
    func reloadAttendance()
    func errorMessage()
}
