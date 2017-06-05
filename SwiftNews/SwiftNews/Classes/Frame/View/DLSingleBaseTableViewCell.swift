//
//  DLSingleBaseTableViewCell.swift
//  SwiftNews
//
//  Created by NowOrNever on 03/06/2017.
//  Copyright © 2017 Focus. All rights reserved.
//

import UIKit

class DLSingleBaseTableViewCell: UITableViewCell {
    var model:DLSingleNewModel?{
        didSet{
            self.modelChangeAction()
        }
    }
    
    @objc func modelChangeAction(){
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
