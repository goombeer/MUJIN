//
//  TableViewCell.swift
//  MUJIN.ios
//
//  Created by 高橋勇輝 on 2017/11/25.
//  Copyright © 2017年 高橋勇輝. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    var comment:UILabel = UILabel()
    var name :UILabel = UILabel()
    var right_:Bool = true
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.autoresizingMask = autoresizingMask;
        
        self.contentView.addSubview(name)
        self.contentView.addSubview(comment)
        
        name.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.contentView.snp_top).offset(20)
            make.left.equalTo(self.contentView.snp_left).offset(20)
            make.right.equalTo(self.contentView.snp_right).offset(-20)
        }
        
        comment.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(name.snp_bottom).offset(10)
            make.left.equalTo(self.contentView.snp_left).offset(20)
            make.bottom.equalTo(self.contentView.snp_bottom).offset(-10)
            make.right.equalTo(self.contentView.snp_right).offset(-10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}

