//
//  DLChannelCollectionViewFlowLayout.swift
//  SwiftNews
//
//  Created by NowOrNever on 03/06/2017.
//  Copyright © 2017 Focus. All rights reserved.
//

import UIKit

class DLChannelCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        itemSize = (self.collectionView?.bounds.size)!;
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = .horizontal;
        collectionView?.bounces = false
        collectionView?.isPagingEnabled = true
    }
}
