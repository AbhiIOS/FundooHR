//
//  FalloutViewController.swift
//  FundooHR
//
//  Created by BridgeLabz Solutions LLP  on 2/1/17.
//  Copyright © 2017 BridgeLabz Solutions LLP . All rights reserved.
//

import UIKit

class FalloutViewController: UIViewController {

    @IBOutlet weak var mTimestamp: UILabel!
    
    var mTimeStamp:Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mTimestamp.text = String(mTimeStamp!)

        // Do any additional setup after loading the view.
    }

    @IBAction func backBtn(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
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
