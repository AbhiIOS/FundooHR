//
//  DashboardViewController.swift
//  FundooHR
//
//  Created by BridgeLabz Solutions LLP  on 12/10/16.
//  Copyright © 2016 BridgeLabz Solutions LLP . All rights reserved.
//

import UIKit
import JTAppleCalendar
import Firebase

class DashboardViewController: UIViewController {

    @IBOutlet weak var calenderView: JTAppleCalendarView!
    @IBOutlet weak var fallOutCollection: UICollectionView!
    
    @IBOutlet weak var customPickerView: UIPickerView!
    
    @IBOutlet weak var primaryView: UIView!
    @IBOutlet weak var secondaryView: UIView!
    @IBOutlet weak var slideEngineerView: UIView!
    
    @IBOutlet weak var calenderScroll: UIScrollView!
    
    @IBOutlet weak var slideBarBtn: UIButton!
    
    @IBOutlet weak var attendanceCollection: UICollectionView!
    
    @IBOutlet weak var dashLabel: UILabel!
    @IBOutlet weak var engineerView: UIView!
    @IBOutlet weak var dashBoard: UIView!
    @IBOutlet weak var fallOutView: UIView!
    @IBOutlet weak var headerDateLabel: UILabel!
    @IBOutlet weak var fallOutDateLabel: UILabel!
    @IBOutlet weak var fallData: UILabel!
    @IBOutlet weak var fallOutBackButton: UIButton!
    
    
    var fieldName:String? = nil
    var index:Int = 0
    var strMonth:String?
    var strYear:String?
    var date:String?
    var dateChange:Bool = false
    var dashVM:DashboardViewModel?
    var monthArray:NSMutableArray?
    var yearArray:NSMutableArray?
    var startDate:Date?
    var dateChanged:Bool = true
    var newStartDate:Date?
    var tokenStr:String?
    var date1:Date?
    var boolVar:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
          dashVM = DashboardViewModel()
          dashVM?.dashboard = self
          dashVM?.CallToViewModel()
        
        
        switch index {
        case 0:
            self.view.bringSubview(toFront: dashBoard)
            break
        case 1:
            self.view.bringSubview(toFront: slideEngineerView)
            break
        case 2:
            self.view.bringSubview(toFront: primaryView)
            break
        default:
            self.view.bringSubview(toFront: dashBoard)
        }
        
        self.navigationController?.navigationBar.isHidden = true
        customPickerView.dataSource = self
        customPickerView.delegate = self
        
        let formatter = DateFormatter()
        let formatter1 = DateFormatter()
        let formatter2 = DateFormatter()
        
        formatter.setLocalizedDateFormatFromTemplate("MMMM")
        formatter1.setLocalizedDateFormatFromTemplate("yyyy")
        formatter2.setLocalizedDateFormatFromTemplate("dd MMMM yyyy")
        let currentMonth = formatter.string(from: Date())
        let currentYear = formatter1.string(from: Date())
        headerDateLabel.text = formatter2.string(from: Date())
        
        monthArray = dashVM?.monthsAry
        yearArray = dashVM?.yearAry
        print(monthArray!.count)
        print(yearArray!.count)
        
        for var i in 0..<(monthArray!.count) {
            if monthArray!.object(at: i) as! String == currentMonth {
                customPickerView.selectRow(i, inComponent: 0, animated: true)
                break
            }
        }
        for var j in 0..<(yearArray!.count) {
            if yearArray!.object(at: j) as! String == currentYear {
                customPickerView.selectRow(j, inComponent: 1, animated: true)
                break
            }
        }
        
        // This Section is for Calender View
        calenderView.layer.borderWidth = 3
        calenderView.layer.borderColor = UIColor(red: 180/255, green: 221/255, blue: 239/255, alpha: 1).cgColor
        //calendarView.layer.borderColor = UIColor.blue.cgColor
        calenderView.layer.masksToBounds = false
        
        calenderView.layer.shadowColor = UIColor.black.cgColor
        calenderView.layer.shadowOffset = CGSize(width:0.0,height: 2.0)
        calenderView.layer.shadowRadius = 2.0
        calenderView.layer.shadowOpacity = 0.6
        
        calenderView.dataSource = self
        calenderView.delegate = self
        calenderView.registerCellViewXib(file: "CellView") // Registering your cell is manditory
        
        // Add this new line
        calenderView.cellInset = CGPoint(x: 0, y: 0)

        
        slideBarBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        self.attendanceCollection.dataSource = self
        self.secondaryView.layer.shadowColor = UIColor.black.cgColor
        self.secondaryView.layer.shadowOpacity = 0.5
        self.secondaryView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.secondaryView.layer.shadowRadius = 2.0
        
