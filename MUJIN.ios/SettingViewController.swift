//
//  SettingViewController.swift
//  MUJIN.ios
//
//  Created by 高橋勇輝 on 2017/11/18.
//  Copyright © 2017年 高橋勇輝. All rights reserved.
//

import UIKit
import Firebase


class SettingViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var user: User!
    var ref: DatabaseReference!

    let imageset:[UIImage] = [
        (UIImage(named:"facebook.png")?.resize(size: CGSize(width:50, height:50))!.withRenderingMode(.alwaysTemplate))!,
        (UIImage(named:"cash.png")?.resize(size: CGSize(width:50, height:50))!.withRenderingMode(.alwaysTemplate))!,
        (UIImage(named:"card.png")?.resize(size: CGSize(width:50, height:50))!.withRenderingMode(.alwaysTemplate))!,
        (UIImage(named:"logout.png")?.resize(size: CGSize(width:50, height:50))!.withRenderingMode(.alwaysTemplate))!,
        ]
    
    let textset:[String] = ["facebook連携","振込申請","クレジットカード登録","ログアウト"]

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var username: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("User").child(userID!).child("name").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let Username = value?["username"] as? String ?? ""
            self.username.text = Username

        }) { (error) in
            print(error.localizedDescription)
        }
        
        
        tableView.isScrollEnabled = false
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.imageset.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        let cellImage = imageset[indexPath.row]
        let cellText = textset[indexPath.row]
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = cellText
        cell.imageView?.image = cellImage
        
        if cellText == "facebook連携" {
            cell.imageView?.tintColor = UIColor(red:0.23, green:0.35, blue:0.60, alpha:1.0)
        } else if cellText == "振込申請" {
            cell.imageView?.tintColor = UIColor(red:1.00, green:0.75, blue:0.51, alpha:1.0)
        } else if cellText == "クレジットカード登録" {
            cell.imageView?.tintColor = UIColor(red:1.00, green:0.75, blue:0.51, alpha:1.0)
        } else {
           cell.imageView?.tintColor = UIColor(red:1.00, green:0.75, blue:0.51, alpha:1.0)
        }

        
        return cell
    }
    
    //データ選択後に呼び出されるメソッド
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if indexPath.row == 0 {
            print("first")
        } else if indexPath.row == 1 {
            print("second")
        } else if indexPath.row == 2 {
            print("third")
        } else{
            print("forth")
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                removeUserDefaults()
                
                performSegue(withIdentifier: "Singout", sender: nil)
                print("sinnout")
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
        }
    }
    
    func removeUserDefaults() {
        let appDomain = Bundle.main.bundleIdentifier
        UserDefaults.standard.removePersistentDomain(forName: appDomain!)
    }
}


