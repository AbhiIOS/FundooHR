//
//  SlideMenuViewController.swift
//  FundooHR
//
//  Purpose:
//  1. This is the main UIClass of Slide Menu
//  2. It holds all IBOutlets & IBActions of Slide Menu

//  Created by BridgeLabz Solutions LLP  on 12/15/16.
//  Copyright © 2016 BridgeLabz Solutions LLP . All rights reserved.
//

import UIKit
import CoreData

class SlideMenuViewController: UIViewController {

    //Outlet for Table View
    @IBOutlet weak var mSlideTableView: UITableView!
    
    //Outlet for label to display EmailId
    @IBOutlet weak var mSliderEmailLabel: UILabel!
    
    
    //Var to store DashboardViewController Object
    var mDashBoard:DashboardViewController?
    //Var to store Login View Controller Object
    var mUtil:Utility?
    //Var to store emailID
    var mEmailIdLabel:String?
    
    //Initialised Array of Strings
    var mArray = ["Dashboard","Engineers","Attendance Summary","Reports","Clients"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initialised Utility class Object
        mUtil = Utility()
        
        //set SlideTableView datasource to the self
        mSlideTableView.dataSource = self
        
        //set SlideTableView delegate to the self
        mSlideTableView.delegate = self
        
        //Fetching the emailId From userDefaults & storing the return value to a variable
        let emailid = mUtil?.getUserDefaultData(key: "emailID")
        
        //set text to label
        mSliderEmailLabel.text = emailid!
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //Method Executes when Log Out Button is pressed
    @IBAction func logOut(_ sender: Any) {
        
        let alert = UIAlertController(title: "Alert", message: "Do you want to logout", preferredStyle: UIAlertControllerStyle.alert)
        
        let yes = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            
            //Instantiating the View Controller by using StoryboardID
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
            
            self.present(viewController, animated: false, completion: nil)
        }
        
        let cancel = UIAlertAction(title: "No", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
        }
        
        alert.addAction(yes)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
            var indexpath:IndexPath?
            indexpath = mSlideTableView.indexPathForSelectedRow
        if indexpath?.row == 0 {
            let dash = segue.destination as! DashboardViewController
            let name = mArray[(indexpath?.row)!]
            dash.mFieldName = name
            dash.mCheckVar = false
            dash.mCheck = false
            dash.mIndex = (indexpath?.row)!
        }
        
//        let dash = segue.destination as! DashboardViewController
//        let name = mArray[(indexpath?.row)!]
//        dash.mFieldName = name
//        dash.mBoolVar = false
//        dash.mBool = false
//        dash.mIndex = (indexpath?.row)!
        
    }
    

}

// MARK: DATASOURCE METHOD FOR TABLE VIEW

extension SlideMenuViewController:UITableViewDataSource
{
    //Set Number of sections in Table View
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //Set number of rows in a Section of Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mArray.count
    }
    
    //Initialising the cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell") as! SlideMenuTableViewCell
        
        cell.mLabel.text = mArray[indexPath.row]
        return cell
        
    }
}

extension SlideMenuViewController:UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0
        {
            self.performSegue(withIdentifier: "dashboard", sender: nil)
            
        }
        if indexPath.row == 2 {
            
            self.performSegue(withIdentifier: "calendar", sender: nil)
//            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "calendarViewController")
//            
//            self.present(viewController, animated: false, completion: nil)
        }
    }
}
