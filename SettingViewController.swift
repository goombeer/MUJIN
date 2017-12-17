//
//  SettingViewController.swift
//  MUJIN.ios
//
//  Created by 高橋勇輝 on 2017/11/18.
//  Copyright © 2017年 高橋勇輝. All rights reserved.
//

import UIKit
import Firebase
import RSKImageCropper
import SDWebImage


class SettingViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,RSKImageCropViewControllerDelegate {
    
    var user: User!
    var ref: DatabaseReference!
    let userID = Auth.auth().currentUser?.uid
    let Username = UserDefaults.standard.string(forKey: "Username")
    let Myimage = UserDefaults.standard.url(forKey: "Myimage")
    let storage = Storage.storage()
    let ud = UserDefaults.standard
    
    @IBOutlet weak var userimage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var username: UILabel!
    
    let imageset:[UIImage] = [
        (UIImage(named:"facebook.png")?.resize(size: CGSize(width:30, height:30))!.withRenderingMode(.alwaysTemplate))!,
        (UIImage(named:"cash.png")?.resize(size: CGSize(width:30, height:30))!.withRenderingMode(.alwaysTemplate))!,
        (UIImage(named:"card.png")?.resize(size: CGSize(width:30, height:30))!.withRenderingMode(.alwaysTemplate))!,
        (UIImage(named:"logout.png")?.resize(size: CGSize(width:30, height:30))!.withRenderingMode(.alwaysTemplate))!,
        ]
    
    let textset:[String] = ["facebook連携","振込申請","クレジットカード登録","ログアウト"]


    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Myimage)
        self.userimage.sd_setImage(with: Myimage)
        self.username.text = Username


        tableView.isScrollEnabled = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
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
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
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
        
        let image : UIImage = (info[UIImagePickerControllerOriginalImage] as? UIImage)!
        
        imagePicker.dismiss(animated: false, completion: { () -> Void in
            
            var imageCropVC : RSKImageCropViewController!
            
            imageCropVC = RSKImageCropViewController(image: image, cropMode: RSKImageCropMode.circle)
            
            imageCropVC.moveAndScaleLabel.text = "切り取り範囲を選択"
            imageCropVC.cancelButton.setTitle("キャンセル", for: .normal)
            imageCropVC.chooseButton.setTitle("完了", for: .normal)
            imageCropVC.delegate = self
            
            self.present(imageCropVC, animated: true)
            
        })
        
        
    }
    
    func imageCropViewController(_ controller: RSKImageCropViewController, didCropImage croppedImage: UIImage, usingCropRect cropRect: CGRect, rotationAngle: CGFloat) {
        
        
        //もし円形で画像を切り取りし、その画像自体を加工などで利用したい場合
        if controller.cropMode == .circle {
            UIGraphicsBeginImageContext(croppedImage.size)
            let layerView = UIImageView(image: croppedImage)
            layerView.frame.size = croppedImage.size
            layerView.layer.cornerRadius = layerView.frame.size.width * 0.5
            layerView.clipsToBounds = true
            let context = UIGraphicsGetCurrentContext()!
            layerView.layer.render(in: context)
            let capturedImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            let pngData = UIImagePNGRepresentation(capturedImage)!
            //このImageは円形で余白は透過です。
            let png = UIImage(data: pngData)!
            userimage.image = png
            
            fileupload(deta: png)
            dismiss(animated: true, completion: nil)
            
        }
    }
    
    //トリミング画面でキャンセルを押した時
    func imageCropViewControllerDidCancelCrop(_ controller: RSKImageCropViewController) {
        dismiss(animated: true, completion: nil)
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
            self.present(cameraPicker, animated: true, completion: nil)
            
        }
        else{
            print("error")
            
        }
    }
    
    func fileupload(deta: UIImage) {
        //保存するURLを指定
        let storageRef = storage.reference(forURL: "gs://mujin-3285a.appspot.com")
        //ディレクトリを指定
        let imageRef = storageRef.child("User").child(Username!)
        //保存を実行して、metadataにURLが含まれているので、あとはよしなに加工
        let imageData = UIImageJPEGRepresentation(deta, 1.0)!
        imageRef.putData(imageData, metadata: nil) { metadata, error in
            if (error != nil) {
                print("Uh-oh, an error occurred!")
            } else {
                //URL型をNSstring型に変更
                let downloadURL = metadata!.downloadURL()
                //差し替えた画像をしっかりと保存
                self.ud.set(downloadURL, forKey: "Myimage")
                self.ud.synchronize()
                
                let deta = downloadURL?.absoluteString
                self.ref = Database.database().reference()
                self.ref.child("User").child(self.userID!).updateChildValues(["profile":deta])
                print("成功！")
            }
        }
   }
    
}
