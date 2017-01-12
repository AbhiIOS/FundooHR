//
//  LoginController.swift
//  FundooHR
//
//  Created by BridgeLabz Solutions LLP  on 1/6/17.
//  Copyright © 2017 BridgeLabz Solutions LLP . All rights reserved.
//

import UIKit

class LoginController: NSObject, LoginContrllrProtocol {
    
    var loginServc:LoginServices?
    var delegate:LoginVMProtocol?
    
    func callLoginContrllr(email:String, password:String) -> Void {
        loginServc = LoginServices()
        loginServc?.delegate = self
        loginServc?.userLogin(Useremail: email, userPswd: password)
    }
    
    func recieveLoginStatus(token:String, status:Int, message:String) -> Void {
        
        delegate?.userLoginStatus(token1: token, status1: status, message1: message)
    }
    
    func errorMessageCNTRLR() -> Void {
        delegate?.errorMessageVM()
    }

}
