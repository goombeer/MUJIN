//
//  GetNotificationStatus.swift
//  MUJIN.ios
//
//  Created by 高橋勇輝 on 2017/12/02.
//  Copyright © 2017年 高橋勇輝. All rights reserved.
//

import Foundation
import FirebaseDatabase

class GetNotificationStatus {
    
    var ref: DatabaseReference?
    var Applyid: String?
    var status: String?
    var from: String?
    var Groupkey: String?
    
    
    init? (snapshot: DataSnapshot) {
        guard let ref = snapshot.ref as? DatabaseReference else { return nil }
        guard let dict = snapshot.value as? [String:Any] else { return nil }
        guard let from  = dict["from"] as? String  else { return nil }
        guard let status = dict["status"] as? String  else { return nil }
        guard let Groupkey  = dict["Groupkey"] as? String  else { return nil }
        guard let Applyid = dict["Applyid"] as? String  else { return nil }
        
        self.ref = ref
        self.status = status
        self.from = from
        self.Groupkey = Groupkey
        self.Applyid = Applyid
        
        
    }
    
}
