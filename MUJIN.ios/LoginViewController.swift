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

    @IBOutlet weak var emailFiled: UITextField!
    @IBOutlet weak var passfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
    @IBAction func logintap(_ sender: UIButton) {
        let email = emailFiled.text
        let password = passfield.text
        print("sinin start")
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
        performSegue(withIdentifier: "signIn", sender: nil)
    }
}
