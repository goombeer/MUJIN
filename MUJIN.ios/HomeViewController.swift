//
//  HomeViewController.swift
//  MUJIN.ios
//
//  Created by 高橋勇輝 on 2017/11/07.
//  Copyright © 2017年 高橋勇輝. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class HomeViewController: UIViewController,UICollectionViewDataSource,
UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout{

    var ref: DatabaseReference!
    var items = [GroupData]()
    let ud = UserDefaults.standard
    let UID = UserDefaults.standard.string(forKey: "MyUID") 
    var selectedImage: UIImage?
    var selectedname: String?
    var selectedjoinnum: String?
    var selectedamount: String?
    private var databaseHandle: DatabaseHandle!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //pull to refreshのために必要なもの
    var refreshControl:UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        getgroupdeta()

        //pull to refreshに必要な実装
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "")
        self.refreshControl.addTarget(self, action: #selector(HomeViewController.getgroupdeta), for: UIControlEvents.valueChanged)
        self.collectionView?.addSubview(refreshControl)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return items.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "homecell", for: indexPath as IndexPath)
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
        
        cell.layer.borderWidth = 2
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
        ud.set(item.name!, forKey: "tappedgroupname")
        //groupidを登録
        ud.set(item.groupid, forKey: "tappedgroupid")
        //founder登録
        ud.set(item.founder, forKey: "tappedfounder")
        //登録
        ud.synchronize()
        
        performSegue(withIdentifier: "FromHome", sender: nil)
    }
    
    // Segue 準備
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "FromHome") {
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
    
    @objc func getgroupdeta() {
        ref = Database.database().reference()
        databaseHandle = ref.child("Gruop").observe(.value, with: { (snapshot) in
            
            var newItems = [GroupData]()
            
            for itemSnapShot in snapshot.children {
                let item = GroupData(snapshot: itemSnapShot as! DataSnapshot)
                if item?.publicnum == 1 {
                    newItems.append(item!)
                }
            }
            self.items = newItems
            self.collectionView.reloadData()
            self.refreshControl.endRefreshing()

        })
    }
}
