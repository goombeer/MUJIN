//
//  LoginViewController.swift
//  MUJIN.ios
//
//  Created by 高橋勇輝 on 2017/11/18.
//  Copyright © 2017年 高橋勇輝. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    var user: User!
    var ref: DatabaseReference!
    let ud = UserDefaults.standard
    //[groupkey,UID]の形で保持する
    var array:[String] = []
    
    @IBOutlet weak var emailFiled: UITextField!
    @IBOutlet weak var passfield: UITextField!
    
    //インジゲーター実装
    var ActivityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ActivityIndicatorを作成＆中央に配置
        ActivityIndicator = UIActivityIndicatorView()
        ActivityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        ActivityIndicator.center = self.view.center
        
        // クルクルをストップした時に非表示する
        ActivityIndicator.hidesWhenStopped = true
        
        // 色を設定
        ActivityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        
        //Viewに追加
        self.view.addSubview(ActivityIndicator)
        
        if let nv = navigationController {
            let hidden = !nv.isNavigationBarHidden
            nv.setNavigationBarHidden(hidden, animated: true)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
    @IBAction func logintap(_ sender: UIButton) {
        ActivityIndicator.startAnimating()
        print("tap")
        let email = emailFiled.text
        let password = passfield.text
        Auth.auth().signIn(withEmail: email!, password: password!, completion: { (user, error) in
            guard let _ = user else {
                if let error = error {
                    if let errCode = AuthErrorCode(rawValue: error._code) {
                        switch errCode {
                            case .userNotFound:
                              self.showAlert("会員情報がありません。会員登録をしてください")
                            case.wrongPassword:
                              self.showAlert("入力情報に誤りがあります")
                            default:
                              self.showAlert("Error: \(error.localizedDescription)")
                        }
                    }
                    return
            }
                assertionFailure("必要項目を入力してください")
                return
            }
            self.signIn()

        }) 
        
    }
    
    
    func showAlert(_ message: String) {
        let alertController = UIAlertController(title: "MUJIN", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "確認", style: UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func signIn() {
        
        user = Auth.auth().currentUser
        ref = Database.database().reference()

        self.ref.child("User").child(user.uid).observe(.value, with: { (snapshot) in
            let username = snapshot.value as? [String:Any]
            self.ud.set(username!["profile"], forKey: "Myprofile")
            self.ud.set(username!["username"], forKey: "Username")
            print(username!["profile"])
            self.ud.set(URL(string:username!["profile"] as! String), forKey: "Myimage")
        
        })
        
        //自分宛の通知を取得
        print("通知取得開始")
       self.ref.child("User").child(user.uid).child("notifications").observeSingleEvent(of:.value, with: { (snapshot) in
            var newarray:[String] = []
            for child in snapshot.children {
                let item = NoticeficationData(snapshot: child as! DataSnapshot)
                newarray.append((item?.groupid)!)
                self.array = newarray
                print(self.array)
                self.ud.set(self.array, forKey: "notification")
                print("通知取得終了")
            }
            self.ud.set(self.user.uid, forKey: "MyUID")
            self.ud.synchronize()
        
            self.ActivityIndicator.stopAnimating()
        
            self.performSegue(withIdentifier: "signIn", sender: nil)
            self.emailFiled.text = ""
            self.passfield.text  = ""
        })
       
    }
}
