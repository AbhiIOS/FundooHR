//
//  DashboardViewController.swift
//  FundooHR
//
//  Purpose:
//  1. This is the main UIClass which holds all IBOutlets & IBActions related to 
//     dashboard
//  2. It listens to all UICalls
//  3. It holds local library for slider Menu

//  Created by BridgeLabz Solutions LLP  on 12/10/16.
//  Copyright © 2016 BridgeLabz Solutions LLP . All rights reserved.
//

import UIKit
import Firebase

enum DashboardCollectionEnum:Int {
    case ATTENDANCE_SUMMARY = 0
    case ATTENDANCE_FALLOUT
    case LEAVE_SUMMARY
    case ENGINEERS
    case CLIENTS
    case REPORTS
}

enum DashBoardTableView:Int{
    case EMAILID = 0
    case DASHBOARD
    case ENGINEERS
    case ATTENDANCESUMMARY
    case REPORTS
    case CLIENTS
    case LOGOUT
}

class DashboardViewController: UIViewController, DashboardViewProtocol {
    
    
    //Outlet of UIView
    @IBOutlet weak var mSecondaryView: UIView!
    
    //Outlet of button for sliderMenu
    @IBOutlet weak var mSlideBarBtn: UIButton!
    
    //Outlet of Dashboard Collection View
    @IBOutlet weak var mAttendanceCollection: UICollectionView!
    
    //Outlet of label to display View Name
    @IBOutlet weak var mDashLabel: UILabel!
    
    //Outlet of UIView of Dashboard
    @IBOutlet weak var mDashBoard: UIView!
    
    //Outlet of label To display Date
    @IBOutlet weak var mHeaderDateLabel: UILabel!
    
    //Outlet of Activity Indicator
    @IBOutlet weak var mActivityLoader: UIActivityIndicatorView!
    
    //Outlet of view of slide menu
    @IBOutlet weak var mSlideMenu: UIView!
    
    //Outlet of table view of slide menu
    @IBOutlet weak var mSlideTableView: UITableView!
    
    //Outlets of leading constraint of slide menu view
    @IBOutlet weak var mSlideMenuContraint: NSLayoutConstraint!
    
    var mFlag = false                       //Var to store boolean value
    var mEmailId:String?                    //Var to store user EmailId
    var mCustomView = UIView()              //creating uiview type variable
    var mFieldName:String? = nil            //Var to store View Name
    var mIndex:Int = 0                      //Var to store index
    var mDate:String?                       //Var to store Date
    var mDashVM:DashboardViewModel?         //Var to object of DashboardViewModel
    var mDateChanged:Bool = true            //Var to store boolean value
    var mDate1:Date?                        //Var to store date
    var mCheckVar:Bool = true               //Var to store boolean Value
    var mCheck:Bool = true                  //Var to store boolean Value
    var mSlideDetail:NSArray?               //Var to store object in array
    var mUtil = Utility()                   //Var to hold Utility object
    
    
    //Executes when screen loads
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if mDashVM == nil
        {
            mActivityLoader.startAnimating()
            mDashVM = DashboardViewModel(dashboardProtocolObj: self)
            mDashVM?.getDashboardData()
        }
        
