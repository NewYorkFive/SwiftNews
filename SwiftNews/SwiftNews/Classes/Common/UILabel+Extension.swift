//
//  UILabel+Extension.swift
//  Swift_Sudoku_Solver
//
//  Created by NowOrNever on 23/04/2017.
//  Copyright © 2017 Focus. All rights reserved.
//

import UIKit

extension UILabel{
    class func titleLabel() -> UILabel{
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "title".localizedString()
        label.sizeToFit()
        label.textColor = UIColor.white
        return label
    }
    
//    convenience init(title:String, target:Any?, action:Selector, fontSize:CGFloat, color:UIColor){
    convenience init(title:String, fontSize:CGFloat, color:UIColor){
        self.init()
        self.text = title
        self.textColor = color
        self.font = UIFont.systemFont(ofSize: fontSize)
    }

}
