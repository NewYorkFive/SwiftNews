//
//  DLSingleBigPicTableViewCell.swift
//  SwiftNews
//
//  Created by NowOrNever on 03/06/2017.
//  Copyright © 2017 Focus. All rights reserved.
//

import UIKit

class DLSingleBigPicTableViewCell: DLSingleBaseTableViewCell {
    
    fileprivate func setupUI(){
        contentView.addSubview(newsImageView)
        contentView.addSubview(newsTitleLabel)
        contentView.addSubview(newsSourceLabel)
        contentView.addSubview(newsReplyCountLabel)
        let margin = 10.0
        newsTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(margin)
            make.top.equalTo(margin * 0.5)
        }
        newsSourceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(margin)
            make.bottom.equalTo(-margin)
        }
        newsReplyCountLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-margin)
            make.bottom.equalTo(-margin)
        }
        
        newsImageView.snp.makeConstraints { (make) in
            make.top.equalTo(newsTitleLabel.snp.bottom).offset(margin * 0.5)
            make.bottom.equalTo(newsSourceLabel.snp.top).offset(-margin * 0.5)
            make.left.equalTo(margin)
            make.right.equalTo(-margin)
        }

    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func modelChangeAction() {
        newsImageView.sd_setImage(with: URL.init(string: (self.model?.imgsrc)!), placeholderImage: UIImage.init(named: "loading"))
        newsTitleLabel.text = model?.title
        newsSourceLabel.text = model?.source
        newsReplyCountLabel.text = model?.replyCount.description
    }
    
    //MARK:lazy load
    fileprivate lazy var newsImageView:UIImageView = {
        let imageView = UIImageView.init()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    fileprivate lazy var newsTitleLabel:UILabel = UILabel.init(title: "", fontSize: 15, color: UIColor.black)
    
    fileprivate lazy var newsSourceLabel:UILabel = UILabel.init(title: "", fontSize: 13, color: UIColor.lightGray)
    
    fileprivate lazy var newsReplyCountLabel:UILabel = UILabel.init(title: "", fontSize: 13, color: UIColor.lightGray)
    
}
