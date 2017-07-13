//
//  DLFrameViewController.swift
//  SwiftNews
//
//  Created by NowOrNever on 01/06/2017.
//  Copyright © 2017 Focus. All rights reserved.
//

import UIKit
import SnapKit

private let channelButtonWidth = 80.0
private let channelButtonHeight = 40.0

private let channelCollectionViewCellID = "channelCollectionViewCellID"

class DLFrameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    //MARK: 1.0 setupUI
    fileprivate func setupUI(){
        self.automaticallyAdjustsScrollViewInsets = false;
        
        view.backgroundColor = UIColor.randomColor()
    
        setupChannelScrollView()
        
        setupChannelCollectionView()
        
        currentTitleButton = channelTitleButtonArray[0]
//        for item in channelModelArray {
//            print("\n")
//            print(item.tid!)
//            print(item.tname!)
//        }
    }
    
    //MARK: 1.1 setupChannelScrollView

    fileprivate func setupChannelScrollView() -> Void {
        
        channelScrollView.backgroundColor = UIColor.darkGray
        channelScrollView.bounces = false
        channelScrollView.showsVerticalScrollIndicator = false
        channelScrollView.showsHorizontalScrollIndicator = false
        
        view.addSubview(channelScrollView)
        
        channelScrollView.snp.makeConstraints { (make) in
            make.top.equalTo(64)
            make.height.equalTo(channelButtonHeight)
            make.left.right.equalTo(view)
        }
        
        channelScrollView.addSubview(channelScrollViewContainView)
        
        for item in channelTitleButtonArray {
            channelScrollViewContainView.addSubview(item)
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        channelScrollViewContainView.frame = CGRect(x: 0, y: 0, width: Double(channelTitleButtonArray.count) * channelButtonWidth, height: channelButtonHeight)
        
        channelScrollView.contentSize = channelScrollViewContainView.frame.size
        
        for index in 0..<channelTitleButtonArray.count {
            channelTitleButtonArray[index].frame = CGRect(x: Double(index) * channelButtonWidth, y: 0, width: channelButtonWidth, height: channelButtonHeight)
        }
        
    }
    
    //MARK: 1.2 setupChannelCollectionView
    
    fileprivate func setupChannelCollectionView(){
        view.addSubview(channelCollectionView)
        channelCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(channelScrollView.snp.bottom)
            make.left.right.bottom.equalTo(view)
        }
        
        channelCollectionView.backgroundColor = UIColor.brown
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: lazy load
    fileprivate lazy var channelCollectionView:UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: DLChannelCollectionViewFlowLayout())

        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(DLChannelCollectionViewCell.self, forCellWithReuseIdentifier: channelCollectionViewCellID)

        return collectionView
    }()
    
    fileprivate lazy var channelScrollViewContainView = {
        return UIView.init()
    }()
    
    fileprivate lazy var channelScrollView:UIScrollView = {
        let scrollview = UIScrollView.init()
        return scrollview
    }()
    
    fileprivate lazy var channelTitleButtonArray:[UIButton] = {
        var array = [UIButton]()
        for item in self.channelModelArray{
            let button = UIButton.init(title: item.tname!, target: self, action: #selector(titleButtonAction(sender:)), fontSize: 15, color: UIColor.white)
//            let button = UIButton.init(title: item.tname!, target: self, action: #selector(buttonAction(sender:)))
            array.append(button)
        }
        return array
    }()
    
    @objc fileprivate func titleButtonAction(sender:UIButton) -> Void {
        if currentTitleButton == sender {
            return;
        }
        buttonChangeWithButton(sender: currentTitleButton, percentage: 0.0)
        buttonChangeWithButton(sender: sender, percentage: 1.0)
        currentTitleButton = sender;
        
        var offsetX = sender.center.x - UIScreen.main.bounds.size.width * 0.5;
        
        if offsetX > channelScrollView.contentSize.width - ScreenWidth * 0.5 {
            offsetX = channelScrollView.contentSize.width - ScreenWidth * 0.5
        }

        
        if offsetX < 0 {
            offsetX = 0
        }
        
//        print(channelScrollView.contentSize.width)
//        print(offsetX)

        channelScrollView.setContentOffset(CGPoint.init(x: offsetX, y: 0), animated: true)
        
        let index:Int = Int(sender.frame.origin.x / sender.frame.size.width)
        let indexPath = IndexPath.init(item: index, section: 0)
        channelCollectionView.scrollToItem(at: indexPath, at:.left , animated: false)
    }
    
    func buttonChangeWithButton(sender:UIButton, percentage:Float) -> Void {
        sender.setTitleColor(UIColor.init(colorLiteralRed: 1.0, green: 1 - percentage, blue: 1 - percentage, alpha: 1.0), for: .normal)
        sender.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(15 + percentage * 2))
    }
    
    fileprivate lazy var currentTitleButton:UIButton = UIButton()
    
    fileprivate lazy var channelModelArray:[DLChannelModel] = try! {
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

}

extension DLFrameViewController:UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.channelModelArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: channelCollectionViewCellID, for: indexPath) as! DLChannelCollectionViewCell
        cell.model = channelModelArray[indexPath.item]
        return cell
    }
}

extension DLFrameViewController:UICollectionViewDelegate{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var index:Int = Int(scrollView.contentOffset.x / scrollView.width)
        if scrollView.width == 0{
            index = 0;
        }
        titleButtonAction(sender: channelTitleButtonArray[index])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var floatIndex = scrollView.contentOffset.x / scrollView.width
        if scrollView.width == 0 {
            floatIndex = 0.0;
        }
        let intIndex = Int(floatIndex)
        let percentage = floatIndex - CGFloat(intIndex)
        
        buttonChangeWithButton(sender: channelTitleButtonArray[intIndex], percentage: Float(1 - percentage))
        if intIndex + 1 < self.channelTitleButtonArray.count {
            buttonChangeWithButton(sender: channelTitleButtonArray[intIndex + 1], percentage: Float(percentage))
        }
    }
    
}

