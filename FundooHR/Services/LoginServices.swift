//
//  LoginServices.swift
//  FundooHR
//
//  Created by BridgeLabz Solutions LLP  on 1/6/17.
//  Copyright © 2017 BridgeLabz Solutions LLP . All rights reserved.
//

import UIKit
import Alamofire

class LoginServices: NSObject {
    
    var delegate:LoginContrllrProtocol?
    var dashServ:DashboardServices?
    
    func userLogin(Useremail:String, userPswd:String) -> Void {
        
         dashServ = DashboardServices()
        
        let urlString: String = "http://192.168.0.171:3000/login"
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
                        self.delegate?.errorMessageCNTRLR()
                    }
                    else
                    {
                        let token = json["token"] as! String
                        let status = json["status"] as! Int
                        let message = json["message"] as! String
                        
                        self.delegate?.recieveLoginStatus(token: token, status: status, message: message)
                    }
                    
               
        }
        print("Hello")
        
    }

  }
    
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
