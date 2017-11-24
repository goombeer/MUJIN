//
//  HomeData.swift
//  MUJIN.ios
//
//  Created by 高橋勇輝 on 2017/11/20.
//  Copyright © 2017年 高橋勇輝. All rights reserved.
//

import Foundation
import FirebaseDatabase

class GroupData {
    
    var ref: DatabaseReference?
    var name: String?
    var founder: String?
    var memberofnumber: Int?
    var payment: Int?
    var period: String?
    var message: String?
    var publicnum: Int
    
   
    init? (snapshot: DataSnapshot) {
        ref = snapshot.ref
        guard let dict = snapshot.value as? [String:Any] else { return nil }
        guard let name  = dict["name"] as? String  else { return nil }
        guard let founder = dict["founder"]  as? String else { return nil }
        guard let memberofnumber = dict["memberofnumber"]  as? Int else { return nil }
        guard let payment = dict["payment"]  as? Int else { return nil }
        guard let period = dict["period"]  as? String else { return nil }
        guard let message = dict["message"] as? String else { return nil }
        guard let publicnum = dict["publicnum"] as? Int else { return nil }

        
        self.name = name
        self.founder = founder
        self.memberofnumber = memberofnumber
        self.payment = payment
        self.period = period
        self.message = message
        self.publicnum = publicnum
    }
    
}
