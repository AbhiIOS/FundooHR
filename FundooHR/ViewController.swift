//
//  ViewController.swift
//  FundooHR
//
//  Created by BridgeLabz Solutions LLP  on 12/7/16.
//  Copyright © 2016 BridgeLabz Solutions LLP . All rights reserved.
//

import UIKit
import CoreData



class ViewController: UIViewController {

    @IBOutlet weak var bridgeLabImage: UIImageView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var activityLoader:UIActivityIndicatorView!
   
    
    var lognVM:LoginViewModel?
    var dashVM:DashboardViewModel?
    var loginToken:String?
    var email:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lognVM = LoginViewModel()
        lognVM?.loginVC = self
        dashVM = DashboardViewModel()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        self.secondView.layer.cornerRadius = 10
        self.loginBtn.layer.cornerRadius = 5

        self.secondView.layer.shadowColor = UIColor.black.cgColor
        self.secondView.layer.shadowOpacity = 0.4
        self.secondView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.secondView.layer.shadowRadius = 1.3
        
        self.bridgeLabImage.layer.shadowColor = UIColor.black.cgColor
        self.bridgeLabImage.layer.shadowOpacity = 0.5
        self.bridgeLabImage.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.bridgeLabImage.layer.shadowRadius = 2.0
        
        
        emailTextField.underlined()
        passwordField.underlined()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func rotated()
    {
        if UIDeviceOrientationIsLandscape(UIDevice.current.orientation)
        {
            emailTextField.underlined()
            passwordField.underlined()
        }
        
        if UIDeviceOrientationIsPortrait(UIDevice.current.orientation)
        {
            emailTextField.underlined()
            passwordField.underlined()
        }
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        
        email = emailTextField.text
        print(email!)
        let password = passwordField.text
        var check:String?
        
        if emailTextField.text! == "" || passwordField.text! == "" {
            
            if emailTextField.text == "" {
                check = "Please Enter the emailID"
                emailTextField.text = ""
            }
            else if passwordField.text == ""
            {
                check = "Please Enter the password"
                passwordField.text = ""
            }
            let alertView = UIAlertController.init(title: "ERROR !!!!!", message: check!, preferredStyle: UIAlertControllerStyle.alert)
            let action = UIAlertAction.init(title: "Ok", style: .default, handler: nil)
            alertView.addAction(action)
            self.present(alertView, animated: true, completion:nil)
        }
        else{
            
            lognVM?.email = email!
            lognVM?.passsword = password
            self.activityLoader.isHidden = false
            self.activityLoader.startAnimating()
            lognVM?.callLoginVM()
        }
        
        
//        Alamofire.request("http://192.168.0.171:3000/readDashboardData?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbkBicmlkZ2VsYWJ6LmNvbSIsImlhdCI6MTQ4NDAzMzU0NiwiZXhwIjoxNDg1MjQzMTQ2fQ.2T2njrWkL96Sb6g-JxIujlGcDP07_5fNtvTzMf8T16s&timeStamp=1484041876000").responseJSON
//            { response in
//                print("response----",response)
//                print("result----",response.result)
//                if((response.result).isSuccess){
//                    print("result-------",response.result)
//                    
//                    let json = response.result.value as! NSDictionary
//                    print(json)
        
//                    let timeStamp2 = json["timeStamp"] as! CLong
//                    
//                    let attendanceSummary = json["attendanceSummary"] as! NSDictionary
//                    self.marked = attendanceSummary["marked"] as? Int
//                    self.unmarked = attendanceSummary["unmarked"] as? Int
//                    
//                    let attendanceFallout = json["attendanceFallout"] as! NSDictionary
//                    self.fallOutNum = attendanceFallout["falloutEmployee"] as? Int
//                    self.totalEmployee = attendanceFallout["totalEmployee"] as? Int
//                    
//                    let leaveSummary = json["leaveSummary"] as! NSDictionary
//                    self.leave = leaveSummary["leave"] as? String
//                    
//                    
//                    self.delegate?.recieveDashboardDataFromServices(markedData: self.marked, unmarkedData: self.unmarked, attendanceFallNumber: self.fallOutNum, leave1: self.leave, totalEmployee11: self.totalEmployee, timeStamp: timeStamp2)
                    
              //  }
                
     //   }

        
    }
    
    func validateLogin(tokn1:String, status:Int, messg:String) -> Void {
        if status == 200 {
            loginToken = tokn1
            self.saveInCoreData(saveToken: tokn1, emailID: email!)
            self.activityLoader.stopAnimating()
            self.activityLoader.isHidden = true
            self.performSegue(withIdentifier: "loginSeg", sender: nil)
            
        }
    }
    
    func saveInCoreData(saveToken:String, emailID:String) -> Void {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let user = LoginToken1(context: context)
        user.tokenData = saveToken
        user.emailID = emailID
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
    }
    
    func errorMessage() -> Void {
        
        self.activityLoader.stopAnimating()
        self.activityLoader.isHidden = true

        let alertView = UIAlertController.init(title: "ERROR !!!!!", message: "Something Wrong Happened", preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction.init(title: "Ok", style: .default, handler: nil)
        alertView.addAction(action)
        self.present(alertView, animated: true, completion:nil)
    }
    
    
    
}

//extension UIColor {
//    public convenience init?(hexString: String) {
//        let r, g, b, a: CGFloat
//        
//        if hexString.hasPrefix("#") {
//            let start = hexString.index(hexString.startIndex, offsetBy: 1)
//            let hexColor = hexString.substring(from: start)
//            
//            if hexColor.characters.count == 8 {
//                let scanner = Scanner(string: hexColor)
//                var hexNumber: UInt64 = 0
//                
//                if scanner.scanHexInt64(&hexNumber) {
//                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
//                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
//                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
//                    a = CGFloat(hexNumber & 0x000000ff) / 255
//                    
//                    self.init(red: r, green: g, blue: b, alpha: a)
//                    return
//                }
//            }
//        }
//        
//        return nil
//    }
//}

