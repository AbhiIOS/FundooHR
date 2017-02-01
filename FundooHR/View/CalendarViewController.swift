//
//  CalendarViewController.swift
//  FundooHR
//
//  Created by BridgeLabz Solutions LLP  on 1/28/17.
//  Copyright © 2017 BridgeLabz Solutions LLP . All rights reserved.
//

import UIKit
import JTAppleCalendar

enum SlideTableView:Int{
    case EMAILID = 0
    case DASHBOARD
    case ENGINEERS
    case ATTENDANCESUMMARY
    case REPORTS
    case CLIENTS
    case LOGOUT
}

class CalendarViewController: UIViewController, CalendarViewProtocol {

    @IBOutlet weak var mSlideMenuBtn: UIButton!
    @IBOutlet weak var mPickerView: UIPickerView!
    @IBOutlet weak var mCalendarView: JTAppleCalendarView!
    @IBOutlet weak var mHeaderDateLabel: UILabel!
    @IBOutlet weak var mCalendarHeaderView: UIView!
    @IBOutlet weak var mSlideTableview:UIView!
    @IBOutlet weak var mSlideTable: UITableView!
    @IBOutlet weak var mSlideViewConstraint: NSLayoutConstraint!
    
    var mFlag = false
    var mCustomView = UIView()              //creating uiview type variable
    var mMonthArray:NSMutableArray?         //Var to store months name in form 
                                            // of array
    var mYearArray:NSMutableArray?          //Var to store year in form of array
    var mDate:String?                       //Var to store Date
    var mDateChange:Bool = false            //Var to store boolean Value
    var mStrMonth:String?                   //Var to store Month Name
    var mStrYear:String?                    //Var to store Year
    var mCalendarVM:CalendarViewModel?      //Var to object of CalendarViewModel
    var mTimeStamp:Int?                     //Var to store timestamp
    var mSlideMenuDetail:NSArray?           //Var to store object in array
    var mTimestamp:Double?                     //Var to store timestamp
    
    var mUtil = Utility()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if mCalendarVM == nil {
            //Initialise DashboardViewModel
            mCalendarVM = CalendarViewModel(calendarProtocolObj: self)
            
            //Generating timestamp from current date
            mTimeStamp = Int(Date().timeIntervalSince1970 * 1000)
            print(mTimeStamp!)
            mCalendarVM?.getMonthlyAttendance(timestamp:mTimeStamp!)
        }
        
        mSlideMenuDetail = mUtil.getSlideMenuDetail()
        
    }
    
    //Method executes after view loads
    override func viewWillAppear(_ animated: Bool) {
        
        
        
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: 20.0))
        view.backgroundColor = UIColor(colorWithHexValue: 0xD8D1C7).withAlphaComponent(0.8)
        self.view.addSubview(view)
        
        //set customPickerView datasource to the self
        mPickerView.dataSource = self
        
        //set customPickerView delegate to the self
        mPickerView.delegate = self
        
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
        
        mMonthArray = mCalendarVM?.mMonthsAry1
        mYearArray = mCalendarVM?.mYearAry1
        print(mMonthArray!.count)
        print(mYearArray!.count)
        
        //Setting current Month Name to the picker View
        for var i in 0..<(mMonthArray!.count) {
            if mMonthArray!.object(at: i) as! String == currentMonth {
                mPickerView.selectRow(i, inComponent: 0, animated: true)
                break
            }
        }
        
        //Setting current year to the picker View
        for var j in 0..<(mYearArray!.count) {
            if mYearArray!.object(at: j) as! String == currentYear {
                mPickerView.selectRow(j, inComponent: 1, animated: true)
                break
            }
        }
        
        // This Section is for Calender View
        mCalendarView.layer.borderWidth = 3
        mCalendarView.layer.borderColor = UIColor(red: 180/255, green: 221/255, blue: 239/255, alpha: 1).cgColor
        mCalendarView.layer.masksToBounds = false
        
        mUtil.setShadowAttribute(myView: mCalendarView, shadowOpacity: 0.6, shadowRadius: 2.0)
        
        //set calendarview datasource to the self
        mCalendarView.dataSource = self

        // Add this new line
        mCalendarView.cellInset = CGPoint(x: 0, y: 0)
        
        mUtil.setShadowAttribute(myView: mCalendarHeaderView, shadowOpacity: 0.5, shadowRadius: 2.0)
        
        //set Slide TableView datasource to the self
        mSlideTable.dataSource = self
        
        //set Slide TableView datasource to the self
        mSlideTable.delegate = self
  
    }
    
    
    @IBAction func mSlideMenuBtn(_ sender: Any) {
        
        //changing the custom view's size while we change to landscape mode
        print("views width",view.frame.width)
        mCustomView.frame = CGRect.init(x: mSlideTableview.frame.width, y: 0, width: view.frame.width-mSlideTableview.frame.width, height: view.frame.height)
        mCustomView.backgroundColor = UIColor.clear
        
        if(mFlag){
            mSlideViewConstraint.constant = -300
            //1st case of removing tap gesture(papre) when we click on the icon
            
            removeGestureRecognizer()
            
        }else{
            //enabling the activity indictor
            mSlideViewConstraint.constant = 0
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //function to rotate the screen
    func rotated() {
        if UIDeviceOrientationIsLandscape(UIDevice.current.orientation) {
            mCustomView.frame = CGRect.init(x: mSlideTableview.frame.width, y: 0, width: view.frame.width-mSlideTableview.frame.width, height: view.frame.height)
            mCustomView.backgroundColor = UIColor.clear
        }
        if UIDeviceOrientationIsPortrait(UIDevice.current.orientation) {
            print("Portrait")
            print("views width",view.frame.width)
            mCustomView.frame = CGRect.init(x: mSlideTableview.frame.width, y: 0, width: view.frame.width-mSlideTableview.frame.width, height: view.frame.height)
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
        for recognizer in mCalendarView.gestureRecognizers ?? [] {
            mCustomView.removeGestureRecognizer(recognizer)
        }
    }
    
    //called by addGestureRecognizer method
    func tapBlurView(_ sender: UIButton) {
        mSlideViewConstraint.constant = -300
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        //to remove custom view after removing slidemenu
        self.mCustomView.removeFromSuperview()
        mFlag = !mFlag
        
        //3rd case of removing  gesture when we click on view
        removeGestureRecognizer()
    }
    
    //reload tableview data when the data is loaded into it
    func tableviewReload(){
        
        self.mSlideTable.reloadData()
    }

    
    //Reload Calendar
    func reloadCalendar() -> Void {
        //self.mCalendarActivityLoader.stopAnimating()
        //set calendarView delegate to the self
        mCalendarView.delegate = self
        //Registring cellView xib
        mCalendarView.registerCellViewXib(file: "CellView") // Registering your cell is manditory

        mCalendarView.reloadData()
    }
    
    func showError(message:String) -> Void {
        mUtil.displayErrorMessage(message: message, view: self)
        
        let when = DispatchTime.now() + 4
        DispatchQueue.main.asyncAfter(deadline: when) {
            exit(0)
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let fallvc = segue.destination as! FalloutViewController
        fallvc.mTimeStamp = mTimestamp!
    }
    

}

//MARK:DATASOURCE METHODS FOR JTAPPLECALENDARVIEW

extension CalendarViewController: JTAppleCalendarViewDataSource {
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
extension CalendarViewController : JTAppleCalendarViewDelegate
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
              let day = (mCalendarVM?.dayAttendance())!
              dateCell.attendanceData.isHidden = false
              dateCell.attendanceData.text = day+"/"+(mCalendarVM?.mTotalEmployeeCal!)!
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
        
        mTimestamp = cellState.date.timeIntervalSince1970 * 1000
        self.performSegue(withIdentifier: "fallout", sender: nil)
        
    }
    
}

//MARK:DATASOURCE METHODS FOR CUSTOM PICKER VIEW

extension CalendarViewController : UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return (mMonthArray!.count)
        }
        
        if component == 1 {
            return (mYearArray!.count)
        }
        return 0
    }
}

