//
//  LoginController.swift
//  FundooHR
//
//  Purpose:
//  1. It is Controller Class of Login ViewController
//  2. It implements delegate pattern to pass data
//     from LoginController to LoginViewModel

//  Created by BridgeLabz Solutions LLP  on 1/6/17.
//  Copyright © 2017 BridgeLabz Solutions LLP . All rights reserved.
//

import UIKit

class LoginController: NSObject, LoginContrllrProtocol {
    
    //Var to hold object of LoginServices
    var mLoginServc:LoginServices?
    
    //Var to hold object of LoginVMProtocol
    var pDelegate:LoginVMProtocol?
    
    //Constructor of LoginController Class
    init(loginVMProtocolObj:LoginVMProtocol) {
        super.init()
        pDelegate = loginVMProtocolObj
        mLoginServc = LoginServices(loginControllerObj: self)
    }
    
    //Method calling a Login REST API
    func callLoginContrllr(email:String, password:String) -> Void {
        
//        mLoginServc?.delegate = self
        mLoginServc?.userLogin(Useremail: email, userPswd: password)
    }
    
    //Passing login data from LoginController to LoginViewModel
    func recieveLoginStatus(token:String, status:Int, message:String) -> Void {
        
        pDelegate?.userLoginStatus(token1: token, status1: status, message1: message)
    }
    
    //Method to display error message to user
    func errorMessageCNTRLR() -> Void {
        pDelegate?.errorMessageVM()
    }

}
