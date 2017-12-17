//
//  GetGroupnameAndApply.swift
//  MUJIN.ios
//
//  Created by 高橋勇輝 on 2017/12/01.
//  Copyright © 2017年 高橋勇輝. All rights reserved.
//

import Foundation
import FirebaseDatabase

class GetGroupnameAndApply {
    
    var ref: DatabaseReference?
    var groupname: String?
    var status: String?
    var from: String?
    var Groupkey: String?
    var Applyid: String?
    var userprofile: String?

    
    init? (snapshot: DataSnapshot) {
        ref = snapshot.ref
        guard let dict = snapshot.value as? [String:Any] else { return nil }
        guard let groupname  = dict["groupname"] as? String else { return nil }
        guard let from  = dict["from"] as? String  else { return nil }
        guard let status = dict["status"] as? String  else { return nil }
        guard let Groupkey  = dict["Groupkey"] as? String  else { return nil }
        guard let Applyid = dict["Applyid"] as? String  else { return nil }
        guard let userprofile = dict["userprofile"] as? String else { return nil }

        self.groupname = groupname
        self.status = status
        self.from = from
        self.Groupkey = Groupkey
        self.Applyid = Applyid
        self.userprofile = userprofile
        
    }
    
}
