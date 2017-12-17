//
//  Message.swift
//  Bolts
//
//  Created by 高橋勇輝 on 2017/11/25.
//

import Foundation
import FirebaseDatabase

class Message {
    var ref: DatabaseReference?
    var right: Bool = true
    var text: String = ""
    var sendername: String = ""
    var time: Any
    var userprofile: String = ""
    let dateFormatter = DateFormatter()
    
    init? (snapshot: DataSnapshot) {
        ref = snapshot.ref
        
        guard let dict = snapshot.value as? [String:Any] else { return nil }
        guard let text  = dict["text"] as? String  else { return nil }
        guard let sendername  = dict["sender"] as? String  else { return nil }
        guard let time  = dict["time"] as? TimeInterval  else { return nil }
        guard let userprofile  = dict["profile"] as? String  else { return nil }
        
        self.text = text
        self.sendername = sendername
        let date = NSDate(timeIntervalSince1970: time/1000)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy.MM.dd hh:mm"
        self.time = dateFormatter.string(from: date as Date)
        self.userprofile = userprofile
    }
}
