//
//  DashboardViewController.swift
//  FundooHR
//
//  Purpose:
//  1. This is the main UIClass which holds all IBOutlets & IBActions related to Dashboard
//  2. It listens to all UICalls
//  3. It implements local library for calendar to display calendarView
//  4. It holds local library for slider Menu

//  Created by BridgeLabz Solutions LLP  on 12/10/16.
//  Copyright © 2016 BridgeLabz Solutions LLP . All rights reserved.
//

import UIKit
import JTAppleCalendar
import Firebase

class DashboardViewController: UIViewController {

    //Outlet of CalendarView
    @IBOutlet weak var mCalenderView: JTAppleCalendarView!
    
    //Outlet of Attendance Fallout Collection View
    @IBOutlet weak var mFallOutCollection: UICollectionView!
    
    //Outlet of Custom Picker View
    @IBOutlet weak var mCustomPickerView: UIPickerView!
    
    //Outlet of UIView of CalendarView
    @IBOutlet weak var mPrimaryView: UIView!
    
    //Outlet of UIView
    @IBOutlet weak var mSecondaryView: UIView!
    
    //Outlet of Enginner Profile View
    @IBOutlet weak var mEngineerProfileView: UIView!
    
    //Outlet of Calendar ScrollView
    @IBOutlet weak var mCalenderScroll: UIScrollView!
    
    //Outlet of button for sliderMenu
    @IBOutlet weak var mSlideBarBtn: UIButton!
    
    //Outlet of Dashboard Collection View
    @IBOutlet weak var mAttendanceCollection: UICollectionView!
    
    //Outlet of label to display View Name
    @IBOutlet weak var mDashLabel: UILabel!
    
    //Outlet of UIView of engineer View
    @IBOutlet weak var mEngineerView: UIView!
    
    //Outlet of UIView of Dashboard
    @IBOutlet weak var mDashBoard: UIView!
    
    //Outlet of UIView of Attendance Fall Out
    @IBOutlet weak var mFallOutView: UIView!
    
    //Outlet of label To display Date
    @IBOutlet weak var mHeaderDateLabel: UILabel!
    
    //Outlet of label to display Date in Attendance Fall Out View
    @IBOutlet weak var mFallOutDateLabel: UILabel!
    
    //Outlet of Label to display Number of Fallout Data
    @IBOutlet weak var mFallData: UILabel!
    
    //Outlet of Back Button
    @IBOutlet weak var mFallOutBackButton: UIButton!
    
    //Outlet of Activity Indicator
    @IBOutlet weak var mCalendarActivityLoader: UIActivityIndicatorView!
    
    
    var mFieldName:String? = nil            //Var to store View Name
    var mIndex:Int = 0                      //Var to store index
    var mStrMonth:String?                   //Var to store Month Name
    var mStrYear:String?                    //Var to store Year
    var mDate:String?                       //Var to store Date
    var mDateChange:Bool = false            //Var to store boolean Value
    var mDashVM:DashboardViewModel?         //Var to object of DashboardViewModel
    var mMonthArray:NSMutableArray?         //Var to store months name in form of array
    var mYearArray:NSMutableArray?          //Var to store year in form of array
    var mStartDate:Date?                    //Var to store Date
    var mDateChanged:Bool = true            //Var to store boolean value
    var mTokenStr:String?                   //Var to store token Value
    var mDate1:Date?                        //Var to store date
    var mBoolVar:Bool = true                //Var to store boolean Value
    var mBool:Bool = true                   //Var to store boolean Value
    var mUtil = Utility()                   //Var to hold Utility object
    
