//
//  Utility.swift
//  FundooHR
//
//  Created by BridgeLabz Solutions LLP  on 1/21/17.
//  Copyright © 2017 BridgeLabz Solutions LLP . All rights reserved.
//

import Foundation
import UIKit

class Utility: UIViewController {
    
    func setShadowAttribute(myView:UIView, shadowOpacity:Double, shadowRadius:Double)
    {
        myView.layer.shadowColor = UIColor.black.cgColor
        myView.layer.shadowOpacity = Float(shadowOpacity)
        myView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        myView.layer.shadowRadius = CGFloat(shadowRadius)
    }
    
    func configureCell(cell:DashCollectionViewCell, title:Bool, marked:Bool, unmarked:Bool, number:Bool, date:Bool, totNumber:Bool, markedData:Bool, unmarkedData:Bool, menu:Bool)
    {
        cell.titleLabel.isHidden = title
        cell.markedLabel.isHidden = marked
        cell.unmarkedLabel.isHidden = unmarked
        cell.numberLabel.isHidden = number
        cell.dateLabel.isHidden = date
        cell.totalNumberLabel.isHidden = totNumber
        cell.markedAttendanceData.isHidden = markedData
        cell.unmarkedAttendanceData.isHidden = unmarkedData
        cell.menuButton.isEnabled = menu
        cell.markedAttendanceData.layer.masksToBounds = !markedData
        cell.unmarkedAttendanceData.layer.masksToBounds = !unmarkedData
    }
    
    func displayErrorMessage(message:String, view:UIViewController)
    {
        let alertView = UIAlertController.init(title: "ERROR !!!!!", message: message, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction.init(title: "Ok", style: .default, handler: nil)
        alertView.addAction(action)
        view.present(alertView, animated: true, completion:nil)
    }
    
    func isValidLoginCredential(emailId:String, password:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}"
        let passwordRegex = "^([a-zA-Z0-9@*#]{8,15})$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let pwdTest = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
        
        if emailTest.evaluate(with: emailId) && pwdTest.evaluate(with: password){
            return true
        }
        else{ return false }
        
    }
    
    func fetchEmail() -> String
    {
        let preferences = UserDefaults.standard
        let mEmailIdLabel = preferences.string(forKey: "emailID")
        print(mEmailIdLabel!)
        return mEmailIdLabel!
    }
    
    func fetchToken() -> String
    {
        let preferences = UserDefaults.standard
        let mToken = preferences.string(forKey: "tokenData")
        print(mToken!)
        return mToken!
    }

    func populateData(keyUrl:String) -> String {
        
        let path = Bundle.main.path(forResource: "Url", ofType: "plist")
        let dict = NSDictionary(contentsOfFile: path!)
        let url1 = dict?[keyUrl] as! String
        print(url1)
        return url1
    }
}