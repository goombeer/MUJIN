//
//  InputMessageViewController.swift
//  MUJIN.ios
//
//  Created by 高橋勇輝 on 2017/11/18.
//  Copyright © 2017年 高橋勇輝. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class InputMessageViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate{
    
    

    var ref: DatabaseReference!
    let user = UserDefaults.standard.string(forKey: "MyUID")
    
    //前の画面からの変数の受け取り
    var groupname: String = ""
    var payment:Int = 0
    var memberofnumber: Int = 0
    var period: String = ""
    var publicnum: Int = 0
    
    @IBOutlet weak var messageView: UITextView!
    @IBOutlet weak var publicField: UITextField!
    
    let publicsetting:[String] = ["","全体公開にする","非公開にする"]
    var publicpickerView: UIPickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        messageView.layer.borderWidth = 0.5
        messageView.layer.cornerRadius = 10
        messageView.layer.borderColor = UIColor.lightGray.cgColor
        
        print(groupname)
        print(payment)
        print(memberofnumber)
        print(period)
        
        self.publicField.delegate = self
        
        //全体公開のデリゲート定義
        publicpickerView.delegate = self
        publicpickerView.dataSource = self
        publicpickerView.showsSelectionIndicator = true
        
        let toolbar = UIToolbar(frame: CGRectMake(0, 0, 0, 35))
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(InputMessageViewController.done))
        toolbar.setItems([doneItem], animated: true)
        
        self.publicField.inputView = publicpickerView
        self.publicField.inputAccessoryView = toolbar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return publicsetting.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // 表示する文字列を返す
            return publicsetting[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
           self.publicField.text = publicsetting[row]
    }
    
    
    
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    @objc func done() {
        self.publicField.endEditing(true)
    }
    
    
    @IBAction func sharegroup(_ sender: UIButton) {
      let message = messageView.text
        print(message!)
        if self.publicsetting[publicpickerView.selectedRow(inComponent: 0)] == "全体公開にする"{
            publicnum = 1
        } else if self.publicsetting[publicpickerView.selectedRow(inComponent: 0)] == "非公開にする"{
            publicnum = 2
        }
        
      ref = Database.database().reference()
      let GroupId = ref.child("Group").childByAutoId().key
        
        self.ref.child("Gruop").child(GroupId).setValue(["payment":payment,"memberofnumber":memberofnumber,"period":period,"founder":(self.user)!,"name":groupname,"message":message!,"publicnum":self.publicnum])
      
        self.ref.child("User").child(self.user!).child("groups").updateChildValues([GroupId:true])

        
    }
}

