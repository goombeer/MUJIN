//
//  GroupCreateViewController.swift
//  MUJIN.ios
//
//  Created by 高橋勇輝 on 2017/11/07.
//  Copyright © 2017年 高橋勇輝. All rights reserved.
//

import UIKit


class GroupCreateViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate{
  
    

    @IBOutlet weak var groupnameField: UITextField!
    @IBOutlet weak var paymentField: UITextField!
    @IBOutlet weak var menberField: UITextField!
    @IBOutlet weak var periodField: UITextField!
    
    let payment:[Int] = [1000,2000,3000]
    let numberOfmember:[Int] = [4,5,6,7]
    
    var menberpickerView: UIPickerView = UIPickerView()
    var paymentpickerView: UIPickerView = UIPickerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.groupnameField.delegate = self
        periodField.isEnabled = false
        
        //金額のピッカーデリゲート定義
        paymentpickerView.delegate = self
        paymentpickerView.dataSource = self
        paymentpickerView.tag = 1
        paymentpickerView.showsSelectionIndicator = true
        
        let toolbar1 = UIToolbar(frame: CGRectMake(0, 0, 0, 35))
        let doneItem1 = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(GroupCreateViewController.paymentdone))
        toolbar1.setItems([doneItem1], animated: true)
        
        self.paymentField.inputView = paymentpickerView
        self.paymentField.inputAccessoryView = toolbar1
        
        //メンバー数のピッカーデリゲート定義
        menberpickerView.delegate = self
        menberpickerView.dataSource = self
        menberpickerView.tag = 2
        menberpickerView.showsSelectionIndicator = true
        
        let toolbar2 = UIToolbar(frame: CGRectMake(0, 0, 0, 35))
        let doneItem2 = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(GroupCreateViewController.numberdone))
        toolbar2.setItems([doneItem2], animated: true)
        
        self.menberField.inputView = menberpickerView
        self.menberField.inputAccessoryView = toolbar2
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //キーボードの表示/非表示の通知の登録
//        NotificationCenter.default.addObserver(self,selector: "keyboardWillBeShown:",name: NSNotification.Name.UIKeyboardWillShow,object: nil)
//        NotificationCenter.default.addObserver(self,selector: "keyboardWillBeHidden:",name: NSNotification.Name.UIKeyboardWillHide,object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //キーボードの表示/非表示の通知の解除
//        NotificationCenter.default.removeObserver(self,name: NSNotification.Name.UIKeyboardWillShow,object: nil)
//        NotificationCenter.default.removeObserver(self,name: NSNotification.Name.UIKeyboardWillHide,object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    //戻るボタンの処理
    @IBAction func goBack(_ segue:UIStoryboardSegue) {}
    
    //画面遷移するかの判定処理
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (identifier == "pushtomessage") {
            if (self.groupnameField.text?.isEmpty)! {
            let alert = UIAlertController(title: "入力エラー", message: "グループ名を入力してください", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
            return false;
            }
            
        if (identifier == "pushtomessage") {
                if (self.paymentField.text?.isEmpty)! {
                    let alert = UIAlertController(title: "入力エラー", message: "金額をを入力してください", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true, completion: nil)
                    return false;
            }
            
        if (identifier == "pushtomessage") {
                if (self.menberField.text?.isEmpty)! {
                    let alert = UIAlertController(title: "入力エラー", message: "メンバーの数をを入力してください", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true, completion: nil)
                    return false;
                }
            }
          }
        }
        return true;
    }
    
    //画面遷移時の処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "pushtomessage") {
            let InputMessageViewController:InputMessageViewController = segue.destination as! InputMessageViewController
            InputMessageViewController.groupname = self.groupnameField.text!
            InputMessageViewController.payment = self.payment[paymentpickerView.selectedRow(inComponent: 0)]
            InputMessageViewController.memberofnumber = self.numberOfmember[menberpickerView.selectedRow(inComponent: 0)]
            InputMessageViewController.period = self.periodField.text!
        }
    }
    

    
    
    //pickerview実装
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return payment.count
        } else {
            return numberOfmember.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // 表示する文字列を返す
        if pickerView.tag == 1 {
            return String(payment[row]) + "円"
        } else {
            return String(numberOfmember[row]) + "人"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            self.paymentField.text = String(payment[row]) + "円"
        } else {
            self.menberField.text = String(numberOfmember[row]) + "人"
        }
    }
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    

    @objc func paymentdone() {
        self.paymentField.endEditing(true)
    }
    
    @objc func numberdone() {
        if menberField.text == "4人" {
            periodField.text = "4ヶ月"
        } else if menberField.text == "5人" {
            periodField.text = "5ヶ月"
        } else if menberField.text == "6人" {
            periodField.text = "6ヶ月"
        } else if menberField.text == "7人" {
            periodField.text = "7ヶ月"
        }
        self.menberField.endEditing(true)
    }
    
    
    //改行ボタンが押された際に呼ばれる.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        groupnameField.resignFirstResponder()
        return true
    }
    
    //キーボードが隠れないように処理
//    func keyboardWillBeShown(notification: NSNotification) {
//    }
//
//    func keyboardWillBeHidden(notification: NSNotification) {
//    }
}
