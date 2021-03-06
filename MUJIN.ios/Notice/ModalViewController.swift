//
//  ModelViewController.swift
//  MUJIN.ios
//
//  Created by 高橋勇輝 on 2017/12/01.
//  Copyright © 2017年 高橋勇輝. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class ModalViewController: UIViewController {

    @IBOutlet weak var textmessage: UILabel!
    @IBOutlet weak var modalview: UIView!
    @IBOutlet weak var userimage: UIImageView!
    var message: String?
    //申請されたグループのキー
    var Groupkey:String?
    //申請してきたユーザーのキー
    var Applyid:String?

    var ref: DatabaseReference!
    //認証予定のidを取得
    var vertifyid: DatabaseReference!
    
    //ユーザーの写真のURLを受け取り
    var userprofile:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        let profile = URL(string:userprofile as! String)
        self.userimage.sd_setImage(with: profile)
        
        textmessage.text = message
        textmessage.font = UIFont(name: "Arial", size: 14)
        textmessage.font = UIFont.boldSystemFont(ofSize: 12)
        textmessage.numberOfLines = 2
        textmessage.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        self.modalview.layer.cornerRadius = 10
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
        ref.child("Gruop").child(Groupkey!).child("users").updateChildValues([Applyid!:true])

        vertifyid.updateChildValues(["status":"isDone"])
        dismiss(animated: true, completion: nil)

    }
    
    @IBAction func tappedNG(_ sender: CustomButton) {

    }
    
}
