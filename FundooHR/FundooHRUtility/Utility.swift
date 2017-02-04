//
//  Utility.swift
//  FundooHR
//
//  Purpose:
//  1. It is a Utility Class
//  2. It holds a reusable methods

//  Created by BridgeLabz Solutions LLP  on 1/21/17.
//  Copyright © 2017 BridgeLabz Solutions LLP . All rights reserved.
//

import Foundation
import UIKit

class Utility: UIViewController {
    
    //Method for setting shadow attribute to a view
    func setShadowAttribute(myView:UIView, shadowOpacity:Double, shadowRadius:Double)
    {
        myView.layer.shadowColor = UIColor.black.cgColor
        myView.layer.shadowOpacity = Float(shadowOpacity)
        myView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        myView.layer.shadowRadius = CGFloat(shadowRadius)
    }
    
    //Method for configuring a UICollectionView Cell
    func configureCell(cell:DashCollectionViewCell, title:Bool, marked:Bool, unmarked:Bool, number:Bool, date:Bool, totNumber:Bool, markedData:Bool, unmarkedData:Bool, menu:Bool)
    {
        cell.mTitleLabel.isHidden = title
        cell.mMarkedLabel.isHidden = marked
        cell.mUnmarkedLabel.isHidden = unmarked
        cell.mAttendanceFallLabel.isHidden = number
        cell.mDateLabel.isHidden = date
        cell.mTotalNumberLabel.isHidden = totNumber
        cell.mMarkedAttendanceData.isHidden = markedData
        cell.mUnmarkedAttendanceData.isHidden = unmarkedData
        cell.mMenuButton.isEnabled = menu
        cell.mMarkedAttendanceData.layer.masksToBounds = !markedData
        cell.mUnmarkedAttendanceData.layer.masksToBounds = !unmarkedData
    }
    
    //Method to display Error alertView to user
    func displayErrorMessage(message:String, view:UIViewController)
    {
        let alertView = UIAlertController.init(title: "ERROR !!!!!", message: message, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction.init(title: "Ok", style: .default, handler: nil)
        alertView.addAction(action)
        view.present(alertView, animated: true, completion:nil)
    }
    
    //Method for validating user emailId & user password
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
    
    //Method to get data from UserDefaults
    func getUserDefaultData(key:String) -> String
    {
        let preferences = UserDefaults.standard
        let mData = preferences.string(forKey: key)
        print(mData!)
        return mData!
    }
    
    //Method to fetch token value from userDefaults
    func fetchToken() -> String
    {
        let preferences = UserDefaults.standard
        let mToken = preferences.string(forKey: "tokenData")
        print(mToken!)
        return mToken!
    }

    //Method to get url from plist
    func populateData(keyUrl:String) -> String {
        
        let path = Bundle.main.path(forResource: "Url", ofType: "plist")
        let dict = NSDictionary(contentsOfFile: path!)
        let url1 = dict?[keyUrl] as! String
        print(url1)
        return url1
    }
    
    //Method to save data in userDefaults
    func userDefaultsData(obj:DashboardViewModel) -> Void {
        
        let preferences = UserDefaults.standard
        
        preferences.setValuesForKeys(["dashVm": obj])
        
        //  Save to disk
        preferences.synchronize()
    }
    
    //Method to perform Logout action
    func logout(view:UIViewController) -> Void {
        
        let alert = UIAlertController(title: "Alert", message: "Do you want to logout", preferredStyle: UIAlertControllerStyle.alert)
        
        let yes = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            
            //Instantiating the View Controller by using StoryboardID
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
            
            view.present(viewController, animated: false, completion: nil)
        }
        
        let cancel = UIAlertAction(title: "No", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
        }
        
        alert.addAction(yes)
        alert.addAction(cancel)
        view.present(alert, animated: true, completion: nil)

    }
    
    //Method to get slide menu details from plist
    func getSlideMenuDetail() -> NSArray {
        
        let path = Bundle.main.path(forResource: "SlideMenu", ofType: "plist")
        let array = NSArray(contentsOfFile: path!)
        print(array!)
        return array!
    }
}
