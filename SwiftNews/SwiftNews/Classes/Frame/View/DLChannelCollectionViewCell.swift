//
//  DLChannelCollectionViewCell.swift
//  SwiftNews
//
//  Created by NowOrNever on 03/06/2017.
//  Copyright © 2017 Focus. All rights reserved.
//

import UIKit

class DLChannelCollectionViewCell: UICollectionViewCell {

    var model:DLChannelModel?{
        didSet{
            self.channelTableViewController.channelNewsUrlsString = (model?.tid)!
        }
    }
    
    fileprivate lazy var channelTableViewController:DLChannelNewsTableViewController = {
        let vc = DLChannelNewsTableViewController()
        return vc
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUI(){
        contentView.addSubview(self.channelTableViewController.tableView)
        self.channelTableViewController.tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
    }
    
}
