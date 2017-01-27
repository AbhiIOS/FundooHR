//
//  ViewController.swift
//  FundooHR
//
//  Purpose:
//  1. It contains all IBOutlets & IBActions of Login page
//  2. It listens to all UIActions
//  3. This is the Login page in a MVVM design
//
//  Created by BridgeLabz Solutions LLP  on 12/7/16.
//  Copyright © 2016 BridgeLabz Solutions LLP . All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {
    
    //Outlet of Company image
    @IBOutlet weak var mBridgeLabImage: UIImageView!
    
    //Outlet of a Login view
    @IBOutlet weak var mLoginView: UIView!
    
    //Outlet of Login Button
    @IBOutlet weak var mLoginBtn: UIButton!
    
    //Outlet of Email Textfield
    @IBOutlet weak var mEmailTextField: UITextField!
    
    //Oulet of Password Textfield
    @IBOutlet weak var mPasswordField: UITextField!
    
    //Outlet of Activity Indicator
    @IBOutlet weak var mActivityLoader:UIActivityIndicatorView!
   
    
    //Var to store object of Login View Model
    var mLognVM:LoginViewModel?
   
    //Var to store token value in a string format
    var mLoginToken:String?
    
    //Var to store user emailId in string format
    var mEmail:String?
    
    //Initialise Utility
    var mUtil = Utility()
    
    //Executes when Screen gets loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Observer to get notified when device orientation is changed
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        
        //set Shadow to UIView
        mUtil.setShadowAttribute(myView: mLoginView, shadowOpacity: 0.4, shadowRadius: 1.3)
        
        //set Shadow to Image
        mUtil.setShadowAttribute(myView: mBridgeLabImage, shadowOpacity: 0.5, shadowRadius: 2.0)

        mEmailTextField.underlined()
        mPasswordField.underlined()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Method executes when device orientation is changed
    func rotated()
    {
        if UIDeviceOrientationIsLandscape(UIDevice.current.orientation)
        {
            mEmailTextField.underlined()
            mPasswordField.underlined()
        }
        
        if UIDeviceOrientationIsPortrait(UIDevice.current.orientation)
        {
            mEmailTextField.underlined()
            mPasswordField.underlined()
        }
    }
    
    //Method executes when Login button is pressed
    @IBAction func loginBtnPressed(_ sender: Any) {
        
        mEmail = mEmailTextField.text
        print(mEmail!)
        let password = mPasswordField.text
        var check:String?
        
        //verifying if emailfield & password field is nil
        if mEmailTextField.text! == "" || mPasswordField.text! == "" {
            if mEmailTextField.text == "" {
                check = "Please Enter the emailID"
                mEmailTextField.text = ""
            }
            if mPasswordField.text == ""
            {
                if check != nil { check! += " & password" }
                else
                {
                    check = "Please Enter the password"
                }
                mPasswordField.text = ""
            }
            
            mUtil.displayErrorMessage(message: check!, view: self)

        }
        else
        {
            if mUtil.isValidLoginCredential(emailId: mEmail!, password:password!) {
                
                mLognVM = LoginViewModel(loginViewControllerObj: self, emailID: mEmail!, password: password!)
                self.mActivityLoader.isHidden = false
                self.mActivityLoader.startAnimating()
                mLognVM?.callLoginVM()
            }
            else
            {
            mUtil.displayErrorMessage(message: "Please Enter valid EmailID & Password", view: self)
            mEmailTextField.text = ""
            mPasswordField.text = ""
            }
        }
        
    }
    
    //Response for successfull Login
    func LoginResponse(tokn1:String, status:Int, messg:String) -> Void {
        if status == 200 {
            mLoginToken = tokn1
            self.saveInUserDefaults(saveToken: tokn1, emailID: mEmail!)
            self.mActivityLoader.stopAnimating()
            self.mActivityLoader.isHidden = true
            self.performSegue(withIdentifier: "loginSeg", sender: nil)
            
        }
    }
    
    //Saving token value to NSUserDefaults
    func saveInUserDefaults(saveToken:String, emailID:String) -> Void {
        
        let preferences = UserDefaults.standard
        
        preferences.setValuesForKeys(["tokenData": saveToken])
        preferences.setValuesForKeys(["emailID": emailID])
        
        //  Save to disk
        preferences.synchronize()
                
    }
    
    //Method executes when any error occurs
    func errorMessage() -> Void {
        
        self.mActivityLoader.stopAnimating()
        self.mActivityLoader.isHidden = true

        mUtil.displayErrorMessage(message: "Something Wrong Happened", view: self)
    }
    
    
    
}

