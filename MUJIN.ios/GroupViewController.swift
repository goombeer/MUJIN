//
//  GrounpViewController.swift
//  MUJIN.ios
//
//  Created by 高橋勇輝 on 2017/11/21.
//  Copyright © 2017年 高橋勇輝. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class GroupViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var ref: DatabaseReference!
    var items = [GroupData]()
    var selectedImage: UIImage?
    var selectedname: String?
    var selectedjoinnum: String?
    var selectedamount: String?
    let ud = UserDefaults.standard
    let UID = UserDefaults.standard.string(forKey: "MyUID")
    var joingroupid: Array<String>  = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButtonItem
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //データベースから取得
        //自分が参加しているグループのID取得
   
        ref = Database.database().reference()

        ref.child("User").child(self.UID!).child("groups").observeSingleEvent(of: .value, with: { (snapshot) in
            let array = snapshot.value as? [String:AnyObject]
            let GroupID = array?.keys
            if GroupID == nil {
                return
            }
            
            for GroupKeys in GroupID! {
                    self.joingroupid.append(GroupKeys)
                }
            //こっちでfor文回したら直った
            for grouoid in self.joingroupid {
                print("sss")
                self.getgroup(GroupKey: grouoid)
            }

            })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "groupcell", for: indexPath as IndexPath)
        let item = items[indexPath.row]
        
        let groupimage = cell.contentView.viewWithTag(1) as? UIImageView
        groupimage?.image = UIImage(named: "sinji.png")
        
        let namelabel = cell.contentView.viewWithTag(2) as? UILabel
        namelabel?.font = UIFont(name: "Arial", size: 14)
        namelabel?.font = UIFont.boldSystemFont(ofSize: 12)
        namelabel?.text = item.name!
        
        
        let joinlabel = cell.contentView.viewWithTag(3) as? UILabel
        joinlabel?.text = String(describing: item.memberofnumber!) + "人"
        
        let amountlabel = cell.contentView.viewWithTag(4) as? UILabel
        amountlabel?.text = String(describing: item.memberofnumber! * item.payment!) + "円"
        
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 6
        cell.layer.borderColor = UIColor(red:1.00, green:0.75, blue:0.51, alpha:1.0).cgColor

        return cell
    }
    
    //セルタップした時のイベント処理
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.row]

        //セルの取得
        let cell:UICollectionViewCell = collectionView.cellForItem(at: indexPath)!
        //選択された画像
        let groupimage = cell.contentView.viewWithTag(1) as? UIImageView
        self.selectedImage = groupimage?.image!
        //選択されたグループ名
        let namelabel = cell.contentView.viewWithTag(2) as? UILabel
        self.selectedname = namelabel?.text!
        //選択された参加人数
        let joinlabel = cell.contentView.viewWithTag(3) as? UILabel
        self.selectedjoinnum = joinlabel?.text!
        //選択された運用金額
        let amountlabel = cell.contentView.viewWithTag(4) as? UILabel
        self.selectedamount = amountlabel?.text!
        
        //groupnameを登録
        print(item.name!)
        ud.set(item.name!, forKey: "tappedgroupname")
        //groupidを登録
        ud.set(item.groupid, forKey: "tappedgroupid")
        //founder登録
        ud.set(item.founder, forKey: "tappedfounder")
        //登録
        ud.synchronize()
        
        performSegue(withIdentifier: "FromGroup", sender: nil)
    }
    
    // Segue 準備
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "FromGroup") {
            guard let nav = segue.destination as? UINavigationController else {
                return
            }
            guard let GDVC = nav.topViewController as? GroupDetailViewController else {
                return
            }
            
            // SubViewController のselectedImgに選択された画像を設定する
            GDVC.groupimage = selectedImage!
            GDVC.namelabel = selectedname!
            GDVC.joinnumber = selectedjoinnum!
            GDVC.amountlabel = selectedamount!
        }
    }
    
    @IBAction func goBacktoGrouo(_ segue:UIStoryboardSegue) {
        let ud = UserDefaults.standard
        ud.removeObject(forKey: "tappedgroupname")
        ud.removeObject(forKey: "tappedgroupid")
        ud.removeObject(forKey: "tappedfounder")

        
    }
    
    func getgroup(GroupKey:String){
        self.ref.child("Gruop").child(GroupKey).observe(.value, with: { (snapshot) in
                    let item = GroupData(snapshot: snapshot )
                    self.items.append(item!)
                    self.collectionView.reloadData()

            })

    }
    

}


