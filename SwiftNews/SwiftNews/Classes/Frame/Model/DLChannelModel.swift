//
//  DLChannelModel.swift
//  SwiftNews
//
//  Created by NowOrNever on 01/06/2017.
//  Copyright © 2017 Focus. All rights reserved.
//

import UIKit

class DLChannelModel: NSObject {
    var tid:String?
    var tname:String?
    
    override func value(forKey key: String) -> Any? {
       return super.value(forKey: key)
    }
    
//    override func value(forUndefinedKey key: String) -> Any? {
//        return 
//    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    
}
