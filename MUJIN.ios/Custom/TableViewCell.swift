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
    var timelabel :UILabel = UILabel()
    var userprofile:UIImageView = UIImageView(frame:  CGRect(x: 0, y: 0, width: 40, height: 40))
    var right_:Bool = true
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.autoresizingMask = autoresizingMask;
        
        //文字の大きさ、色など諸々設定
        self.name.font = UIFont.boldSystemFont(ofSize: 16)
        
        self.comment.font = UIFont.systemFont(ofSize: 14)

        self.timelabel.font = UIFont.systemFont(ofSize: 10)
        self.timelabel.textColor = UIColor.darkGray
        
        self.contentView.addSubview(name)
        self.contentView.addSubview(timelabel)
        self.contentView.addSubview(userprofile)
        self.contentView.addSubview(comment)
        
        contentView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(20)
            make.left.equalTo(10)
            make.right.equalTo(10)
            make.bottom.equalTo(20)
            make.height.equalTo(80)
            make.width.equalTo(350)

        }
        
        name.snp_makeConstraints { (make) -> Void in            make.top.equalTo(self.contentView.snp_top).offset(-10)
            make.left.equalTo(self.contentView.snp_left).offset(50)
            make.right.equalTo(self.contentView.snp_right).offset(-50)
        }

        comment.snp_makeConstraints { (make) -> Void in

            make.top.equalTo(name.snp_bottom).offset(5)
            make.left.equalTo(self.contentView.snp_left).offset(50)
            make.right.equalTo(self.contentView.snp_right).offset(-10)
        }

        timelabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.contentView.snp_top).offset(-5)
            make.left.equalTo(self.contentView.snp_left).offset(140)
        }

        userprofile.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.top.equalTo(name)
            make.left.equalTo(name.snp_left).offset(-50)

        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}

