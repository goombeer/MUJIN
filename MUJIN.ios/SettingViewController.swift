//
//  SettingViewController.swift
//  MUJIN.ios
//
//  Created by 高橋勇輝 on 2017/11/18.
//  Copyright © 2017年 高橋勇輝. All rights reserved.
//

import UIKit
import Firebase


class SettingViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var user: User!
    var ref: DatabaseReference!
    let storage = Storage.storage()

    
    @IBOutlet weak var userimage: UIImageView!
    
    
    let imageset:[UIImage] = [
        (UIImage(named:"facebook.png")?.resize(size: CGSize(width:40, height:30))!.withRenderingMode(.alwaysTemplate))!,
        (UIImage(named:"cash.png")?.resize(size: CGSize(width:30, height:30))!.withRenderingMode(.alwaysTemplate))!,
        (UIImage(named:"card.png")?.resize(size: CGSize(width:30, height:30))!.withRenderingMode(.alwaysTemplate))!,
        (UIImage(named:"logout.png")?.resize(size: CGSize(width:30, height:30))!.withRenderingMode(.alwaysTemplate))!,
        ]
    
    let textset:[String] = ["facebook連携","振込申請","クレジットカード登録","ログアウト"]

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var username: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("User").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let Username = value?["username"] as? String ?? ""
            self.username.text = Username

        }) { (error) in
            print(error.localizedDescription)
        }
        
        
        tableView.isScrollEnabled = false
        tableView.delegate = self
        tableView.dataSource = self
        
        //userimageにタップ処理を加える
        userimage.isUserInteractionEnabled = true
        let myTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("userimagetapped"))
        userimage.addGestureRecognizer(myTap)
        
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
                
                //画面の解放することで初期画面に遷移させている
                UIApplication.shared.keyWindow?.rootViewController?
                    .dismiss(animated: true, completion: nil)
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
    
    @objc func userimagetapped() {
        //アラート表示のために
        let actionSheet = UIAlertController(title: "", message: "プロフィール写真を設定します", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let tappedcamera = UIAlertAction(title: "カメラで撮影する", style: UIAlertActionStyle.default, handler: {
            (action: UIAlertAction!) in
            self.tappedcamera()
        })
        
        let tappedlibrary = UIAlertAction(title: "ライブラリから選択する", style: UIAlertActionStyle.default, handler: {
            (action: UIAlertAction!) in
            self.tappedlibrary()
        })
        
        let cancel = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.cancel, handler: {
            (action: UIAlertAction!) in
            print("キャンセル")
        })
        
        actionSheet.addAction(tappedcamera)
        actionSheet.addAction(tappedlibrary)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true, completion: nil)
        
        
    }

    
    //　撮影が完了時した時に呼ばれる
    func imagePickerController(_ imagePicker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage]
            as? UIImage {
            
            userimage.contentMode = .scaleAspectFit
            let imgRef = pickedImage.cgImage?.cropping(to: CGRect(x: view.bounds.size.width/2, y: view.bounds.size.height/2, width: 10.0, height: 10.0))
            let image = UIImage(cgImage: imgRef!, scale: pickedImage.scale, orientation: pickedImage.imageOrientation)
            userimage.image = image
            self.userimage.layer.cornerRadius = 75
        }
        
        //閉じる処理
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    // 撮影がキャンセルされた時に呼ばれる
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func tappedcamera() {
        let sourceType:UIImagePickerControllerSourceType =
            UIImagePickerControllerSourceType.camera
        // カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerControllerSourceType.camera){
            // インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            cameraPicker.allowsEditing = true
            self.present(cameraPicker, animated: true, completion: nil)
            
        }
        else{
            print("error")
        }
    }
    
    func tappedlibrary() {
        let sourceType:UIImagePickerControllerSourceType =
            UIImagePickerControllerSourceType.photoLibrary
        
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerControllerSourceType.photoLibrary){
            // インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            cameraPicker.allowsEditing = true
            self.present(cameraPicker, animated: true, completion: nil)
            
        }
        else{
            print("error")
            
        }
    }
    
}
