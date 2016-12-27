//
//  DashboardViewController.swift
//  FundooHR
//
//  Created by BridgeLabz Solutions LLP  on 12/10/16.
//  Copyright © 2016 BridgeLabz Solutions LLP . All rights reserved.
//

import UIKit
import JTAppleCalendar

class DashboardViewController: UIViewController {

    @IBOutlet weak var calenderView: JTAppleCalendarView!
    
    @IBOutlet weak var customPickerView: UIPickerView!
    
    @IBOutlet weak var primaryView: UIView!
    @IBOutlet weak var secondaryView: UIView!
    @IBOutlet weak var calenderScroll: UIScrollView!
    
    @IBOutlet weak var slideBarBtn: UIButton!
    
    @IBOutlet weak var attendanceCollection: UICollectionView!
    
    @IBOutlet weak var dashLabel: UILabel!
    @IBOutlet weak var engineerView: UIView!
    @IBOutlet weak var dashBoard: UIView!
    
    var fieldName:String? = nil
    var index:Int = 0
    var strMonth:String?
    var strYear:String?
    var date:Date?
    var dateChange:Bool = false
    
    var monthArray:NSMutableArray = ["January", "Febraury", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    var yearArray:NSMutableArray = ["2016", "2017", "2018", "2019", "2020", "2021", "2022", "2023", "2024", "2025", "2026", "2027", "2028", "2029", "2030", "2031", "2032", "2033", "2034", "2035", "2036", "2037"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        customPickerView.dataSource = self
        customPickerView.delegate = self
        
        let formatter = DateFormatter()
        let formatter1 = DateFormatter()
        
        formatter.setLocalizedDateFormatFromTemplate("MMMM")
        formatter1.setLocalizedDateFormatFromTemplate("yyyy")
        let currentMonth = formatter.string(from: Date())
        let currentYear = formatter1.string(from: Date())
        
        for var i in 0..<monthArray.count {
            if monthArray.object(at: i)as! String == currentMonth {
                customPickerView.selectRow(i, inComponent: 0, animated: true)
                break
            }
        }
        for var j in 0..<yearArray.count {
            if yearArray.object(at: j) as! String == currentYear {
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
    
}

extension DashboardViewController : UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
        
        cell.dateLabel.text = formatter.string(from: Date())
        
        if indexPath.row == 0 {
            cell.NumberLabel.isHidden = true
            cell.totalNumberLabel.isHidden = true
        }
        
        if indexPath.row == 1 {
            cell.markedLabel.isHidden = true
            cell.unmarkedLabel.isHidden = true
            cell.NumberLabel.isHidden = false
            cell.totalNumberLabel.isHidden = false
            cell.titleLabel.text = "Attendance Fallout"
        }
        return cell
    }
    
    
    
}
extension DashboardViewController: JTAppleCalendarViewDataSource {
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let formatter = DateFormatter()
        //formatter.dateFormat = "yyyy MM dd"
        formatter.setLocalizedDateFormatFromTemplate("MMMMyyyy")
        
        var startDate = Date()//formatter.date(from: "2016 03 01")! // You can use date generated from a formatter
        if dateChange {
            let date = strMonth!+" "+strYear!
            print(date)
            startDate = formatter.date(from: date)!
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
    //    func calendar(_ calendar: JTAppleCalendarView, willDisplayCell cell: JTAppleDayCellView, date: Date, cellState: CellState) {
    //        let myCustomCell = cell as! CellView
    //        cell.layer.borderWidth = 1
    //        cell.layer.borderColor = UIColor.lightGray.cgColor
    //        cell.layer.masksToBounds = true
    //        // Setup Cell text
    //        myCustomCell.dayLabel.text = cellState.text
    //
    //        //if date == todayDate{
    //        //  myCustomCell.dayLabel.textColor = UIColor.red
    //        //}
    //        //else{
    //        //handleCellTextColor(view: cell, cellState: cellState)
    //        //handleCellSelection(view: cell, cellState: cellState)
    //        //}
    //        // Setup text color
    //        if cellState.dateBelongsTo == .thisMonth {
    //            myCustomCell.dayLabel.textColor = UIColor.black
    //        } else {
    //            myCustomCell.dayLabel.textColor = UIColor.gray
    //        }
    //    }
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplayCell cell: JTAppleDayCellView, date: Date, cellState: CellState) {
        let myCustomCell = cell as! CellView
        
        myCustomCell.layer.borderWidth = 0.5
        myCustomCell.layer.borderColor = UIColor.lightGray.cgColor
        myCustomCell.dayLabel.text = cellState.text
        
        if cellState.dateBelongsTo == .thisMonth
        {
            
            myCustomCell.dayLabel.textColor =  UIColor(colorWithHexValue: 0x6FB8D9)
            myCustomCell.attendanceData.text = "0/100"
            myCustomCell.attendanceData.textColor = UIColor.red
        }
        else{
            myCustomCell.dayLabel.textColor = UIColor(colorWithHexValue: 0xA9A9A9)
            myCustomCell.attendanceData.isHidden = true
        }
    }
    
}
extension DashboardViewController : UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return 12
        }
        
        if component == 1 {
            return 22
        }
        return 0
    }
}
extension DashboardViewController : UIPickerViewDelegate
{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0 {
            let nameOfMonth:String = monthArray.object(at: row) as! String
            return nameOfMonth
        }
        
        if component == 1 {
            let year = yearArray.object(at: row) as! String
            return year
        }
        return "null"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        strMonth = monthArray[pickerView.selectedRow(inComponent: 0)] as! String
        strYear = yearArray[pickerView.selectedRow(inComponent: 1)] as! String
        dateChange = true
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



