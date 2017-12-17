//
//  TestViewController.swift
//  MUJIN.ios
//
//  Created by 高橋勇輝 on 2017/12/03.
//  Copyright © 2017年 高橋勇輝. All rights reserved.
//

import UIKit
import Firebase
import RSKImageCropper

extension UITextField {
    func addBorderBottom(height: CGFloat, color: UIColor) {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: self.frame.height - height, width: self.frame.width, height: height)
        border.backgroundColor = color.cgColor
        self.layer.addSublayer(border)
    }
}

class TestViewController: UIViewController,UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate,RSKImageCropViewControllerDelegate{
    
    var ref: DatabaseReference!
    let user = UserDefaults.standard.string(forKey: "MyUID")
    let storage = Storage.storage()
    
    var payment:Int = 0
    var memberofnumber: Int = 0
    var period: String = ""
    var publicnum: Int = 0
    var takenphoto: UIImage = UIImage()
    
    //Buttonの紐付け
    @IBOutlet weak var groupnamefield: UITextField!
    @IBOutlet weak var messagefield: UITextField!

    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet var numbercollection: [CustomButton]!
    
    @IBOutlet weak var number4button: CustomButton!
    @IBOutlet weak var number5button: CustomButton!
    @IBOutlet weak var number6button: CustomButton!
    @IBOutlet weak var number7button: CustomButton!
    

    @IBOutlet weak var amount1000button: CustomButton!
    @IBOutlet weak var amount2000button: CustomButton!
    @IBOutlet weak var amount3000button: CustomButton!
    
    @IBOutlet weak var publicbutton: CustomButton!
    @IBOutlet weak var unpublicbutton: CustomButton!
    
    @IBOutlet weak var cameratap: CustomButton!
    


 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messagefield.layer.cornerRadius = 10
        
        groupnamefield.delegate = self
        messagefield.delegate = self
        
        //ナビゲーションボタン
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "閉じる", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = UIColor.white
      
        
        let ToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        ToolBar.barStyle = UIBarStyle.default  // スタイルを設定
        
        ToolBar.sizeToFit()  // 画面幅に合わせてサイズを変更
        
