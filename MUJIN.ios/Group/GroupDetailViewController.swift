//
//  GroupDetailViewController.swift
//  MUJIN.ios
//
//  Created by 高橋勇輝 on 2017/11/23.
//  Copyright © 2017年 高橋勇輝. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class GroupDetailViewController: UIViewController {
    var ref = Database.database().reference()

    //ホーム画面から遷移された場合に使用
    var groupimage: UIImage = UIImage()
    var namelabel: String = ""
    var joinnumber: String = ""
    var amountlabel: String = ""
    var groupid : String = ""
    
    @IBOutlet weak var grouoimageView: UIImageView!
    @IBOutlet weak var founderimageView: UIImageView!
    @IBOutlet weak var joinnumlabel: UILabel!
    @IBOutlet weak var periodlabel: UILabel!
    @IBOutlet weak var amountnumlabel: UILabel!
    
    //自分の参加グループから遷移した場合
    //↓こいつでリーダーの画像を取得
    var tappedfounder = UserDefaults.standard.string(forKey: "tappedfounder")
    //↓こいつで基本情報を取得
    var tappedgroupid = UserDefaults.standard.string(forKey: "tappedgroupid")
    var tappedgroupname = UserDefaults.standard.string(forKey: "tappedgroupname")
    
    var founderid: String = ""
    var memberid: Array = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if tappedgroupname == nil {
            //グループ名など諸々を設定
            self.navigationItem.title = namelabel
            grouoimageView.image = groupimage
            joinnumlabel.text = joinnumber + "人"
            periodlabel.text = joinnumber + "ヶ月"
            amountnumlabel.text = amountlabel + "円"
            
            //戻るボタンを設定
            let leftButton = UIBarButtonItem(title: "戻る", style: UIBarButtonItemStyle.plain, target: self, action: #selector(GroupDetailViewController.gotoback))
                leftButton.tintColor = UIColor.white
                self.navigationItem.leftBarButtonItem = leftButton
            
                ref.child("Gruop").child(groupid).observe(.value, with: { (snapshot) in
                let item = GroupData(snapshot: snapshot )
                    self.memberid = item?.users as! Array<String>
                    self.founderid = (item?.founder)!
                    self.founderimageget()
                    self.memberimageget()
                })
        } else {
            self.navigationItem.title = tappedgroupname
            
            ref.child("Gruop").child(tappedgroupid!).observe(.value, with: { (snapshot) in
                
                let item = GroupData(snapshot: snapshot )
                let profile = URL(string:item?.groupprofile as! String)
                self.grouoimageView.sd_setImage(with: profile)
                self.joinnumlabel.text = String(describing: item!.memberofnumber!) + "人"
                self.periodlabel.text = String(describing: item!.memberofnumber!) + "ヶ月"
                self.amountnumlabel.text = String(describing: (item?.memberofnumber!)! * (item?.payment!)!) + "円"
                self.founderid = (item?.founder)!
                self.memberid = item?.users as! Array<String>
                self.founderimageget()
                self.memberimageget()


            })
        }

        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func gotoback() {
        if UserDefaults.standard.string(forKey: "tappedgroupname") == nil {
            self.navigationController?.popViewController(animated: true)
        } else {
            let ud = UserDefaults.standard
            ud.removeObject(forKey: "tappedgroupname")
            ud.removeObject(forKey: "tappedgroupid")
            ud.removeObject(forKey: "tappedfounder")
            self.dismiss(animated: true)
        }
    }
    
    func founderimageget() {
        print("取得開始")
        ref.child("User").child(self.founderid).observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot)
            let value = snapshot.value as? NSDictionary
            let profile = URL(string:value?["profile"] as! String)
            self.founderimageView.sd_setImage(with: profile)
            print("成功")
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func memberimageget() {
        var sum:Int = 1
        for i in self.memberid {
          ref.child("User").child(i).observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                let profile = URL(string:value?["profile"] as! String)
                let member = self.view.viewWithTag(sum) as! UIImageView
                member.sd_setImage(with: profile)
                sum += 1
            }) { (error) in
                print(error.localizedDescription)
            }
        }
    }
    
}