    //Executes when screen loads
    override func viewDidLoad() {
        super.viewDidLoad()
        
          //Initialise DashboardViewModel
          mDashVM = DashboardViewModel(dashboardVCObj: self)
        
        if mBoolVar {
            
            mDashVM?.CallToViewModel()
        }
        
        //Switching between the Views
        switch mIndex {
        case 0:
            self.view.bringSubview(toFront: mDashBoard)
            break
        case 1:
            self.view.bringSubview(toFront: mEngineerProfileView)
            break
        case 2:
            self.view.bringSubview(toFront: mPrimaryView)
            break
        default:
            self.view.bringSubview(toFront: mDashBoard)
        }
        
        //Hiding the navigation bar
        self.navigationController?.navigationBar.isHidden = true
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: 20.0))
        view.backgroundColor = UIColor(colorWithHexValue: 0xD8D1C7).withAlphaComponent(0.8)
        self.view.addSubview(view)
        
        //set customPickerView datasource to the self
        mCustomPickerView.dataSource = self
        
        //set customPickerView delegate to the self
        mCustomPickerView.delegate = self
        
        //Initialise Date Formatter
        let formatter = DateFormatter()
        let formatter1 = DateFormatter()
        let formatter2 = DateFormatter()
        
        //setting Date format
        formatter.setLocalizedDateFormatFromTemplate("MMMM")
        formatter1.setLocalizedDateFormatFromTemplate("yyyy")
        formatter2.setLocalizedDateFormatFromTemplate("dd MMMM yyyy")
        
        //Getting Month Name from current Date
        let currentMonth = formatter.string(from: Date())
        //Getting Year from Current Date
        let currentYear = formatter1.string(from: Date())
        //set Date to dateLabel
        mHeaderDateLabel.text = formatter2.string(from: Date())
        
        mMonthArray = mMonthsAry
        mYearArray = mYearAry
        print(mMonthArray!.count)
        print(mYearArray!.count)
        
        //Setting current Month Name to the picker View
        for var i in 0..<(mMonthArray!.count) {
            if mMonthArray!.object(at: i) as! String == currentMonth {
                mCustomPickerView.selectRow(i, inComponent: 0, animated: true)
                break
            }
        }
        
        //Setting current year to the picker View
        for var j in 0..<(mYearArray!.count) {
            if mYearArray!.object(at: j) as! String == currentYear {
                mCustomPickerView.selectRow(j, inComponent: 1, animated: true)
                break
            }
        }
        
        // This Section is for Calender View
        mCalenderView.layer.borderWidth = 3
        mCalenderView.layer.borderColor = UIColor(red: 180/255, green: 221/255, blue: 239/255, alpha: 1).cgColor
        mCalenderView.layer.masksToBounds = false
        
        mUtil.setShadowAttribute(myView: mCalenderView, shadowOpacity: 0.6, shadowRadius: 2.0)
        
        //set calendarview datasource to the self
        mCalenderView.dataSource = self
        //set calendarView delegate to the self
        mCalenderView.delegate = self
        
        //Registring cellView xib
        mCalenderView.registerCellViewXib(file: "CellView") // Registering your cell is manditory
        
        // Add this new line
        mCalenderView.cellInset = CGPoint(x: 0, y: 0)

        
        mSlideBarBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        mUtil.setShadowAttribute(myView: mSecondaryView, shadowOpacity: 0.5, shadowRadius: 2.0)
        
        if mFieldName != nil {
            mDashLabel.text = mFieldName
        }
        
        //set Fallout Collection datasource to the self
        mFallOutCollection.dataSource = self

        //set Attendance Collection datasource to the self
        self.mAttendanceCollection.dataSource = self
        
        
    }
    
    func reloadAttendance() -> Void {
        mBool = false
        mAttendanceCollection.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    //Method Executes when Menu Button is pressed
    @IBAction func menuBtn(_ sender: Any) {
        self.view.bringSubview(toFront: mPrimaryView)
        self.mDashLabel.text = "Attendance"
    }
    
    //Method Executes when Back Button is pressed
    @IBAction func backBtnPressed(_ sender: Any) {
        self.view.bringSubview(toFront: mPrimaryView)
        
    }
    
    //Method Executes when any error occurs
    func errorMessage() -> Void {
        
        //AlertView to display alert message to the user
        mUtil.displayErrorMessage(message: "Internet Not Connected", view: self)

    }

    
}

// MARK:Datasource For Attendance Collection & Fallout Collection

extension DashboardViewController : UICollectionViewDataSource
{
    //Set number of section in collection View
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == mAttendanceCollection {
            return 1
        }
        
