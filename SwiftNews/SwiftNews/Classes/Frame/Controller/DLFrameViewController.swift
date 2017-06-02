//
//  DLFrameViewController.swift
//  SwiftNews
//
//  Created by NowOrNever on 01/06/2017.
//  Copyright © 2017 Focus. All rights reserved.
//

import UIKit

class DLFrameViewController: UIViewController {
    
    lazy var channelModelArray:[DLChannelModel] = try! {
        var array = [DLChannelModel]();
//        let jsonPath = Bundle.main.path(forResource: "topic_news.json", ofType: nil)
//        let jsonUrl = URL(fileURLWithPath: path!)
        let jsonUrl = Bundle.main.url(forResource: "topic_news.json", withExtension: nil)!
        let jsonData = try Data.init(contentsOf: jsonUrl)
        let dict:[String:Any] = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions(rawValue: 0)) as! [String:Any]
        let tempArray:[[String:Any]] = dict["tList"] as! [[String:Any]]
        for item in tempArray{
            let model = DLChannelModel()
            model.setValuesForKeys(item)
            array.append(model)
        }
        return array;
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.randomColor()
        for item in channelModelArray {
            print("\n")
            print(item.tid!)
            print(item.tname!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
