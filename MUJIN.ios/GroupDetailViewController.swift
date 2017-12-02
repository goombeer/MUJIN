//
//  GroupDetailViewController.swift
//  MUJIN.ios
//
//  Created by 高橋勇輝 on 2017/11/23.
//  Copyright © 2017年 高橋勇輝. All rights reserved.
//

import UIKit
import Firebase

class GroupDetailViewController: UIViewController {
    var ref = Database.database().reference()
    
    var groupimage: UIImage = UIImage()
    var namelabel: String = ""
    var joinnumber: String = ""
    var amountlabel: String = ""
    let ud = UserDefaults.standard
    let tappedfounder = UserDefaults.standard.string(forKey: "tappedfounder")
    let tappedgroupid = UserDefaults.standard.string(forKey: "tappedgroupid")
    let tappedgroupname = UserDefaults.standard.string(forKey: "tappedgroupname")
    let Username = UserDefaults.standard.string(forKey: "Username")
    let UID = UserDefaults.standard.string(forKey: "MyUID")

    var joingroupid: Array = [String]()
    
    @IBOutlet weak var navigatiobar: UINavigationBar!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var join: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var period: UILabel!
    @IBOutlet weak var tapLabel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = namelabel
        image.image = groupimage
        join.text = joinnumber
        amount.text = amountlabel
        if joinnumber == "4人" {
            period.text = "4ヶ月"
        } else if joinnumber == "5人" {
            period.text = "5ヶ月"
        } else if joinnumber == "6人" {
            period.text = "6ヶ月"
        } else if joinnumber == "7人" {
            period.text = "7ヶ月"
        }
        
        
        //タップしたグループIDと参加しているIDが一致するか確認
        ref.child("User").child(self.UID!).child("groups").observeSingleEvent(of: .value, with: {(snapshot) in
            
            //ここで参加しているグループidを取得して、配列にぶっこんでいる
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let key = snap.key
                self.joingroupid.append(key)
            }
            
            //ここで検索かける
            //UIBUtton生成した方がラグがないかも・・？
            if self.joingroupid.index(of: self.tappedgroupid!) == nil{
                self.tapLabel.setTitle("申請する", for: .normal)
            } else {
                self.tapLabel.setTitle("チャットへ", for: .normal)

            }

        
        })
        
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tappedchat(_ sender: UIButton) {
        if tapLabel.currentTitle == "申請する" {
            print("申請開始")
            //まずはnotificationに情報を登録
            ref.child("Notifications").child(tappedgroupid!).childByAutoId().setValue(["groupname":tappedgroupname!,"from":Username!,"status":"unDone","Groupkey":tappedgroupid!,"Applyid":UID!])
            //founderに申請があったグループキー(どこのグループか)と申請者のUID(誰から来たのか)を持たせる
            ref.child("User").child(tappedfounder!).child("notifications").childByAutoId().setValue(["Groupkey":tappedgroupid!,"UID":UID!])

            tapLabel.setTitle("申請済み", for: .normal)
            tapLabel.isEnabled = false
        } else {
            performSegue(withIdentifier: "Gotochat", sender: namelabel)
        }

    }
    
    // Segue 準備
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "Gotochat") {
            guard let ChatVC = segue.destination as? ChatViewController else {
                return
            }
          
            // SubViewController のselectedImgに選択された画像を設定する
            ChatVC.groupname = namelabel
          
        }
    }
    
    
    @IBAction func Gobacktapped(_ sender: UIBarButtonItem) {
        ud.removeObject(forKey: "tappedgroupid")
        ud.removeObject(forKey: "tappedfounder")
        self.dismiss(animated: true)
    }
   

    

}