            //Get slide Menu detail from plist
            mSlideDetail = mUtil.getSlideMenuDetail()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //Hiding the navigation bar
        self.navigationController?.navigationBar.isHidden = true
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: 20.0))
        view.backgroundColor = UIColor(colorWithHexValue: 0xD8D1C7).withAlphaComponent(0.75)
        self.view.addSubview(view)
        
        //Initialise Date Formatter
        let formatter = DateFormatter()
        let formatter1 = DateFormatter()
        let formatter2 = DateFormatter()
        
        //setting Date format
        formatter.setLocalizedDateFormatFromTemplate("MMMM")
        formatter1.setLocalizedDateFormatFromTemplate("yyyy")
        formatter2.setLocalizedDateFormatFromTemplate("dd MMMM yyyy")
        
        //set Date to dateLabel
        mHeaderDateLabel.text = formatter2.string(from: Date())
        
        mUtil.setShadowAttribute(myView: mSecondaryView, shadowOpacity: 0.5, shadowRadius: 2.0)
        
        if mFieldName != nil
        {
          mDashLabel.text = mFieldName
        }
        
        //Set slideTableView datasource to self
        mSlideTableView.dataSource = self
        //Set SlideTableView delegate to self
        mSlideTableView.delegate = self
        
            }
    
    @IBAction func mSlideMenuBtn(_ sender: Any) {
        
        //Creating a view programatically
        mCustomView.frame = CGRect.init(x: mSlideMenu.frame.width, y: 0, width: view.frame.width-mSlideMenu.frame.width, height: view.frame.height)
        
        mCustomView.backgroundColor = UIColor.clear
        
        if(mFlag)
        {
            mSlideMenuContraint.constant = -300
            //1st case of removing tap gesture(papre) when we click on the icon
            
            removeGestureRecognizer()
            
        }
        else
        {
            //Making a slide menu visible to user
            mSlideMenuContraint.constant = 0
            self.view.addSubview(mCustomView)
            mCustomView.alpha = 0.5
            addGestureRecognizer()
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        mFlag = !mFlag
        tableviewReload()

    }
    
    //function to rotate the screen
    func rotated() {
        if UIDeviceOrientationIsLandscape(UIDevice.current.orientation) {
            mCustomView.frame = CGRect.init(x: mSlideMenu.frame.width, y: 0, width: view.frame.width-mSlideMenu.frame.width, height: view.frame.height)
            mCustomView.backgroundColor = UIColor.clear
        }
        if UIDeviceOrientationIsPortrait(UIDevice.current.orientation) {
            mCustomView.frame = CGRect.init(x: mSlideMenu.frame.width, y: 0, width: view.frame.width-mSlideMenu.frame.width, height: view.frame.height)
            mCustomView.backgroundColor = UIColor.clear
        }
    }
    
    //add the gesture recognizer when the menu button is tapped
    func addGestureRecognizer(){
        let lTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapBlurView(_:)))
        self.mCustomView.addGestureRecognizer(lTapGesture)
    }
    
    //remove gesture recognizer after opening the slidemenu
    func removeGestureRecognizer(){
        for recognizer in mAttendanceCollection.gestureRecognizers ?? [] {
            mCustomView.removeGestureRecognizer(recognizer)
        }
    }
    
    //called by addGestureRecognizer method
    func tapBlurView(_ sender: UIButton) {
        mSlideMenuContraint.constant = -300
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        //to remove custom view after removing slidemenu
        self.mCustomView.removeFromSuperview()
        mFlag = !mFlag
        
        //3rd case of removing  gesture when we click on collectionview
        removeGestureRecognizer()
    }

    //reload tableview data when the data is loaded into it
    func tableviewReload(){
        
        //Reloading the Table View
        self.mSlideTableView.reloadData()
    }

    
    //Reload attendance Collection
    func reloadAttendance() -> Void {
        
        //Set a boolean variable to false
        mCheck = false
        
        //set Attendance Collection datasource to the self
        self.mAttendanceCollection.dataSource = self
        
        //set Attendance Collection delegate to the self
        self.mAttendanceCollection.delegate = self
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let calendarClass = segue.destination as! CalendarViewController
        calendarClass.mEmailId = mEmailId!
        
    }
    
    //Method Executes when Menu Button is pressed
    @IBAction func menuBtn(_ sender: Any) {
        
        self.performSegue(withIdentifier: "calendar", sender: nil)
    }
    
    //Method Executes when any error occurs
    func errorMessage() -> Void {
        
        //AlertView to display alert message to the user
        mUtil.displayErrorMessage(message: "Internet Not Connected", view: self)

    }

    
}

// MARK:Datasource For Attendance Collection View

