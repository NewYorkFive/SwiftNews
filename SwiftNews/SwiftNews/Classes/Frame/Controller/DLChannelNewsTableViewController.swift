//
//  DLChannelNewsTableViewController.swift
//  SwiftNews
//
//  Created by NowOrNever on 03/06/2017.
//  Copyright © 2017 Focus. All rights reserved.
//

import UIKit
import YYModel

private let normalCellID = "normalCellID"
private let bigImageCellId = "bigImageCellId"
private let multiPicsCellId = "multiPicsCellId"

class DLChannelNewsTableViewController: UITableViewController {

    fileprivate var singleNewsModelArray:[DLSingleNewModel] = [DLSingleNewModel]()
    
    var channelNewsUrlsString:String = "" {
        didSet{
            channelNewsUrlsString = channelNewsUrlsString + "/0-20.html"
            
            
            DLNetworkTools.sharedTools.request(type: .get, urlString: channelNewsUrlsString, params: nil) { (responseObject, error) in
                if error != nil {
                    print("internet request error")
                }else{
//                    print(responseObject)
//                    self.singleNewsModelArray = NSArray.yy_modelArray(with: DLSingleNewModel.self, json: responseObject!) as! [DLSingleNewModel]
                    guard let dic =  responseObject as? [String : Any] else {
                        print("the json was wrong")
                        return
                    }
//                    let modelArray = (dic.values.first) as! [String:Any]
                    let array:[[String:Any]] = dic.values.first as! [[String:Any]]
//                    print(array)
                    self.singleNewsModelArray = NSArray.yy_modelArray(with: DLSingleNewModel.self, json: array) as! [DLSingleNewModel]
//                    print(modelArray)
                    self.tableView.reloadData()
                }
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    fileprivate func setupUI(){
        view.backgroundColor = UIColor.randomColor()
        
        tableView.register(DLSingleNormalTableViewCell.self, forCellReuseIdentifier: normalCellID)
        tableView.register(DLSinglePicsTableViewCell.self, forCellReuseIdentifier: multiPicsCellId)
        tableView.register(DLSingleBigPicTableViewCell.self, forCellReuseIdentifier: bigImageCellId)
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return singleNewsModelArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:DLSingleBaseTableViewCell?
        let model = self.singleNewsModelArray[indexPath.row]
        if model.imgType {
            cell = tableView.dequeueReusableCell(withIdentifier: bigImageCellId, for: indexPath) as! DLSingleBigPicTableViewCell
        }else if ((self.singleNewsModelArray[indexPath.row].imgextra?.count) ?? 0) >= 2{
            cell = tableView.dequeueReusableCell(withIdentifier: multiPicsCellId, for: indexPath) as! DLSinglePicsTableViewCell
        }else{
            cell = tableView.dequeueReusableCell(withIdentifier: normalCellID, for: indexPath) as! DLSingleNormalTableViewCell
        }
        cell?.model = model
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if singleNewsModelArray[indexPath.row].imgType {
            return 130.0
        }
        if ((self.singleNewsModelArray[indexPath.row].imgextra?.count) ?? 0) >= 2 {
            return 180.0
        }
        return 80.0
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
