//
//  SlideMenuViewController.swift
//  FundooHR
//
//  Created by BridgeLabz Solutions LLP  on 12/15/16.
//  Copyright © 2016 BridgeLabz Solutions LLP . All rights reserved.
//

import UIKit
import CoreData

class SlideMenuViewController: UIViewController {

    @IBOutlet weak var slideTableView: UITableView!
    var dashBoard:DashboardViewController?
    var loginVC:ViewController?
    
    
    var array = ["Dashboard","Engineers","Attendance Summary","Reports","Clients"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginVC = ViewController()
        slideTableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func logOut(_ sender: Any) {
        
       self.deleteToken()
       //self.prepare(for: .init(identifier: "logout", source: self, destination: ViewController), sender: nil)
        
    }
    
    func deleteToken() -> Void {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do{
            
            let fetchReq : NSFetchRequest = LoginToken1.fetchRequest()
            let userArray : [LoginToken1] = try context.fetch(fetchReq)
            
            context.delete(userArray[0])
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
        }catch{
            print("fetching failed")
        }

    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "logout" {
            
        let temp = segue.destination as! ViewController
            temp.performSegue(withIdentifier: "logout", sender: nil)
            
        }
        else
        {
        
            var indexpath:IndexPath?
            indexpath = slideTableView.indexPathForSelectedRow
            let dash = segue.destination as! DashboardViewController
            let name = array[(indexpath?.row)!]
            dash.fieldName = name
            dash.boolVar = false
            dash.index = (indexpath?.row)!
        }
        
    }
    

}
extension SlideMenuViewController:UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell") as! SlideMenuTableViewCell
        
        cell.label.text = array[indexPath.row]
        return cell
        
    }
}