extension DashboardViewController : UICollectionViewDataSource
{
    //Set number of section in collection View
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
      return 1
        
    }
    
    //Set number of cells in a section of collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if mCheck
        {
         return 0
        }
        else{return 6}
        
    }
    
    //Configuring the cell of a collection view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        mActivityLoader.stopAnimating()
        //if collectionView == mAttendanceCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "attendanceSummary", for: indexPath) as! DashCollectionViewCell
            
            //Initialise Date Formatter
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMMM yyyy"       //set Date Format
            
              //set border color to cell
              cell.contentView.layer.borderColor = UIColor.cyan.cgColor
            
            switch indexPath.row {
                //for 1st cell
            case DashboardCollectionEnum.ATTENDANCE_SUMMARY.rawValue:
                mUtil.configureCell(cell: cell, title: false, marked: false, unmarked: false, number: true, date: false, totNumber: true, markedData: false, unmarkedData: false, menu: true)
                cell.mMarkedAttendanceData.layer.cornerRadius = 18.65
                cell.mUnmarkedAttendanceData.layer.cornerRadius = 18.65
                cell.mMarkedAttendanceData.text = mDashVM?.mMarkedAttdendance
                cell.mUnmarkedAttendanceData.text = mDashVM?.mUnmarkedAttendance
                
                if String(describing: mDashVM?.mJsonTimeStamp) != "nil"
                {
                    mDate1 = Date.init(timeIntervalSince1970: Double((mDashVM?.mJsonTimeStamp)! / 1000))
                    print(mDate1!)
                    cell.mDateLabel.text = formatter.string(from: mDate1! as Date)
                }
                else
                {
                    mUtil.displayErrorMessage(message: "Something Wrong Happened", view: self)
                    //exit(0)
                }
                break
               
                //for 2nd cell
            case DashboardCollectionEnum.ATTENDANCE_FALLOUT.rawValue:
                mUtil.configureCell(cell: cell, title: false, marked: true, unmarked: true, number: false, date: false, totNumber: false, markedData: true, unmarkedData: true, menu: false)
                cell.mTitleLabel.text = "Attendance Fallout"
                cell.mAttendanceFallLabel.text = mDashVM?.mAttendanceFallNumberLabel
                let str = mDashVM?.mTotalEmployee
                if str == nil
                {
                    mUtil.displayErrorMessage(message: "Something Wrong Happened", view: self)
                    
                    let when = DispatchTime.now() + 4
                    DispatchQueue.main.asyncAfter(deadline: when) {
                    exit(0)
                    }  
                }
                print(str!)
                cell.mTotalNumberLabel.text = "Out of "+str!
                let mFormatter = DateFormatter()
                mFormatter.dateFormat = "MMMM yyyy"
                cell.mDateLabel.text = mFormatter.string(from: mDate1! as Date)
                break
                
                //for 3rd cell
            case DashboardCollectionEnum.LEAVE_SUMMARY.rawValue:
                mUtil.configureCell(cell: cell, title: false, marked: true, unmarked: true, number: false, date: false, totNumber: false, markedData: true, unmarkedData: true, menu: false)
                cell.mTitleLabel.text = "Leave Summary"
                cell.mAttendanceFallLabel.text = mDashVM?.mLeave
                cell.mTotalNumberLabel.text = "Uptill"
                cell.mTotalNumberLabel.textColor = UIColor(colorWithHexValue: 0x6FB8D9)
                let mFormatter = DateFormatter()
                mFormatter.dateFormat = "MMMM yyyy"
                cell.mDateLabel.text = mFormatter.string(from: mDate1!)
                break
                
                //for 4th cell
            case DashboardCollectionEnum.ENGINEERS.rawValue:
                mUtil.configureCell(cell: cell, title: true, marked: true, unmarked: true, number: false, date: true, totNumber: true, markedData: true, unmarkedData: true, menu: false)
                
                cell.mAttendanceFallLabel.text = "Engineers"
                cell.mAttendanceFallLabel.textColor = UIColor(colorWithHexValue: 0x6FB8D9)
                break
                
                //for 5th cell
            case DashboardCollectionEnum.CLIENTS.rawValue:
                mUtil.configureCell(cell: cell, title: true, marked: true, unmarked: true, number: false, date: true, totNumber: true, markedData: true, unmarkedData: true, menu: false)
                
                cell.mAttendanceFallLabel.text = "Clients"
                cell.mAttendanceFallLabel.textColor = UIColor(colorWithHexValue: 0x6FB8D9)
                break
                
                //for 6th cell
            case DashboardCollectionEnum.REPORTS.rawValue:
                mUtil.configureCell(cell: cell, title: true, marked: true, unmarked: true, number: false, date: true, totNumber: true, markedData: true, unmarkedData: true, menu: false)
                
                cell.mAttendanceFallLabel.text = "Reports"
                cell.mAttendanceFallLabel.textColor = UIColor(colorWithHexValue: 0x6FB8D9)
                break
                
            default:
                _ = NSNull.self

            }
            return cell

        }
    
}

