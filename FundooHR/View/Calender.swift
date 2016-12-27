//
//  Calender.swift
//  FundooHR
//
//  Created by BridgeLabz Solutions LLP  on 12/19/16.
//  Copyright © 2016 BridgeLabz Solutions LLP . All rights reserved.
//

import UIKit
import JTAppleCalendar

class Calender: UIViewController {

    @IBOutlet weak var calenderView: JTAppleCalendarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calenderView.layer.borderWidth = 3
        calenderView.layer.borderColor = UIColor(red: 180/255, green: 221/255, blue: 239/255, alpha: 1).cgColor
        //calendarView.layer.borderColor = UIColor.blue.cgColor
        calenderView.layer.masksToBounds = false
        
//        calenderView.layer.cornerRadius = 8
        calenderView.layer.shadowColor = UIColor.black.cgColor
        calenderView.layer.shadowOffset = CGSize(width:0.0,height: 2.0)
        calenderView.layer.shadowRadius = 2.0
        calenderView.layer.shadowOpacity = 0.6
        
        calenderView.dataSource = self
        calenderView.delegate = self
        calenderView.registerCellViewXib(file: "CellView") // Registering your cell is manditory
        
        // Add this new line
        calenderView.cellInset = CGPoint(x: 0, y: 0)
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension Calender: JTAppleCalendarViewDataSource {
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        
        let startDate = formatter.date(from: "2016 01 01")! // You can use date generated from a formatter
        let endDate = Date()                                // You can also use dates created from this function
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
extension Calender : JTAppleCalendarViewDelegate
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
        
        myCustomCell.dayLabel.text = cellState.text
        
        if cellState.dateBelongsTo == .thisMonth
        {
            myCustomCell.dayLabel.textColor =  UIColor.black
        }
        else{
            myCustomCell.dayLabel.textColor = UIColor.gray
        }
    }
 
}
//extension UIColor {
//    convenience init(colorWithHexValue value: Int, alpha:CGFloat = 1.0){
//        self.init(
//            red: CGFloat((value & 0xFF0000) >> 16) / 255.0,
//            green: CGFloat((value & 0x00FF00) >> 8) / 255.0,
//            blue: CGFloat(value & 0x0000FF) / 255.0,
//            alpha: alpha
//        )
//    }
//}
