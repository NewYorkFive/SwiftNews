//
//  DLSinglePicsTableViewCell.swift
//  SwiftNews
//
//  Created by NowOrNever on 03/06/2017.
//  Copyright © 2017 Focus. All rights reserved.
//

import UIKit

class DLSinglePicsTableViewCell: DLSingleBaseTableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUI(){
        contentView.addSubview(newsTitleLabel)
        contentView.addSubview(newsSourceLabel)
        contentView.addSubview(newsReplyCountLabel)
        
        let margin:CGFloat = 10.0
        newsTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(margin)
            make.top.equalTo(margin * 0.5)
        }
        
        let pictureContainerView = UIView.init()
//        pictureContainerView.backgroundColor = UIColor.black
        contentView.addSubview(pictureContainerView)
        pictureContainerView.snp.makeConstraints { (make) in
            make.top.equalTo(margin * 2.5)
            make.bottom.equalTo(margin * -2.5)
            make.left.equalTo(margin)
            make.right.equalTo(-margin)
        }
        
        layoutIfNeeded()
        let imageWidth = (ScreenWidth - margin * 2.0 - CGFloat(newsImageViews.count - 1) * margin * 0.5) /  CGFloat(newsImageViews.count)
//        print(pictureContainerView.width)
//        print(CGFloat(newsImageViews.count - 1) * margin * 0.5)
//        print(CGFloat(newsImageViews.count))
        
        for i in 0 ..< newsImageViews.count {
            let tempImageView = newsImageViews[i]
            pictureContainerView.addSubview(tempImageView)
            tempImageView.snp.makeConstraints({ (make) in
                make.top.bottom.equalTo(pictureContainerView)
                make.left.equalTo(CGFloat(i) * (imageWidth + margin * 0.5))
                make.width.equalTo(imageWidth)
            })
        }
        
        newsSourceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(margin)
            make.bottom.equalTo(-margin)
        }
        
        newsReplyCountLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-margin)
            make.bottom.equalTo(-margin)
        }
    }
    
    override func modelChangeAction() {
        newsImageView.sd_setImage(with: URL.init(string: (model?.imgsrc)!), placeholderImage: UIImage.init(named: "loading"))
        newsTitleLabel.text = model?.title
        newsSourceLabel.text = model?.source
        newsReplyCountLabel.text = model?.replyCount.description
        for i in 1..<self.newsImageViews.count {
            self.newsImageViews[i].sd_setImage(with: URL.init(string: (model?.imgextra?[i - 1]["imgsrc"])!), placeholderImage: UIImage.init(named: "loading"))
        }
    }

    //MARK:lazy load
    fileprivate lazy var newsImageViews:[UIImageView] = {
        var imageViews = [UIImageView]()
        for i in 0..<3{
            let imageView = UIImageView.init()
            imageView.contentMode = .scaleAspectFill;
            imageView.clipsToBounds = true;
            imageViews.append(imageView)
        }
        return imageViews
    }()
    
    fileprivate lazy var newsImageView:UIImageView = {
        return self.newsImageViews[0]
    }()
    
    fileprivate lazy var newsTitleLabel:UILabel = UILabel.init(title: "", fontSize: 15, color: UIColor.black)
    
    fileprivate lazy var newsSourceLabel:UILabel = UILabel.init(title: "", fontSize: 13, color: UIColor.lightGray)
    
    fileprivate lazy var newsReplyCountLabel:UILabel = UILabel.init(title: "", fontSize: 13, color: UIColor.lightGray)
}