//MARK: DELEGATE FOR ATTENDANCE COLLECTION VIEW

extension DashboardViewController:UICollectionViewDelegate
{
    //Method executes when a collection view cell is selected
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.performSegue(withIdentifier: "calendar", sender: nil)
        }
    }
}

//MARK: DATASOURCE FOR SLIDE MENU TABLE VIEW

extension DashboardViewController:UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (mSlideDetail!.count)+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath)
        
        switch indexPath.row {
        case DashBoardTableView.EMAILID.rawValue:
            
            mEmailId = mUtil.getUserDefaultData(key: "emailID")
            let color = UIColor.init(red: 157/255, green: 212/255, blue: 237/255, alpha: 1)
            cell.backgroundColor = color
            cell.imageView?.frame = CGRect(x: (cell.imageView?.frame.origin.x)!, y: (cell.imageView?.frame.origin.y)!, width: 15, height: 18)
            cell.imageView?.image = #imageLiteral(resourceName: "user")
            cell.textLabel?.text = mEmailId!
            break
        case DashBoardTableView.DASHBOARD.rawValue:
            cell.textLabel?.text = mSlideDetail?[indexPath.row-1] as? String
            break
        case DashBoardTableView.ENGINEERS.rawValue:
            cell.textLabel?.text = mSlideDetail?[indexPath.row-1] as? String
            break
        case DashBoardTableView.ATTENDANCESUMMARY.rawValue:
            cell.textLabel?.text = mSlideDetail?[indexPath.row-1] as? String
            break
        case DashBoardTableView.REPORTS.rawValue:
            cell.textLabel?.text = mSlideDetail?[indexPath.row-1] as? String
            break
        case DashBoardTableView.CLIENTS.rawValue:
            cell.textLabel?.text = mSlideDetail?[indexPath.row-1] as? String
            break
        case DashBoardTableView.LOGOUT.rawValue:
            cell.imageView?.frame = CGRect(x: (cell.imageView?.frame.origin.x)!, y: (cell.imageView?.frame.origin.y)!, width: 15, height: 18)
            cell.imageView?.image = #imageLiteral(resourceName: "logout1")
            cell.textLabel?.text = mSlideDetail?[indexPath.row-1] as? String
            
        default: break
            cell.textLabel?.text = mSlideDetail?[0] as? String
        }
        
        return cell
           }
}

//MARK: DELEGATE FOR SLIDE MENU TABLE VIEW

extension DashboardViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            mSlideMenuContraint.constant = -300
            removeGestureRecognizer()
            mFlag = !mFlag
            return
        }
        if indexPath.row == 3{
            self.performSegue(withIdentifier: "calendar", sender: nil)
            mSlideMenuContraint.constant = -300
        }
        if indexPath.row == 6 {
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
            mSlideMenuContraint.constant = -300

        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
}

//Extension for UIColor to get color with hexcode
extension UIColor {
    convenience init(colorWithHexValue value: Int, alpha:CGFloat = 1.0){
        self.init(
            red: CGFloat((value & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((value & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(value & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}



