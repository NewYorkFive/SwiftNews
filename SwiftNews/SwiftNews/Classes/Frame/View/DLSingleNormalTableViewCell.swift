//
//  DLSingleNormalTableViewCell.swift
//  SwiftNews
//
//  Created by NowOrNever on 03/06/2017.
//  Copyright © 2017 Focus. All rights reserved.
//

import UIKit
import SDWebImage

class DLSingleNormalTableViewCell: DLSingleBaseTableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUI(){
        contentView.addSubview(newsImgView)
        contentView.addSubview(newsTitleLabel)
        contentView.addSubview(newsSourceLabel)
        contentView.addSubview(newsReplyCountLabel)
        
        let margin:CGFloat = 10.0
        newsImgView.snp.makeConstraints { (make) in
            make.left.top.equalTo(margin)
            make.height.width.equalTo(60)
        }
        
        newsTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(newsImgView.snp.right).offset(margin)
            make.top.equalTo(margin)
        }
        
        newsSourceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(newsImgView.snp.right).offset(margin)
            make.bottom.equalTo(-margin)
        }
        
        newsReplyCountLabel.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(-margin)
        }
    }
    
    override func modelChangeAction() {
        newsImgView.sd_setImage(with: URL.init(string: (self.model?.imgsrc)!), placeholderImage: UIImage.init(named: "loading"))
        newsTitleLabel.text = model?.title
        newsSourceLabel.text = model?.source
        newsReplyCountLabel.text = model?.replyCount.description
    }
    
    // MARK: lazy load
    fileprivate lazy var newsImgView:UIImageView = {
        let imageView = UIImageView.init()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    fileprivate lazy var newsTitleLabel:UILabel = UILabel.init(title: "", fontSize: 15, color: UIColor.black)
    
    fileprivate lazy var newsSourceLabel:UILabel = UILabel.init(title: "", fontSize: 13, color: UIColor.lightGray)
    
    fileprivate lazy var newsReplyCountLabel:UILabel = UILabel.init(title: "", fontSize: 13, color: UIColor.lightGray)

}
