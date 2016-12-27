//
//  SlideMenuViewController.swift
//  FundooHR
//
//  Created by BridgeLabz Solutions LLP  on 12/15/16.
//  Copyright © 2016 BridgeLabz Solutions LLP . All rights reserved.
//

import UIKit

class SlideMenuViewController: UIViewController {

    @IBOutlet weak var slideTableView: UITableView!
    var dashBoard:DashboardViewController?
    
    var array = ["Dashboard","Engineers","Attendance Summary","Reports","Clients"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slideTableView.dataSource = self
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
        
        var indexpath:IndexPath?
        indexpath = slideTableView.indexPathForSelectedRow
        let dash = segue.destination as! DashboardViewController
        let name = array[(indexpath?.row)!]
        dash.fieldName = name
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
