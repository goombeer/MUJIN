//
//  NoticeficationData.swift
//  MUJIN.ios
//
//  Created by 高橋勇輝 on 2017/11/29.
//  Copyright © 2017年 高橋勇輝. All rights reserved.
//

import Foundation
import FirebaseDatabase

class NoticeficationData {
    
    var ref: DatabaseReference?
    var groupid: String?
    var from: String?
    var founder: String?
   
    
    
    init? (snapshot: DataSnapshot) {
        ref = snapshot.ref
        guard let dict = snapshot.value as? [String:Any] else { return nil }
        guard let groupid  = dict["Groupkey"] as? String else { return nil }
        guard let from  = dict["UID"] as? String  else { return nil }

        
        self.groupid = groupid
        self.from = from
    
        
        
    }
    
}
