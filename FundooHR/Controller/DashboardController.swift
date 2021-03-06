//
//  DashboardController.swift
//  FundooHR
//
//  Purpose:
//  1. It is a Controller Class of Dashboard
//  2. It implements ControllerProtocol to pass data
//     from DashboardController to DashboardViewModel

//  Created by BridgeLabz Solutions LLP  on 12/29/16.
//  Copyright © 2016 BridgeLabz Solutions LLP . All rights reserved.
//

import UIKit

class DashboardController: NSObject, DashboardControllerProtocol {
    
    //Var to hold protocol object
    var pDelegate:DashboardViewModelProtocol?
    
    //Var to store DashboardServices Object
    var mDashServiceVAR:DashboardServices?
    
    //Constructor of DashboardController Class
    init(viewModelProtocolObj:DashboardViewModelProtocol) {
        super.init()
        pDelegate = viewModelProtocolObj
        mDashServiceVAR = DashboardServices(controllerProtocolObj: self)
    }
    
    //Method Calling a function of DashboardServices for making REST call
    func fetchDashboardDetails() -> Void {
        
        mDashServiceVAR?.dashboardRestService()
    }
    
    //Passing Dashboard Data from DashboardController to DashboardViewModel
    func recieveDashboardData(dashDataModel:DashboardDataModel) -> Void {
        
        pDelegate?.DashboardDataResponse(dashDataModel: dashDataModel)
    }
    
    //Display Error message to user
    func errorMessageCNTRLR() -> Void {
        pDelegate?.errorMessageVM()
    }

}
