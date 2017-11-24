//
//  SecondViewController.swift
//  MUJIN.ios
//
//  Created by 高橋勇輝 on 2017/11/03.
//  Copyright © 2017年 高橋勇輝. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit
import SDWebImage

class SecondViewController: UIViewController {

    @IBOutlet weak var userfield: UITextField!
    @IBOutlet weak var emailfield: UITextField!
    @IBOutlet weak var passwordfield: UITextField!
    @IBOutlet weak var userImage: UIImageView!
    
    //facebookから取得した情報を格納する変数
    var userProfile : NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        returnUserData()
        print("return User Data")

    }
    
    //改行ボタンが押された際に呼ばれる.
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func returnUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me",
                                                                 parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"])
        graphRequest.start(completionHandler: { (connection, result, error) -> Void in
            if ((error) != nil)
            {
            // エラー処理
                print("Error: \(error)")
            }
            else
            {
                // プロフィール情報をディクショナリに入れる
                self.userProfile = result as! NSDictionary
                print(self.userProfile)
                
                // プロフィール画像の取得（よくあるように角を丸くする）
                let profileImageURL : String = ((self.userProfile.object(forKey: "picture") as AnyObject).object(forKey: "data") as AnyObject).object(forKey: "url") as! String
                print(profileImageURL)
                
                let imageURL = URL(string: profileImageURL)
                
                self.userImage.clipsToBounds = true
                self.userImage.layer.cornerRadius = 60
                self.userImage.sd_setImage(with: imageURL)
                //名前とemail
                
                self.userfield.text = self.userProfile.object(forKey: "name") as? String
                self.emailfield.text = self.userProfile.object(forKey: "email") as? String
                
            }
        })
        
    }
    
//    func trimPicture(rawPic:UIImage) -> UIImage {
//        var rawImageW = rawPic.size.width
//        var rawImageH = rawPic.size.height
//
//        var posX = (rawImageW - 200) / 2
//        var posY = (rawImageH - 200) / 2
//        var trimArea : CGRect = CGRectMake(posX, posY, 200, 200)
//
//        var rawImageRef:CGImage = rawPic.cgImage!
//        var trimmedImageRef = CGImageCreateWithImageInRect(rawImageRef, trimArea)
//        var trimmedImage : UIImage = UIImage(CGImage : trimmedImageRef!)!
//        return trimmedImage
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func register(_ sender: UIButton) {
        let email = emailfield.text
        let password = passwordfield.text

        Auth.auth().createUser(withEmail: email!, password: password!) { (user, error) in
            if let error = error {
                print("Creating the user failed! \(error)")
                return
            }

            if let user = user {
                print("user : \(user.email) has been created successfully.")
            }
            }

    }
    
}
