//
//  LoginServices.swift
//  FundooHR
//
//  Purpose:
//  1. It is a Services Class of Login
//  2. It makes REST calls to get login data
//  3. It uses Delegate pattern to pass data from LoginServices to LoginController

//  Created by BridgeLabz Solutions LLP  on 1/6/17.
//  Copyright © 2017 BridgeLabz Solutions LLP . All rights reserved.
//

import UIKit
import Alamofire

class LoginServices: NSObject {
    
    //Var to hold protocol object of LoginContrllrProtocol
    var mDelegate:LoginContrllrProtocol?
    
    //Var to hold object of DashboardServices
    var mDashServ:DashboardServices?
    
    //Constructor of LoginServices class
    init(loginControllerObj:LoginContrllrProtocol) {
        
        mDelegate = loginControllerObj
    }
    
    //Method makes a REST call for Login
    func userLogin(Useremail:String, userPswd:String) -> Void {
        
        let mUtil = Utility()
        let mIPAddr = mUtil.populateData(keyUrl: "LoginUrl")
        
        let urlString: String = mIPAddr
        let params = ["emailId":  (Useremail)/*"admin@bridgelabz.com"*/, "password" : (userPswd)/*"Bridge@123"*/]
        Alamofire.request(urlString, method: .post, parameters: params, encoding: JSONEncoding.default)
            .responseJSON { response in
                print("--response--",response)
                print("result----",response.result)
                if((response.result).isSuccess){
                    print("result-------",response.result)
                    
                    let json = response.result.value as! NSDictionary
                    let check = json["token"] as Any
                    let checkStr = String(describing: check)
                    
                    if self.checkInternetConnectivity(check: checkStr)
                    {
                        self.mDelegate?.errorMessageCNTRLR()
                    }
                    else
                    {
                        let token = json["token"] as! String
                        let status = json["status"] as! Int
                        let message = json["message"] as! String
                        
                        self.mDelegate?.recieveLoginStatus(token: token, status: status, message: message)
                    }
                    
               
        }
        print("Hello")
        
    }

  }
    
    //Method checking data recieved or not
    func checkInternetConnectivity(check:String) -> Bool {
        
        if check == "Optional(<null>)"
        {
            return true
        }
        else
        {
            return false
        }

    }

}
