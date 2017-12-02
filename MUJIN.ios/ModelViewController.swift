//
//  ModelViewController.swift
//  MUJIN.ios
//
//  Created by 高橋勇輝 on 2017/12/01.
//  Copyright © 2017年 高橋勇輝. All rights reserved.
//

import UIKit
import Firebase

class ModalViewController: UIViewController {

    @IBOutlet weak var textmessage: UILabel!
    var message: String?
    //申請されたグループのキー
    var Groupkey:String?
    //申請してきたユーザーのキー
    var Applyid:String?

    var ref: DatabaseReference!
    //認証予定のidを取得
    var vertifyid: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

        
        textmessage.text = message
        textmessage.font = UIFont(name: "Arial", size: 14)
        textmessage.font = UIFont.boldSystemFont(ofSize: 12)
        textmessage.numberOfLines = 2
        textmessage.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        ref.child("Notifications").child(Groupkey!).queryOrdered(byChild: "status").queryEqual(toValue: "unDone").observe(DataEventType.value, with: { (snapshot)  in
            for child in snapshot.children {
                let deta = GetNotificationStatus(snapshot: child as! DataSnapshot)
                if deta?.Applyid == self.Applyid && deta?.Groupkey == self.Groupkey {
                    self.vertifyid = deta?.ref
                }
            }
            }
        )
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        for touch: UITouch in touches {
            let tag = touch.view!.tag
            if tag == 1 {
                dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
    @IBAction func didTapClose(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
 
    @IBAction func tappedOK(_ sender: CustomButton) {
        ref = Database.database().reference()
    ref.child("User").child(Applyid!).child("groups").updateChildValues([Groupkey!:true])
        vertifyid.updateChildValues(["status":"isDone"])
        dismiss(animated: true, completion: nil)

    }
    
    @IBAction func tappedNG(_ sender: CustomButton) {

    }
    
}
