//
//  ViewController.swift
//  FundooHR
//
//  Created by BridgeLabz Solutions LLP  on 12/7/16.
//  Copyright © 2016 BridgeLabz Solutions LLP . All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bridgeLabImage: UIImageView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
    

}

extension UIColor {
    public convenience init?(hexString: String) {
        let r, g, b, a: CGFloat
        
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = hexString.substring(from: start)
            
            if hexColor.characters.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}

