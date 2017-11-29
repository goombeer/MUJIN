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
    let tappedgroupid = UserDefaults.standard.string(forKey: "tappedgroupid")
    let UID = UserDefaults.standard.string(forKey: "UID") 
    var joingroupid: Array = [String]()
    
    @IBOutlet weak var navigatiobar: UINavigationBar!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var join: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var period: UILabel!
    @IBOutlet weak var tapLabel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //タップしたグループIDと参加しているIDが一致するか確認
        ref.child("User").child(self.UID!).child("groups").observeSingleEvent(of: .value, with: {(snapshot) in
            
            //ここで参加しているグループidを取得して、配列にぶっこんでいる
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let key = snap.key
                self.joingroupid.append(key)
            }
            
            //ここで検索かける
            if self.joingroupid.index(of: self.tappedgroupid!) == nil{
                self.tapLabel.setTitle("申請する", for: .normal)
            } else {
                self.tapLabel.setTitle("チャットへ", for: .normal)

            }

        
        })
        
        
        
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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tappedchat(_ sender: UIButton) {
        
        performSegue(withIdentifier: "Gotochat", sender: namelabel)

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
        let ud = UserDefaults.standard
        ud.removeObject(forKey: "tappedgroupid")
        self.dismiss(animated: true)
    }
   

    

}