        if fieldName != nil {
            dashLabel.text = fieldName
        }
        
        fallOutCollection.dataSource = self
        //fallOutCollection.delegate = self
        // Do any additional setup after loading the view.
        
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
    
    @IBAction func menuBtn(_ sender: Any) {
        self.view.bringSubview(toFront: primaryView)
        self.view.bringSubview(toFront: calenderScroll)
        self.view.bringSubview(toFront: engineerView)
        self.view.bringSubview(toFront: calenderView)
        self.dashLabel.text = "Attendance"
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.view.bringSubview(toFront: primaryView)
        
    }
    
}

extension DashboardViewController : UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == attendanceCollection {
            return 1
        }
        
        if collectionView == fallOutCollection {
            return 1
        }
        return 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == attendanceCollection {
            return 6
        }
        
        if collectionView == fallOutCollection {
            return 4
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == attendanceCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "attendanceSummary", for: indexPath) as! DashCollectionViewCell
            
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMMM yyyy"
            
            cell.contentView.layer.cornerRadius = 8
            cell.contentView.layer.borderWidth = 1.0
            cell.contentView.layer.borderColor = UIColor.cyan.cgColor
            
            cell.contentView.backgroundColor = UIColor.white
            cell.layer.shadowOpacity = 0.6
            cell.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            cell.layer.shadowRadius = 2.0
            cell.layer.masksToBounds = false
            
//            let dateTimeStamp = NSDate(timeIntervalSince1970: Double((dashVM?.jsonTimeStamp!)!))
            
            
            
            switch indexPath.row {
            case 0:
                cell.NumberLabel.isHidden = true
                cell.totalNumberLabel.isHidden = true
                cell.markedAttendanceData.layer.masksToBounds = true
                cell.unmarkedAttendanceData.layer.masksToBounds = true
                cell.markedAttendanceData.layer.cornerRadius = 18.65
                cell.unmarkedAttendanceData.layer.cornerRadius = 18.65
                cell.markedAttendanceData.text = dashVM?.markedAttdendance
                cell.unmarkedAttendanceData.text = dashVM?.unmarkedAttendance
                date1 = Date.init(timeIntervalSince1970: Double((dashVM?.jsonTimeStamp)! / 1000))
                print(date1!)
                cell.dateLabel.text = formatter.string(from: date1! as Date)
                break
                
            case 1:
                cell.markedLabel.isHidden = true
                cell.unmarkedLabel.isHidden = true
                cell.NumberLabel.isHidden = false
                cell.totalNumberLabel.isHidden = false
                cell.markedAttendanceData.isHidden = true
                cell.unmarkedAttendanceData.isHidden = true
                cell.titleLabel.text = "Attendance Fallout"
                cell.NumberLabel.text = dashVM?.attendanceFallNumberLabel
                let str = dashVM?.totalEmployee
                print(str!)
                cell.totalNumberLabel.text = "Out of "+str!//(dashVM?.totalEmployee)!
                cell.menuButton.isEnabled = false
                let mFormatter = DateFormatter()
                mFormatter.dateFormat = "MMMM yyyy"
                cell.dateLabel.text = mFormatter.string(from: date1!)
                break
                
            case 2:
                cell.markedAttendanceData.isHidden = true
                cell.markedLabel.isHidden = true
                cell.unmarkedAttendanceData.isHidden = true
                cell.unmarkedLabel.isHidden = true
                cell.titleLabel.text = "Leave Summary"
                cell.NumberLabel.text = dashVM?.leave
                cell.totalNumberLabel.text = "Uptill"
                cell.totalNumberLabel.textColor = UIColor(colorWithHexValue: 0x6FB8D9)
                cell.menuButton.isEnabled = false
                let mFormatter = DateFormatter()
                mFormatter.dateFormat = "MMMM yyyy"
                cell.dateLabel.text = mFormatter.string(from: date1!)
                break
                
            case 3:
                cell.titleLabel.isHidden = true
                cell.markedLabel.isHidden = true
                cell.markedAttendanceData.isHidden = true
                cell.unmarkedLabel.isHidden = true
                cell.unmarkedAttendanceData.isHidden = true
                cell.totalNumberLabel.isHidden = true
                cell.dateLabel.isHidden = true
                cell.menuButton.isEnabled = false
                
                cell.NumberLabel.text = "Engineers"
                cell.NumberLabel.textColor = UIColor(colorWithHexValue: 0x6FB8D9)
                break
                
            case 4:
                cell.titleLabel.isHidden = true
                cell.markedLabel.isHidden = true
                cell.markedAttendanceData.isHidden = true
                cell.unmarkedLabel.isHidden = true
                cell.unmarkedAttendanceData.isHidden = true
                cell.totalNumberLabel.isHidden = true
                cell.dateLabel.isHidden = true
                cell.menuButton.isEnabled = false
                
                cell.NumberLabel.text = "Clients"
                cell.NumberLabel.textColor = UIColor(colorWithHexValue: 0x6FB8D9)
                break
                
            case 5:
                cell.titleLabel.isHidden = true
                cell.markedLabel.isHidden = true
                cell.markedAttendanceData.isHidden = true
                cell.unmarkedLabel.isHidden = true
                cell.unmarkedAttendanceData.isHidden = true
                cell.totalNumberLabel.isHidden = true
                cell.dateLabel.isHidden = true
                cell.menuButton.isEnabled = false
                
                cell.NumberLabel.text = "Reports"
                cell.NumberLabel.textColor = UIColor(colorWithHexValue: 0x6FB8D9)
                break
                
            default:
                NSNull.self
            }
            return cell

        }
        
        if collectionView == fallOutCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "fallOutCell", for: indexPath) as! AttendanceFallOutCollectionViewCell
            
            return cell
            
        }
        else{
            return AttendanceFallOutCollectionViewCell.copy() as! UICollectionViewCell
        }
        
                    }
    
    
}

