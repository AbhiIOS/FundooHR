//
//  LoginViewModel.swift
//  FundooHR
//
//  Created by BridgeLabz Solutions LLP  on 1/6/17.
//  Copyright © 2017 BridgeLabz Solutions LLP . All rights reserved.
//

import UIKit

class LoginViewModel: NSObject, LoginVMProtocol {
    
    var loginCntrllr:LoginController?
    var loginVC:ViewController?
    var tokn:String?
    var loginStatus:Int?
    var loginMssg:String?
    var email:String?
    var passsword:String?
    
    func callLoginVM() -> Void {
        loginCntrllr = LoginController()
        loginCntrllr?.delegate = self
        loginCntrllr?.callLoginContrllr(email: email!, password: passsword!)
    }
    
    func userLoginStatus(token1:String, status1:Int, message1:String) -> Void {
        self.tokn = token1
        self.loginStatus = status1
        self.loginMssg = message1
        
        if tokn != nil && loginStatus != 0 && loginMssg != nil {
            loginVC?.validateLogin(tokn1: tokn!, status: loginStatus!, messg: loginMssg!)
        }
        else
        {
            self.callLoginVM()
        }
    }
    
    func errorMessageVM() -> Void {
        loginVC?.errorMessage()
    }

}
