//
//  LoginViewModel.swift
//  FundooHR
//
//  Purpose:
//  1. It is ViewModel Class of Login ViewController

//  Created by BridgeLabz Solutions LLP  on 1/6/17.
//  Copyright © 2017 BridgeLabz Solutions LLP . All rights reserved.
//

import UIKit

class LoginViewModel: NSObject, LoginViewModelProtocol {
    
    //Var to store object of LoginController
    var mLoginCntrllr:LoginController?
    
    //Var to store object of LoginViewController
    var mLoginVC:LoginViewProtocol?
    
    //Var holds token data
    var mTokn:String?
    
    //var to store login status data
    var mLoginStatus:Int?
    
    //Var to store login message data
    var mLoginMssg:String?
    
    //Var to store user EmailID
    var mEmail:String?
    
    //Var to store user password
    var mPasssword:String?
    
    //Constructor of LoginViewModel Class
    init(loginViewControllerObj:LoginViewProtocol, emailID:String, password:String) {
        super.init()
        mLoginVC = loginViewControllerObj
        mEmail = emailID
        mPasssword = password
        mLoginCntrllr = LoginController(loginVMProtocolObj: self)
    }
    
    //Method calling a function of LoginController
    func sendLoginCredentials() -> Void {
        
        mLoginCntrllr?.userLoginAccess(email: mEmail!, password: mPasssword!)
    }
    
    //Validating User Login
    func userLoginStatus(token1:String, status1:Int, message1:String) -> Void {
        self.mTokn = token1
        self.mLoginStatus = status1
        self.mLoginMssg = message1
        
        if mTokn != nil && mLoginStatus != 0 && mLoginMssg != nil {
            mLoginVC?.LoginResponse(tokn1: mTokn!, status: mLoginStatus!, messg: mLoginMssg!)
        }
        else
        {
            self.sendLoginCredentials()
        }
    }
    
    //Display Error message to user
    func errorMessageVM() -> Void {
        mLoginVC?.errorMessage()
    }

}
