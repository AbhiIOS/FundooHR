//
//  File.swift
//  FundooHR
//
//  Created by BridgeLabz Solutions LLP  on 12/14/16.
//  Copyright © 2016 BridgeLabz Solutions LLP . All rights reserved.
//

import Foundation
import UIKit

class TextField:UITextField
{
    override func draw(_ rect: CGRect) {
        let startingPoint = CGPoint(x: rect.minX, y:rect.maxY)
        let endingPoint = CGPoint(x:rect.maxX, y:rect.maxY)
        
        let path = UIBezierPath()
        path.move(to: startingPoint)
        path.addLine(to: endingPoint)
        path.lineWidth = 2.0
        
        tintColor.setStroke()
        path.stroke()
    }
}

extension UITextField
{
    func underlined()
    {
        let border = CALayer()
        let width = CGFloat(1.0)
        
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true

    }
}