extension DashboardViewController: JTAppleCalendarViewDataSource {
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let formatter = DateFormatter()
        //formatter.dateFormat = "yyyy MM dd"
        formatter.setLocalizedDateFormatFromTemplate("MMMMyyyy")
        
        //if dateChanged {
       var startDate = Date()
       // }
        //formatter.date(from: "2016 03 01")! // You can use date generated from a formatter
        if dateChange {
            date = strMonth!+" "+strYear!
            print(date)
            let date1 = date!
            print(date1)
            startDate = formatter.date(from: date!)!
            print(startDate)
        }
        //let endDate = formatter.date(from: "2037 12 31")!                                // You can also use dates created from this function
        
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
extension DashboardViewController : JTAppleCalendarViewDelegate
{
        func calendar(_ calendar: JTAppleCalendarView, willDisplayCell cell: JTAppleDayCellView, date: Date, cellState: CellState) {
        let  dateCell = cell as! CellView
        
        dateCell.layer.borderWidth = 0.5
        dateCell.layer.borderColor = UIColor.lightGray.cgColor
        dateCell.dayLabel.text = cellState.text
        
        if cellState.dateBelongsTo == .thisMonth
        {
            
            dateCell.dayLabel.textColor =  UIColor(colorWithHexValue: 0x6FB8D9)
            let day = (dashVM?.dayAttendance())!
            dateCell.attendanceData.text = day+"/"+(dashVM?.totalEmployee1)!
           if (day.compare("0") == ComparisonResult.orderedDescending) {
                dateCell.attendanceData.textColor = UIColor.red
            }
           else{
               dateCell.attendanceData.textColor = UIColor.green
            }
            
        }
        else{
            dateCell.dayLabel.textColor = UIColor(colorWithHexValue: 0xA9A9A9)
            dateCell.attendanceData.isHidden = true
        }
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleDayCellView?, cellState: CellState) {
        self.view.bringSubview(toFront: fallOutView)
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("ddMMMMyyyy")
        fallOutDateLabel.text = formatter.string(from: date)
    }
    
}
extension DashboardViewController : UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return (monthArray?.count)!
        }
        
        if component == 1 {
            return (yearArray?.count)!
        }
        return 0
    }
}
extension DashboardViewController : UIPickerViewDelegate
{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0 {
            let nameOfMonth:String = monthArray!.object(at: row) as! String
            return nameOfMonth
        }
        
        if component == 1 {
            let year = yearArray!.object(at: row) as! String
            return year
        }
        return "null"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        strMonth = monthArray![pickerView.selectedRow(inComponent: 0)] as? String
        strYear = yearArray![pickerView.selectedRow(inComponent: 1)] as? String
        dateChange = true
        dateChanged = false
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("MMMMyyyy")
        let strDate = strMonth!+" "+strYear!
        let mDate = formatter.date(from: strDate)
        let mTimestamp = mDate!.timeIntervalSince1970 * 1000
        print(mTimestamp)
        dashVM?.viewModelCall(timeStamp: mTimestamp)
    }
    
    func reloadCalendar() -> Void {
        calenderView.reloadData()
    }
}
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



