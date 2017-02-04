//
//  DashCollectionViewCell.swift
//  FundooHR
//
//  Purpose:
//  1. It is a Class of UICollection View
//  2. It holds all the IBOutlets elements of CollectionView Cell

//  Created by BridgeLabz Solutions LLP  on 12/12/16.
//  Copyright © 2016 BridgeLabz Solutions LLP . All rights reserved.
//

import UIKit

class DashCollectionViewCell: UICollectionViewCell {
    
    //Outlet of date label
    @IBOutlet weak var mDateLabel: UILabel!
    
    //Outlet of label to display cell name
    @IBOutlet weak var mTitleLabel: UILabel!
    
    //Outlet of label to
    @IBOutlet weak var mAttendanceFallLabel: UILabel!
    @IBOutlet weak var mTotalNumberLabel: UILabel!
    
    //Outlet of marked label
    @IBOutlet weak var mMarkedLabel: UILabel!
    
    //Outlet of unmarked label
    @IBOutlet weak var mUnmarkedLabel: UILabel!
    
    //Outlet of label to display marked attendance data
    @IBOutlet weak var mMarkedAttendanceData: UILabel!
    
    //Outlet of label to display unmarked attendance data
    @IBOutlet weak var mUnmarkedAttendanceData: UILabel!
    
    //Outlet of menu button in cell
    @IBOutlet weak var mMenuButton: UIButton!
}
