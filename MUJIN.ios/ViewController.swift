//
//  ViewController.swift
//  MUJIN.ios
//
//  Created by 高橋勇輝 on 2017/11/03.
//  Copyright © 2017年 高橋勇輝. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class WelcomeViewController: UIViewController,FBSDKLoginButtonDelegate {

    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
     
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if (FBSDKAccessToken.current() != nil) {
            print("User Already Logged In")
            //facebookでのログインが済んでいるならホーム画面に遷移
            performSegue(withIdentifier: "showMain", sender: nil)
        }
        
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("ログイン処理を実行")
        
        if (error != nil) {
            // エラーが発生した場合
            print("Process Error !")

        } else if result.isCancelled {
            // ログインをキャンセルした場合
            print("User Cancelled")

        } else {
            // その他
            print("Login Succeeded")
            //ここで分岐（会員登録しているならホーム、していないなら登録画面）
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("ログアウト処理を実行")
        
    }
   
    @IBAction func login(_ sender: UIButton) {
        
        let loginManager: FBSDKLoginManager = FBSDKLoginManager()
        loginManager.loginBehavior = .browser
        loginManager.logIn(withReadPermissions: ["public_profile", "email", "user_friends"], from: self) { (result, error) in
            if (error != nil) {
                // エラーが発生した場合
                print("Process error")
            } else if (result?.isCancelled)! {
                // ログインをキャンセルした場合
                print("Cancelled")
            } else {
                // その他
                
                print("Login Succeeded")
                self.performSegue(withIdentifier: "loginsucsess", sender: self)
                print("tttttttttttttttt")
            }
        }
    }
    

}