//MARK:DELEGATE METHODS FOR CUSTOM PICKER VIEW

extension CalendarViewController : UIPickerViewDelegate
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
        
//        self.mCalendarActivityLoader.startAnimating()
        let when = DispatchTime.now() + 8
        DispatchQueue.main.asyncAfter(deadline: when) {
            
            self.mStrMonth = self.mMonthArray![pickerView.selectedRow(inComponent: 0)] as? String
            self.mStrYear = self.mYearArray![pickerView.selectedRow(inComponent: 1)] as? String
            self.mDateChange = true
            let formatter = DateFormatter()
            formatter.setLocalizedDateFormatFromTemplate("MMMMyyyy")
            let strDate = self.mStrMonth!+" "+self.mStrYear!
            let mDate = formatter.date(from: strDate)
            let mTimestamp = Int(mDate!.timeIntervalSince1970 * 1000)
            print(mTimestamp)
            
            self.mCalendarVM?.getMonthlyAttendance(timestamp: mTimestamp)
            
        }
        
    }
    
    
}

//MARK:DATASOURCE METHODS FOR SLIDEMENU TABLE VIEW

extension CalendarViewController:UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (mSlideMenuDetail!.count)+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "slideCell", for: indexPath)
        
        switch indexPath.row {
        case SlideTableView.EMAILID.rawValue:
            let color = UIColor.init(red: 157/255, green: 212/255, blue: 237/255, alpha: 1)
            cell.backgroundColor = color
            cell.imageView?.frame = CGRect(x: (cell.imageView?.frame.origin.x)!, y: (cell.imageView?.frame.origin.y)!, width: 60, height: 60)
            cell.imageView?.image = #imageLiteral(resourceName: "user")
            cell.textLabel?.text = "admin@bridgelabz.com"
            break
        case SlideTableView.DASHBOARD.rawValue:
            cell.textLabel?.text = mSlideMenuDetail?[indexPath.row-1] as? String
            break
        case SlideTableView.ENGINEERS.rawValue:
            cell.textLabel?.text = mSlideMenuDetail?[indexPath.row-1] as? String
            break
        case SlideTableView.ATTENDANCESUMMARY.rawValue:
            cell.textLabel?.text = mSlideMenuDetail?[indexPath.row-1] as? String
            break
        case SlideTableView.REPORTS.rawValue:
            cell.textLabel?.text = mSlideMenuDetail?[indexPath.row-1] as? String
            break
        case SlideTableView.CLIENTS.rawValue:
            cell.textLabel?.text = mSlideMenuDetail?[indexPath.row-1] as? String
            break
        case SlideTableView.LOGOUT.rawValue:
            cell.imageView?.image = #imageLiteral(resourceName: "logout1")
            cell.textLabel?.text = mSlideMenuDetail?[indexPath.row-1] as? String
            
        default: break
        cell.textLabel?.text = mSlideMenuDetail?[0] as? String
        }
        return cell
    }
}

//MARK:DELEGATE METHODS FOR SLIDEMENU TABLE VIEW
extension CalendarViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 1 {
            self.navigationController?.popViewController(animated: true)
        }
        if indexPath.row == 3{
            return
        }
        if indexPath.row == 6 {
            mUtil.logout(view: self)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
}


