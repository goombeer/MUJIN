//
//  RegisterViewController.swift
//  MUJIN.ios
//
//  Created by 高橋勇輝 on 2017/11/25.
//  Copyright © 2017年 高橋勇輝. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var UsernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var ref: DatabaseReference!
    var user: User!
    let ud = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //改行ボタンが押された際に呼ばれる.
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    @IBAction func register(_ sender: UIButton) {
        let email = emailField.text
        let password = passwordField.text
        let username = UsernameField.text
        
        print("サインイン開始")
        Auth.auth().createUser(withEmail: email!, password: password!, completion: { (user, error) in
            if let error = error {
                if let errCode = AuthErrorCode(rawValue: error._code) {
                    switch errCode {
                    case .invalidEmail:
                        self.showAlert("Enter a valid email.")
                    case .emailAlreadyInUse:
                        self.showAlert("Email already in use.")
                    default:
                        self.showAlert("Error: \(error.localizedDescription)")
                    }
                }
                return
            }
            self.signIn(email:email!,psssword:password!,username: username!)
            print("終了")

        })
        
    }
    
    func signIn(email:String,psssword:String,username:String) {
        Auth.auth().signIn(withEmail: email, password: psssword, completion: { (user, error) in
          
        })
        self.ref = Database.database().reference()
        user = Auth.auth().currentUser
        self.ref.child("User").child(user.uid).setValue(["username":username])
        
        ud.set(username, forKey: "Username")
        ud.set(user.uid, forKey: "MyUID")
        ud.synchronize()
        
    

        performSegue(withIdentifier: "Fromregister", sender: nil)


    }
    
    func showAlert(_ message: String) {
        let alertController = UIAlertController(title: "MUJIN", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "確認", style: UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}