        // スペーサー
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        
        // 閉じるボタン
        let commitButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.commitButtonTapped))
        
        
        ToolBar.items = [spacer, commitButton]
        
        groupnamefield.inputAccessoryView = ToolBar
        messagefield.inputAccessoryView = ToolBar
        
        //groupnameのレイアウト
        
        groupnamefield.addBorderBottom(height: 1.0, color: UIColor.lightGray)
        groupnamefield.attributedPlaceholder = NSAttributedString(string: "グループ名を入力！",
                                                                  attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        
        
        messagefield.addBorderBottom(height: 1.0, color: UIColor.lightGray)
        messagefield.attributedPlaceholder = NSAttributedString(string: "メッセージを入力！",
                                                                attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    //タップした時の挙動
    @IBAction func number4tapped(_ sender: CustomButton) {
        self.turnOn(self.number4button)
        self.turnOff(self.number5button)
        self.turnOff(self.number6button)
        self.turnOff(self.number7button)
        groupnamefield.resignFirstResponder()
        self.memberofnumber = 4
        self.period = "4ヶ月"
    }
    
    @IBAction func number5tapped(_ sender: CustomButton) {
        self.turnOff(self.number4button)
        self.turnOn(self.number5button)
        self.turnOff(self.number6button)
        self.turnOff(self.number7button)
        groupnamefield.resignFirstResponder()
        self.memberofnumber = 5
        self.period = "5ヶ月"
    }
    
    @IBAction func number6tapped(_ sender: CustomButton) {
        self.turnOff(self.number4button)
        self.turnOff(self.number5button)
        self.turnOn(self.number6button)
        self.turnOff(self.number7button)
        groupnamefield.resignFirstResponder()
        self.memberofnumber = 6
        self.period = "6ヶ月"
    }
    
    @IBAction func number7tapped(_ sender: CustomButton) {
        self.turnOff(self.number4button)
        self.turnOff(self.number5button)
        self.turnOff(self.number6button)
        self.turnOn(self.number7button)
        groupnamefield.resignFirstResponder()
        self.memberofnumber = 7
        self.period = "7ヶ月"
    }
    
    @IBAction func amount1000tapped(_ sender: CustomButton) {
        self.turnOn(self.amount1000button)
        self.turnOff(self.amount2000button)
        self.turnOff(self.amount3000button)
        self.payment = 1000

    }
    @IBAction func amount2000tapped(_ sender: CustomButton) {
        self.turnOff(self.amount1000button)
        self.turnOn(self.amount2000button)
        self.turnOff(self.amount3000button)
        self.payment = 2000
    }
    @IBAction func amount3000tapped(_ sender: CustomButton) {
        self.turnOff(self.amount1000button)
        self.turnOff(self.amount2000button)
        self.turnOn(self.amount3000button)
        self.payment = 3000

    }
    
    @IBAction func publictapped(_ sender: CustomButton) {
        self.turnOn(self.publicbutton)
        self.turnOff(self.unpublicbutton)
        messagefield.resignFirstResponder()
        self.publicnum = 1
    }
    
    @IBAction func unpublictapped(_ sender: CustomButton) {
        self.turnOff(self.publicbutton)
        self.turnOn(self.unpublicbutton)
        messagefield.resignFirstResponder()
        self.publicnum = 2

    }
    @IBAction func sharetapped(_ sender: CustomButton) {
        savegroupdata(deta: self.takenphoto)
        performSegue(withIdentifier: "GotoShare", sender: nil)
    }
    
    //画面遷移するかの判定処理
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (identifier == "Gotoshare") {
            if (self.groupnamefield.text?.isEmpty)! {
                let alert = UIAlertController(title: "入力エラー", message: "グループ名を入力してください", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true, completion: nil)
                return false;
            }
            
            if (identifier == "Gotoshare") {
                if self.memberofnumber == 0{
                    let alert = UIAlertController(title: "入力エラー", message: "メンバーの数をを入力してください", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true, completion: nil)
                    return false;
                }
            }
            
            if (identifier == "Gotoshare") {
                if self.payment == 0 {
                    let alert = UIAlertController(title: "入力エラー", message: "金額をを入力してください", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true, completion: nil)
                    return false;
                }
           
            if (identifier == "Gotoshare") {
                    if publicnum == 0{
                        let alert = UIAlertController(title: "入力エラー", message: "メッセージを入力してください", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(alert, animated: true, completion: nil)
                        return false;
                    }
            }
                
            if (identifier == "Gotoshare") {
                    if publicnum == 0{
                        let alert = UIAlertController(title: "入力エラー", message: "公開範囲を設定してください", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(alert, animated: true, completion: nil)
                        return false;
                    }
                }
            }
            
        }
        
        
        return true;
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        
        // キーボードを閉じる
        groupnamefield.resignFirstResponder()
        
        return true
    }
    
    @IBAction func cameratapped(_ sender: CustomButton) {
        //アラート表示のために
        let actionSheet = UIAlertController(title: "", message: "グループ画像を設定してください！", preferredStyle: UIAlertControllerStyle.actionSheet)
        
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
            self.takenphoto = png
            cameratap.setBackgroundImage(png, for: .normal)
            cameratap.setTitle("", for: .normal)
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
    
    @objc func commitButtonTapped (){
        self.view.endEditing(true)
    }
    
    func turnOn(_ button: CustomButton) {
        button.backgroundColor = UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0)
        button.setTitleColor(UIColor.white, for: .normal)
    }
    
    func turnOff(_ button: CustomButton) {
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0), for: .normal)
    }
    
    func savegroupdata(deta: UIImage) {
        self.ref = Database.database().reference()

        let GroupId = self.ref.child("Group").childByAutoId().key
        let groupname = self.groupnamefield.text
        let message = self.messagefield.text
        //保存するURLを指定
        let storageRef = storage.reference(forURL: "gs://mujin-3285a.appspot.com")
        //ディレクトリを指定
        let imageRef = storageRef.child("Group").child(GroupId)
        
        //保存を実行して、metadataにURLが含まれているので、あとはよしなに加工
        let imageData = UIImageJPEGRepresentation(deta, 1.0)!
        imageRef.putData(imageData, metadata: nil) { metadata, error in
            if (error != nil) {
                print("Uh-oh, an error occurred!")
            } else {
                //URL型をNSstring型に変更
                let downloadURL = metadata!.downloadURL()
                
                let deta = downloadURL?.absoluteString
               
               
            self.ref.child("Gruop").child(GroupId).setValue(["payment":self.payment,"memberofnumber":self.memberofnumber,"period":self.period,"founder":(self.user)!,"name":groupname!,"message":message!,"publicnum":self.publicnum,"groupprofile":deta])
                
                    self.ref.child("Gruop").child(GroupId).child("users").setValue([(self.user)!:true])
                
                    self.ref.child("User").child(self.user!).child("groups").updateChildValues([GroupId:true])
                
            }
        }

    }
   
  }

