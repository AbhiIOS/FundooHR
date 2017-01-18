//
//  DashboardServices.swift
//  FundooHR
//
//  Created by BridgeLabz Solutions LLP  on 12/29/16.
//  Copyright © 2016 BridgeLabz Solutions LLP . All rights reserved.
//

import UIKit
import CoreData
import Alamofire

class DashboardServices: NSObject {
    
    var delegate:ControllerProtocol?
    
    
    var fallOutNum:Int?
    var totalEmployee:Int?
    var marked:Int?
    var unmarked:String?
    var leave:String?
    
    var totalEmployee2:String?
    var unmarkedNumber:String?
    var unmarkedEmployee:NSArray = []
    var unmark:[UnmarkedEmployee]?
    
    var monthlyAttendance:NSArray = []
    var perDayAttendance:NSMutableArray = []
    var totalEmp:Int?
    var token:String?
    var timeStamp:Int?
    var timeStamp2:CLong?
    
    var monthArray:NSMutableArray = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    var yearArray:NSMutableArray = ["2016", "2017", "2018", "2019", "2020", "2021", "2022", "2023", "2024", "2025", "2026", "2027", "2028", "2029", "2030", "2031", "2032", "2033", "2034", "2035", "2036", "2037"]
    
    
    
    func CallToService() -> Void {
        
        self.delegate?.recievePickerDataFromServices(arrayMonth: self.monthArray, arrayYear: self.yearArray)
        
        let token = self.fetchToken()
        timeStamp = Int(Date().timeIntervalSince1970 * 1000)
        print(timeStamp!)
        
//        let urlString: String = "http://192.168.0.118:3000/readDashboardData"
//        let params = ["token":  (token)/*"admin@bridgelabz.com"*/, "timeStamp" : (timeStamp!)/*"Bridge@123"*/] as [String : Any]
//        Alamofire.request(urlString, method: .get, parameters: params, encoding: JSONEncoding.default)
//            .responseJSON { response in
//                print("--response--",response)
//                print("result----",response.result)
//                if((response.result).isSuccess){
//                    print("result-------",response.result)
//                    
//                    let json = response.result.value as! NSDictionary
//                    print(json)
//                    
//                    let timeStamp2 = json["timeStamp"] as! CLong
//                    
//                    let attendanceSummary = json["attendanceSummary"] as! NSDictionary
//                    self.marked = attendanceSummary["marked"] as? Int
//                    self.unmarked = attendanceSummary["unmarked"] as? String
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
//                    
//                }
//               // print("Hello")
//                
//        }

        
//                Alamofire.request("http://192.168.0.171:3000/readDashboardData?token=\(token)&timeStamp=\(timeStamp!)").responseJSON
//                    { response in
//                        print("response----",response)
//                        print("result----",response.result)
//                        if((response.result).isSuccess){
//                            print("result-------",response.result)
//        
//                            let json = response.result.value as! NSDictionary
//                            print(json)
//        
//                            let timeStamp2 = json["timeStamp"] as! CLong
//        
//                            let attendanceSummary = json["attendanceSummary"] as! NSDictionary
//                            self.marked = attendanceSummary["marked"] as? Int
//                            self.unmarked = attendanceSummary["unmarked"] as? String
//        
//                            let attendanceFallout = json["attendanceFallout"] as! NSDictionary
//                            self.fallOutNum = attendanceFallout["falloutEmployee"] as? Int
//                            self.totalEmployee = attendanceFallout["totalEmployee"] as? Int
//        
//                            let leaveSummary = json["leaveSummary"] as! NSDictionary
//                            self.leave = leaveSummary["leave"] as? String
//        
//        
//                            self.delegate?.recieveDashboardDataFromServices(markedData: self.marked, unmarkedData: self.unmarked, attendanceFallNumber: self.fallOutNum, leave1: self.leave, totalEmployee11: self.totalEmployee, timeStamp: timeStamp2)
//        
//          }
//        
//           }

        
        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        let url = URL(string: "http://192.168.0.118:3000/readDashboardData?token=\(token)&timeStamp=\(timeStamp!)")!
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            
            if error != nil {
                
                print(error!.localizedDescription)
                
            } else {
                
                do {
                    
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]
                    {
                        
                        //Implement your logic
                        let dashboardData = json as NSDictionary
                        print(dashboardData)
                        
                        self.timeStamp2 = dashboardData["timeStamp"] as? CLong
                        print(self.timeStamp2!)
                        let attendanceSummary = dashboardData["attendanceSummary"] as! NSDictionary
                        self.marked = attendanceSummary["marked"] as? Int
                        self.unmarked = attendanceSummary["unmarked"] as? String
                        
                        let attendanceFallout = dashboardData["attendanceFallout"] as! NSDictionary
                        self.fallOutNum = attendanceFallout["falloutEmployee"] as? Int
                        self.totalEmployee = attendanceFallout["totalEmployee"] as? Int
                        
                        let leaveSummary = dashboardData["leaveSummary"] as! NSDictionary
                        self.leave = leaveSummary["leave"] as? String
                        
                        self.delegate?.recieveDashboardDataFromServices(markedData: self.marked, unmarkedData: self.unmarked, attendanceFallNumber: self.fallOutNum, leave1: self.leave, totalEmployee11: self.totalEmployee, timeStamp: self.timeStamp2)
                        
 
                    }
                    
                } catch {
                    
                    print("error in JSONSerialization")
                    
                }
                
                
            }
            
        })
        task.resume()
        
    }
    
    func callToServices1() -> Void {
        
        let token2 = self.fetchToken()
        
        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        let url = URL(string: "http://192.168.0.118:3000/readMonthlyAttendanceSummary?token=\(token2)&timeStamp=\(timeStamp!)")!
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            
            if error != nil {
                
                print(error!.localizedDescription)
                
            } else {
                
                do {
                    
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]
                    {
                        
                        //Implement your logic
                        let monthlyAttendance = json as NSDictionary
                        self.totalEmp = monthlyAttendance["totalEmployee"] as? Int
                        self.monthlyAttendance = monthlyAttendance["attendance"] as! NSArray
                        for ary in self.monthlyAttendance
                        {
                            let attendance = ary as! NSDictionary
                            self.perDayAttendance.add(attendance)
                            
                        }
                        print(self.perDayAttendance)
                        let sortedArray = self.perDayAttendance.sorted{(($0 as! NSDictionary)["day"]as? Int)!<(($1 as! NSDictionary)["day"]as? Int)!}
                    print(sortedArray)
                        
                        self.delegate?.recieveMonthlyAttendanceDataFromServices(perDayAttendance1: sortedArray as NSArray, totalEmp: self.totalEmp)
                    }
                    
                } catch {
                    
                    print("error in JSONSerialization")
                    
                }
                
                
            }
            
        })
        task.resume()
        
    }
    
    func callServices2(timestamp:Double) -> Void {
        
       let token3 = self.fetchToken()
        
        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        let url = URL(string: "http://192.168.0.118:3000/readMonthlyAttendanceSummary?token=\(token3)&timeStamp=\(timestamp)")!
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            
            if error != nil {
                
                print(error!.localizedDescription)
                
            } else {
                
                do {
                    
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]
                    {
                        
                        //Implement your logic
                        let monthlyAttendance = json as NSDictionary
                        self.totalEmp = monthlyAttendance["totalEmployee"] as? Int
                        self.monthlyAttendance = monthlyAttendance["attendance"] as! NSArray
                        for ary in self.monthlyAttendance
                        {
                            let attendance = ary as! NSDictionary
                            self.perDayAttendance.add(attendance)
                            
                        }
                        print(self.perDayAttendance)
                        let sortedArray = self.perDayAttendance.sorted{(($0 as! NSDictionary)["day"]as? Int)!<(($1 as! NSDictionary)["day"]as? Int)!}
                        print(sortedArray)
                        
                        self.delegate?.recieveMonthlyAttendanceDataFromServices11(perDayAttendance1: sortedArray as NSArray, totalEmp: self.totalEmp)
                    }
                    
                } catch {
                    
                    print("error in JSONSerialization")
                    
                }
                
                
            }
            
        })
        task.resume()

    }
    
    func fetchToken() -> String
    {
        var detailsArray : [LoginToken1]?
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do{
            
            let fetchReq : NSFetchRequest = LoginToken1.fetchRequest()
            detailsArray = try context.fetch(fetchReq)
            self.token = detailsArray?[0].tokenData
            print(token!)
            
        }catch{
            print("fetching failed")
        }
        return token!
    }

    }
    

