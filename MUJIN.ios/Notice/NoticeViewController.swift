//
//  NoticeViewController.swift
//  MUJIN.ios
//
//  Created by 高橋勇輝 on 2017/11/19.
//  Copyright © 2017年 高橋勇輝. All rights reserved.
//

import UIKit
import Firebase

class NoticeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var ref = Database.database().reference()
    let ud = UserDefaults.standard
    let user = UserDefaults.standard.string(forKey: "MyUID")
    let notifications = UserDefaults.standard.object(forKey: "notification") as? Array<Any>

    var dataset = [GetGroupnameAndApply]()

    private var databaseHandle: DatabaseHandle!

    var selectedText: String?
    var selectedApplyid: String?
    var selectedGroupkey: String?
    var selectedUserimage: String?
    //pull to refreshのために必要なもの
    var refreshControl:UIRefreshControl!
    
    //インジゲーター実装
    var ActivityIndicator: UIActivityIndicatorView!

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        tableView.delegate = self
        tableView.dataSource = self
        
        if notifications == nil {
            return

        } else {

            ActivityIndicator = UIActivityIndicatorView()
            ActivityIndicator.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            ActivityIndicator.center = self.view.center
            
            // クルクルをストップした時に非表示する
            ActivityIndicator.hidesWhenStopped = true
            
            // 色を設定
            ActivityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            
            //Viewに追加
            self.tableView.addSubview(ActivityIndicator)
            
            startgetnotification()
        }
        
        
        //pull to refreshに必要な実装
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "")
        self.refreshControl.addTarget(self, action: #selector(NoticeViewController.startgetnotification), for: UIControlEvents.valueChanged)
        self.tableView.addSubview(refreshControl)
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataset.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellImage = UIImage(named:"cash.png")?.resize(size: CGSize(width:25, height:25))!.withRenderingMode(.alwaysTemplate)
        let cellText = dataset[indexPath.row].from! + "が" + dataset[indexPath.row].groupname! + "で参加申請を行いました"
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "CELL")
        cell.textLabel?.text = cellText
        cell.textLabel?.font = UIFont(name: "Arial", size: 14)
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 12)

        cell.textLabel?.numberOfLines = 2
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        cell.imageView?.tintColor = UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0)
        cell.imageView?.image = cellImage
        
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator

        return cell
    }
    
    func tableView(_ table: UITableView,didSelectRowAt indexPath: IndexPath) {
        //タップしたセルのテキストを取得してる
        selectedText = tableView.cellForRow(at: indexPath)?.textLabel?.text
        //タップしたセルのApllyidを取得してる
        selectedApplyid = dataset[indexPath.row].Applyid
        //タップしたセルのGroupkeyを取得してる
        selectedGroupkey = dataset[indexPath.row].Groupkey
        //タップしたセルのuserprofileを取得してる
        selectedUserimage = dataset[indexPath.row].userprofile
        //タップした直後にセルのハイライトを消している
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "Modal", sender: nil)
    }
    
    // Segue 準備
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "Modal") {
            guard let ModalVC = segue.destination as? ModalViewController else {
                return
            }
            //順番を前に置いたら表示された！！
          
            ModalVC.message = self.selectedText!
            ModalVC.Groupkey = self.selectedGroupkey!
            ModalVC.Applyid = self.selectedApplyid!
            ModalVC.userprofile = self.selectedUserimage!

            ModalVC.modalPresentationStyle = .overCurrentContext
            ModalVC.view.backgroundColor = UIColor(red:0.37, green:0.37, blue:0.37, alpha:0.5)
        }
    }
    
    @objc func startgetnotification() {
        if notifications == nil {
            return
        } else{
            print("なぜこっち")
//            self.refreshControl.endRefreshing()
            ActivityIndicator.startAnimating()
            //重複分を避けるための前処理
            let orderdset: NSOrderedSet = NSOrderedSet(array: notifications!)
            let newnotifications = orderdset.array as! [String]
            

            var items = [GetGroupnameAndApply]()
            
            for i in newnotifications {

                //statusが「unDone」のみを取得
                self.ref.child("Notifications").child(i).queryOrdered(byChild:"status").queryEqual(toValue: "unDone").observeSingleEvent(of:.value, with: { (snapshot) in
                    for child in snapshot.children {
                        let item = GetGroupnameAndApply(snapshot: child as! DataSnapshot)
                       

                        //オプショナルバインディングするぞ
                        if let data = item {
                            items.append(data)
                        } else {
                            self.refreshControl.endRefreshing()
                            return
                        }
                    }
                    self.dataset = items
                    self.tableView.reloadData()
                    self.ActivityIndicator.stopAnimating()
                    self.refreshControl.endRefreshing()
                })
            }
            
        }

    }
}
