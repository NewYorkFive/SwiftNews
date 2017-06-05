//
//  DLSingleNewModel.swift
//  SwiftNews
//
//  Created by NowOrNever on 03/06/2017.
//  Copyright © 2017 Focus. All rights reserved.
//

import UIKit

class DLSingleNewModel: NSObject {
    
    var title:String = ""
    var imgsrc:String = ""
    var source:String = ""
    var replyCount:Int = 0
    var imgextra:[[String:String]]?
    var imgType:Bool = false
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
}
