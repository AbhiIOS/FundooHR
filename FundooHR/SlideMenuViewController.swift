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
    @IBOutlet weak var sliderEmailLabel: UILabel!
    
    var dashBoard:DashboardViewController?
    var loginVC:ViewController?
    var emailIdLabel:String?
    
    var array = ["Dashboard","Engineers","Attendance Summary","Reports","Clients"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginVC = ViewController()
        slideTableView.dataSource = self
        let emailid = self.fetchEmail()
        sliderEmailLabel.text = emailid
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func logOut(_ sender: Any) {
        
       self.deleteToken()
       let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
        
        self.present(viewController, animated: false, completion: nil)
        
    }
    
    func deleteToken() -> Void {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do{
            
            let fetchReq : NSFetchRequest = LoginToken1.fetchRequest()
            let userArray : [LoginToken1] = try context.fetch(fetchReq)
            
            for i in userArray
            {
              context.delete(i)
            }
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
        }catch{
            print("fetching failed")
        }

    }
    
    func fetchEmail() -> String
    {
        var detailsArray : [LoginToken1]?
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do{
            
            let fetchReq : NSFetchRequest = LoginToken1.fetchRequest()
            detailsArray = try context.fetch(fetchReq)
            emailIdLabel = detailsArray?[0].emailID
            
            
        }catch{
            print("fetching failed")
        }
        return emailIdLabel!
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
            var indexpath:IndexPath?
            indexpath = slideTableView.indexPathForSelectedRow
            let dash = segue.destination as! DashboardViewController
            let name = array[(indexpath?.row)!]
            dash.fieldName = name
            dash.boolVar = false
            dash.index = (indexpath?.row)!
        
        
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
