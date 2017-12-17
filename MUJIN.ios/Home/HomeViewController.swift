//
//  TestViewController.swift
//  MUJIN.ios
//
//  Created by 高橋勇輝 on 2017/12/08.
//  Copyright © 2017年 高橋勇輝. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SDWebImage






class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    
    var ref: DatabaseReference!
    var user: User! = Auth.auth().currentUser

    var items = [GroupData]()
    let UID = UserDefaults.standard.string(forKey: "MyUID")
    let Username = UserDefaults.standard.string(forKey: "Username")
    let Myprofile = UserDefaults.standard.string(forKey: "Myprofile")

    var selectedImage: UIImage?
    var selectedname: String?
    var selectedjoinnum: String?
    var selectedamount: String?
    private var databaseHandle: DatabaseHandle!
    

    @IBOutlet weak var tableView: UITableView!
    
    
    //pull to refreshのために必要なもの
    var refreshControl:UIRefreshControl!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        
        getgroupdeta()

        //pull to refreshに必要な実装
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "")
        self.refreshControl.addTarget(self, action: #selector(HomeViewController.getgroupdeta), for: UIControlEvents.valueChanged)
        self.tableView?.addSubview(refreshControl)
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell =  tableView.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
        let item = items[indexPath.row]
        
        let groupname = cell.contentView.viewWithTag(1) as? UILabel
        groupname?.text = item.name!
        
        if (item.users?.count)! < item.memberofnumber!{
            let joinbutton = cell.contentView.viewWithTag(2) as? UIButton
            joinbutton?.setTitle("参加申請", for: .normal)
        } else if (item.users?.count)! >= item.memberofnumber!{
            let joinbutton = cell.contentView.viewWithTag(2) as? UIButton
            joinbutton?.setTitle("グループを見る", for: .normal)
        }
        
        
        let groupimage = cell.contentView.viewWithTag(3) as? UIImageView
        let profile = URL(string:item.groupprofile as! String)
        groupimage?.sd_setImage(with: profile)
        
        let messagelabel = cell.contentView.viewWithTag(4) as? UILabel
        messagelabel?.text = item.message
        
        let groupicon = cell.contentView.viewWithTag(5) as? UIImageView
        
        let joinlabel = cell.contentView.viewWithTag(6) as? UILabel
        joinlabel?.text = String(describing: item.memberofnumber!) + "人"
        
        let amounticon = cell.contentView.viewWithTag(7) as? UIImageView

        let amountlabel = cell.contentView.viewWithTag(8) as? UILabel
        amountlabel?.text = String(describing: item.memberofnumber! * item.payment!) + "円"
        
        let priodicon = cell.contentView.viewWithTag(9) as? UIImageView

        let periodlabel = cell.contentView.viewWithTag(10) as? UILabel
        periodlabel?.text = item.period
        
        let contentview = cell.contentView.viewWithTag(11)
        contentview?.backgroundColor = UIColor.white

        return cell
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    

    

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 10
    }
    
    
    
    @objc func getgroupdeta() {
        ref = Database.database().reference()
        var newItems = [GroupData]()
        databaseHandle = ref.child("Gruop").observe(.value, with: { (snapshot) in
            
            
            for itemSnapShot in snapshot.children {
                var userarray:[String] = []

                let item = GroupData(snapshot: itemSnapShot as! DataSnapshot)
                for i in (item?.users)! {
                    userarray.append(i as! String)
                    
                }
                let s = userarray.index(of:self.user.uid)
                if item?.publicnum == 1 && s == nil {
                    newItems.append(item!)
                }
                
            }
            self.items = newItems
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
            
        })
    }
    
    @IBAction func tapjoin(_ sender: CustomButton) {
        let cell = sender.superview?.superview?.superview as! UITableViewCell
        let taplabel = cell.contentView.viewWithTag(2) as? UIButton
        let groupimage = cell.contentView.viewWithTag(3) as? UIImageView
        
        guard let row = self.tableView.indexPath(for: cell)?.row else {
            return
        }
        let item = items[row]
        
        if taplabel?.currentTitle == "参加申請" {
            print("参加申請")
            //まずはnotificationに情報を登録
            ref.child("Notifications").child(item.groupid!).childByAutoId().setValue(
                ["groupname":item.name!,"from":Username!,"status":"unDone","Groupkey":item.groupid!,"Applyid":UID!,"userprofile":Myprofile]
            )
            //founderに申請があったグループキー(どこのグループか)と申請者のUID(誰から来たのか)を持たせる
            ref.child("User").child(item.founder!).child("notifications").childByAutoId().setValue(["Groupkey":item.groupid!,"UID":UID!])

            taplabel?.setTitle("申請済み", for: .normal)
            taplabel?.isEnabled = false
        } else {
            print("詳細")
            let vc = storyboard!.instantiateViewController(withIdentifier: "detail") as! GroupDetailViewController
            vc.hidesBottomBarWhenPushed = true
            vc.groupimage = (groupimage?.image)!
            vc.namelabel = item.name!
            vc.joinnumber = String(item.memberofnumber!)
            vc.amountlabel = String(item.payment!)
            vc.groupid = item.groupid!
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
       
        
        
    }
    
    

        
    
}