        if collectionView == mFallOutCollection {
            return 1
        }
        return 0
        
    }
    
    //Set number of cells in a section of collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == mAttendanceCollection {
            if mBool {
                return 0
            }
            else{return 6}
        }
        
        if collectionView == mFallOutCollection {
            return 4
        }
        return 0
    }
    
    //Configuring the cell of a collection view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == mAttendanceCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "attendanceSummary", for: indexPath) as! DashCollectionViewCell
            
            //Initialise Date Formatter
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMMM yyyy"       //set Date Format
            
              //set border color to cell
              cell.contentView.layer.borderColor = UIColor.cyan.cgColor
            
            switch indexPath.row {
                //for 1st cell
            case 0:
                mUtil.configureCell(cell: cell, title: false, marked: false, unmarked: false, number: true, date: false, totNumber: true, markedData: false, unmarkedData: false, menu: true)
                cell.markedAttendanceData.layer.cornerRadius = 18.65
                cell.unmarkedAttendanceData.layer.cornerRadius = 18.65
                cell.markedAttendanceData.text = mMarkedAttdendance
                cell.unmarkedAttendanceData.text = mUnmarkedAttendance
                
                if String(describing: mJsonTimeStamp) != "nil"
                {
                    mDate1 = Date.init(timeIntervalSince1970: Double((mJsonTimeStamp)! / 1000))
                    print(mDate1!)
                    cell.dateLabel.text = formatter.string(from: mDate1! as Date)
                }
                else{
                    
                    mUtil.displayErrorMessage(message: "Something Wrong Happened", view: self)

                    //exit(0)
                   
                }
                break
               
                //for 2nd cell
            case 1:
                mUtil.configureCell(cell: cell, title: false, marked: true, unmarked: true, number: false, date: false, totNumber: false, markedData: true, unmarkedData: true, menu: false)
                cell.titleLabel.text = "Attendance Fallout"
                cell.numberLabel.text = mAttendanceFallNumberLabel
                let str = mTotalEmployee
                print(str!)
                cell.totalNumberLabel.text = "Out of "+str!
                let mFormatter = DateFormatter()
                mFormatter.dateFormat = "MMMM yyyy"
                cell.dateLabel.text = mFormatter.string(from: mDate1!)
                break
                
                //for 3rd cell
            case 2:
                mUtil.configureCell(cell: cell, title: false, marked: true, unmarked: true, number: false, date: false, totNumber: false, markedData: true, unmarkedData: true, menu: false)
                cell.titleLabel.text = "Leave Summary"
                cell.numberLabel.text = mLeave
                cell.totalNumberLabel.text = "Uptill"
                cell.totalNumberLabel.textColor = UIColor(colorWithHexValue: 0x6FB8D9)
                let mFormatter = DateFormatter()
                mFormatter.dateFormat = "MMMM yyyy"
                cell.dateLabel.text = mFormatter.string(from: mDate1!)
                break
                
                //for 4th cell
            case 3:
                mUtil.configureCell(cell: cell, title: true, marked: true, unmarked: true, number: false, date: true, totNumber: true, markedData: true, unmarkedData: true, menu: false)
                
                cell.numberLabel.text = "Engineers"
                cell.numberLabel.textColor = UIColor(colorWithHexValue: 0x6FB8D9)
                break
                
                //for 5th cell
            case 4:
                mUtil.configureCell(cell: cell, title: true, marked: true, unmarked: true, number: false, date: true, totNumber: true, markedData: true, unmarkedData: true, menu: false)
                
                cell.numberLabel.text = "Clients"
                cell.numberLabel.textColor = UIColor(colorWithHexValue: 0x6FB8D9)
                break
                
                //for 6th cell
            case 5:
                mUtil.configureCell(cell: cell, title: true, marked: true, unmarked: true, number: false, date: true, totNumber: true, markedData: true, unmarkedData: true, menu: false)
                
                cell.numberLabel.text = "Reports"
                cell.numberLabel.textColor = UIColor(colorWithHexValue: 0x6FB8D9)
                break
                
            default:
                NSNull.self
            }
            return cell

        }
        
        if collectionView == mFallOutCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "fallOutCell", for: indexPath) as! AttendanceFallOutCollectionViewCell
            
            return cell
            
        }
        else{
            return AttendanceFallOutCollectionViewCell.copy() as! UICollectionViewCell
        }
        
                    }
    
    
}

//MARK:DATASOURCE METHODS FOR JTAPPLECALENDARVIEW

extension DashboardViewController: JTAppleCalendarViewDataSource {
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("MMMMyyyy")
       
       //Initialise current Date
       var startDate = Date()

        if mDateChange {
            mDate = mStrMonth!+" "+mStrYear!
            print(mDate!)
            let date1 = mDate!
            print(date1)
            startDate = formatter.date(from: mDate!)!
            print(startDate)
        }
       
        //Configuring the calendar
        let endDate = formatter.date(from: "December 2037")!
        let parameters = ConfigurationParameters(startDate: startDate,
                                                 endDate: endDate,
                                                 numberOfRows: 6, // Only 1, 2, 3, & 6 are allowed
            calendar: Calendar.current,
            generateInDates: .forAllMonths,
            generateOutDates: .tillEndOfGrid,
            firstDayOfWeek: .sunday)
        return parameters
    }
    
}

//MARK:DELEGATE METHODS FOR JTAPPLECALENDARVIEW

extension DashboardViewController : JTAppleCalendarViewDelegate
{
        func calendar(_ calendar: JTAppleCalendarView, willDisplayCell cell: JTAppleDayCellView, date: Date, cellState: CellState) {
        let  dateCell = cell as! CellView
        
        dateCell.layer.borderWidth = 0.6
        dateCell.layer.borderColor = UIColor.lightGray.cgColor
        dateCell.dayLabel.text = cellState.text
        
        if cellState.dateBelongsTo == .thisMonth       //if date is of current month
        {
            dateCell.layer.borderWidth = 0.6
            dateCell.layer.borderColor = UIColor.lightGray.cgColor
            dateCell.dayLabel.textColor =  UIColor(colorWithHexValue: 0x6FB8D9)
            let day = (mDashVM?.dayAttendance())!
            dateCell.attendanceData.isHidden = false
            dateCell.attendanceData.text = day+"/"+(mTotalEmployee1)!
           if (day.compare("0") == ComparisonResult.orderedDescending) {
                dateCell.attendanceData.textColor = UIColor.red
            }
           else{
               dateCell.attendanceData.textColor = UIColor.green
            }
            
        }
        else{
            dateCell.layer.borderWidth = 0.6
            dateCell.layer.borderColor = UIColor.lightGray.cgColor
            dateCell.dayLabel.textColor = UIColor(colorWithHexValue: 0xA9A9A9)
            dateCell.attendanceData.isHidden = true
        }
    }
    
    //Method executes when Date cell is selected
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleDayCellView?, cellState: CellState) {
        self.view.bringSubview(toFront: mFallOutView)
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("ddMMMMyyyy")
        mFallOutDateLabel.text = formatter.string(from: date)
    }
    
}

//MARK:DATASOURCE METHODS FOR CUSTOM PICKER VIEW

extension DashboardViewController : UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return (mMonthArray?.count)!
        }
        
        if component == 1 {
            return (mYearArray?.count)!
        }
        return 0
    }
}

//MARK:DELEGATE METHODS FOR CUSTOM PICKER VIEW

extension DashboardViewController : UIPickerViewDelegate
{
    //Set title for each row of picker view
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0 {
            let nameOfMonth:String = mMonthArray!.object(at: row) as! String
            return nameOfMonth
        }
        
        if component == 1 {
            let year = mYearArray!.object(at: row) as! String
            return year
        }
        return "null"
    }
    
    //Methods Executes when picker view row is selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.mCalendarActivityLoader.startAnimating()
        let when = DispatchTime.now() + 8
        DispatchQueue.main.asyncAfter(deadline: when) {
            
            self.mStrMonth = self.mMonthArray![pickerView.selectedRow(inComponent: 0)] as? String
            self.mStrYear = self.mYearArray![pickerView.selectedRow(inComponent: 1)] as? String
            self.mDateChange = true
            self.mDateChanged = false
            let formatter = DateFormatter()
            formatter.setLocalizedDateFormatFromTemplate("MMMMyyyy")
            let strDate = self.mStrMonth!+" "+self.mStrYear!
            let mDate = formatter.date(from: strDate)
            let mTimestamp = Int(mDate!.timeIntervalSince1970 * 1000)
            print(mTimestamp)
            
            self.mDashVM?.viewModelCall(timeStamp: mTimestamp)
            
        }
        
    }
    
    //Reload Calendar
    func reloadCalendar() -> Void {
        self.mCalendarActivityLoader.stopAnimating()
        mCalenderView.reloadData()
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



