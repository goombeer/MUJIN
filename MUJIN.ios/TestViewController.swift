//
//  TestViewController.swift
//  MUJIN.ios
//
//  Created by 高橋勇輝 on 2017/12/03.
//  Copyright © 2017年 高橋勇輝. All rights reserved.
//

import UIKit

class TestViewController: UIViewController,UITextFieldDelegate {
    
    //Buttonの紐付け
    @IBOutlet weak var groupnamefield: UITextField!
    @IBOutlet weak var messagefield: UITextView!
    
    
    @IBOutlet weak var number4button: CustomButton!
    @IBOutlet weak var number5button: CustomButton!
    @IBOutlet weak var number6button: CustomButton!
    @IBOutlet weak var number7button: CustomButton!
    
    @IBOutlet weak var amount1000button: CustomButton!
    @IBOutlet weak var amount2000button: CustomButton!
    @IBOutlet weak var amount3000button: CustomButton!
    
    @IBOutlet weak var publicbutton: CustomButton!
    @IBOutlet weak var unpublicbutton: CustomButton!
    
    //初期の色を定義
    let orangebackgroundcolor:UIColor = UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0)
    let whitebackgroundcolor:UIColor = UIColor.white
    let inittextcolor:UIColor = UIColor.white
    
    //人数ボタンの背景色を監視
    var numberbuttonstatus:Dictionary<String,UIColor> = [:]
    var number4buttonstatus:UIColor = UIColor()
    var number5buttonstatus:UIColor = UIColor()
    var number6buttonstatus:UIColor = UIColor()
    var number7buttonstatus:UIColor = UIColor()

    //金額ボタンの背景色を監視
    var amountbuttonstatus:Dictionary<String,UIColor> = [:]
    var amount1000buttonstatus:UIColor = UIColor()
    var amount2000buttonstatus:UIColor = UIColor()
    var amount3000buttonstatus:UIColor = UIColor()
    
    //公開ボタンの背景色を監視
    var publicbuttonstatuses:Dictionary<String,UIColor> = [:]
    var publicbuttonstatus:UIColor = UIColor()
    var unpublicbuttonstatus:UIColor = UIColor()
 
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    //タップした時の挙動
    @IBAction func number4tapped(_ sender: CustomButton) {
        if numberbuttonstatus.isEmpty == true {
            number4button.backgroundColor = UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0)
            number4button.setTitleColor(UIColor.white, for: .normal)
            self.number4buttonstatus = orangebackgroundcolor
            self.number5buttonstatus = whitebackgroundcolor
            self.number6buttonstatus = whitebackgroundcolor
            self.number7buttonstatus = whitebackgroundcolor
            self.numberbuttonstatus.updateValue(self.number4buttonstatus,forKey: "number4")
            self.numberbuttonstatus.updateValue(self.number5buttonstatus,forKey: "number5")
            self.numberbuttonstatus.updateValue(self.number6buttonstatus,forKey: "number6")
            self.numberbuttonstatus.updateValue(self.number7buttonstatus,forKey: "number7")
            print(self.numberbuttonstatus)
        } else {
            for i in self.numberbuttonstatus {
                //オレンンジのところを探して、その部分を白に変えて
                if i.key == "number4" && i.value ==  orangebackgroundcolor {
                    number4button.backgroundColor = UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0)
                    number4button.setTitleColor(UIColor.white, for: .normal)
                    self.number4buttonstatus = orangebackgroundcolor
                    self.number5buttonstatus = whitebackgroundcolor
                    self.number6buttonstatus = whitebackgroundcolor
                    self.number7buttonstatus = whitebackgroundcolor
                    self.numberbuttonstatus.updateValue(self.number4buttonstatus,forKey: "number4")
                    self.numberbuttonstatus.updateValue(self.number5buttonstatus,forKey: "number5")
                    self.numberbuttonstatus.updateValue(self.number6buttonstatus,forKey: "number6")
                    self.numberbuttonstatus.updateValue(self.number7buttonstatus,forKey: "number7")
                    
                } else if i.key == "number5" && i.value ==  orangebackgroundcolor {
                    self.number5button.backgroundColor = UIColor.white
                    self.number5button.setTitleColor(UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0), for: .normal)
                    self.number4button.backgroundColor = UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0)
                    self.number4button.setTitleColor(UIColor.white, for: .normal)
                    self.number4buttonstatus = orangebackgroundcolor
                    self.number5buttonstatus = whitebackgroundcolor
                    self.number6buttonstatus = whitebackgroundcolor
                    self.number7buttonstatus = whitebackgroundcolor
                    self.numberbuttonstatus.updateValue(self.number4buttonstatus,forKey: "number4")
                    self.numberbuttonstatus.updateValue(self.number5buttonstatus,forKey: "number5")
                    self.numberbuttonstatus.updateValue(self.number6buttonstatus,forKey: "number6")
                    self.numberbuttonstatus.updateValue(self.number7buttonstatus,forKey: "number7")
                } else if i.key == "number6" && i.value ==  orangebackgroundcolor{
                    self.number6button.backgroundColor = UIColor.white
                    self.number6button.setTitleColor(UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0), for: .normal)
                    self.number4button.backgroundColor = UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0)
                    self.number4button.setTitleColor(UIColor.white, for: .normal)
                    self.number4buttonstatus = orangebackgroundcolor
                    self.number5buttonstatus = whitebackgroundcolor
                    self.number6buttonstatus = whitebackgroundcolor
                    self.number7buttonstatus = whitebackgroundcolor
                    self.numberbuttonstatus.updateValue(self.number4buttonstatus,forKey: "number4")
                    self.numberbuttonstatus.updateValue(self.number5buttonstatus,forKey: "number5")
                    self.numberbuttonstatus.updateValue(self.number6buttonstatus,forKey: "number6")
                    self.numberbuttonstatus.updateValue(self.number7buttonstatus,forKey: "number7")
                } else if i.key == "number7" && i.value ==  orangebackgroundcolor{
                    self.number7button.backgroundColor = UIColor.white
                    self.number7button.setTitleColor(UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0), for: .normal)
                    self.number4button.backgroundColor = UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0)
                    self.number4button.setTitleColor(UIColor.white, for: .normal)
                    self.number4buttonstatus = orangebackgroundcolor
                    self.number5buttonstatus = whitebackgroundcolor
                    self.number6buttonstatus = whitebackgroundcolor
                    self.number7buttonstatus = whitebackgroundcolor
                    self.numberbuttonstatus.updateValue(self.number4buttonstatus,forKey: "number4")
                    self.numberbuttonstatus.updateValue(self.number5buttonstatus,forKey: "number5")
                    self.numberbuttonstatus.updateValue(self.number6buttonstatus,forKey: "number6")
                    self.numberbuttonstatus.updateValue(self.number7buttonstatus,forKey: "number7")
                }
            }
            
            
        }
        

    }
    
    @IBAction func number5tapped(_ sender: CustomButton) {
        if numberbuttonstatus.isEmpty == true {
            number5button.backgroundColor = UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0)
            number5button.setTitleColor(UIColor.white, for: .normal)
            self.number4buttonstatus = whitebackgroundcolor
            self.number5buttonstatus = orangebackgroundcolor
            self.number6buttonstatus = whitebackgroundcolor
            self.number7buttonstatus = whitebackgroundcolor
            self.numberbuttonstatus.updateValue(self.number4buttonstatus,forKey: "number4")
            self.numberbuttonstatus.updateValue(self.number5buttonstatus,forKey: "number5")
            self.numberbuttonstatus.updateValue(self.number6buttonstatus,forKey: "number6")
            self.numberbuttonstatus.updateValue(self.number7buttonstatus,forKey: "number7")
            print(self.numberbuttonstatus)
        } else {
            for i in self.numberbuttonstatus {
                //オレンンジのところを探して、その部分を白に変えて
                if i.key == "number4" && i.value ==  orangebackgroundcolor {
                    self.number4button.backgroundColor = UIColor.white
                    self.number4button.setTitleColor(UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0), for: .normal)
                    number5button.backgroundColor = UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0)
                    number5button.setTitleColor(UIColor.white, for: .normal)
                    
                    self.number4buttonstatus = whitebackgroundcolor
                    self.number5buttonstatus = orangebackgroundcolor
                    self.number6buttonstatus = whitebackgroundcolor
                    self.number7buttonstatus = whitebackgroundcolor
                    self.numberbuttonstatus.updateValue(self.number4buttonstatus,forKey: "number4")
                    self.numberbuttonstatus.updateValue(self.number5buttonstatus,forKey: "number5")
                    self.numberbuttonstatus.updateValue(self.number6buttonstatus,forKey: "number6")
                    self.numberbuttonstatus.updateValue(self.number7buttonstatus,forKey: "number7")
                } else if i.key == "number5" && i.value ==  orangebackgroundcolor {
                    self.number5button.backgroundColor = UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0)
                    self.number5button.setTitleColor(UIColor.white, for: .normal)
                    
                    self.number4buttonstatus = whitebackgroundcolor
                    self.number5buttonstatus = orangebackgroundcolor
                    self.number6buttonstatus = whitebackgroundcolor
                    self.number7buttonstatus = whitebackgroundcolor
                    self.numberbuttonstatus.updateValue(self.number4buttonstatus,forKey: "number4")
                    self.numberbuttonstatus.updateValue(self.number5buttonstatus,forKey: "number5")
                    self.numberbuttonstatus.updateValue(self.number6buttonstatus,forKey: "number6")
                    self.numberbuttonstatus.updateValue(self.number7buttonstatus,forKey: "number7")
                } else if i.key == "number6" && i.value ==  orangebackgroundcolor{
                    self.number6button.backgroundColor = UIColor.white
                    self.number6button.setTitleColor(UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0), for: .normal)
                    number5button.backgroundColor = UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0)
                    number5button.setTitleColor(UIColor.white, for: .normal)
                    
                    self.number4buttonstatus = whitebackgroundcolor
                    self.number5buttonstatus = orangebackgroundcolor
                    self.number6buttonstatus = whitebackgroundcolor
                    self.number7buttonstatus = whitebackgroundcolor
                    self.numberbuttonstatus.updateValue(self.number4buttonstatus,forKey: "number4")
                    self.numberbuttonstatus.updateValue(self.number5buttonstatus,forKey: "number5")
                    self.numberbuttonstatus.updateValue(self.number6buttonstatus,forKey: "number6")
                    self.numberbuttonstatus.updateValue(self.number7buttonstatus,forKey: "number7")
                } else if i.key == "number7" && i.value ==  orangebackgroundcolor{
                    self.number7button.backgroundColor = UIColor.white
                    self.number7button.setTitleColor(UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0), for: .normal)
                    number5button.backgroundColor = UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0)
                    number5button.setTitleColor(UIColor.white, for: .normal)
                    
                    self.number4buttonstatus = whitebackgroundcolor
                    self.number5buttonstatus = orangebackgroundcolor
                    self.number6buttonstatus = whitebackgroundcolor
                    self.number7buttonstatus = whitebackgroundcolor
                    self.numberbuttonstatus.updateValue(self.number4buttonstatus,forKey: "number4")
                    self.numberbuttonstatus.updateValue(self.number5buttonstatus,forKey: "number5")
                    self.numberbuttonstatus.updateValue(self.number6buttonstatus,forKey: "number6")
                    self.numberbuttonstatus.updateValue(self.number7buttonstatus,forKey: "number7")
                }
            }
        }
        
        
        
        
        

    }
    
    @IBAction func number6tapped(_ sender: CustomButton) {
        if numberbuttonstatus.isEmpty == true {
            number6button.backgroundColor = UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0)
            number6button.setTitleColor(UIColor.white, for: .normal)
            self.number4buttonstatus = whitebackgroundcolor
            self.number5buttonstatus = whitebackgroundcolor
            self.number6buttonstatus = orangebackgroundcolor
            self.number7buttonstatus = whitebackgroundcolor
            self.numberbuttonstatus.updateValue(self.number4buttonstatus,forKey: "number4")
            self.numberbuttonstatus.updateValue(self.number5buttonstatus,forKey: "number5")
            self.numberbuttonstatus.updateValue(self.number6buttonstatus,forKey: "number6")
            self.numberbuttonstatus.updateValue(self.number7buttonstatus,forKey: "number7")
        } else {
            for i in self.numberbuttonstatus {
                //オレンンジのところを探して、その部分を白に変えて
                if i.key == "number4" && i.value ==  orangebackgroundcolor {
                    self.number4button.backgroundColor = UIColor.white
                    self.number4button.setTitleColor(UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0), for: .normal)
                    number6button.backgroundColor = UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0)
                    number6button.setTitleColor(UIColor.white, for: .normal)
                    
                    self.number4buttonstatus = whitebackgroundcolor
                    self.number5buttonstatus = whitebackgroundcolor
                    self.number6buttonstatus = orangebackgroundcolor
                    self.number7buttonstatus = whitebackgroundcolor
                    self.numberbuttonstatus.updateValue(self.number4buttonstatus,forKey: "number4")
                    self.numberbuttonstatus.updateValue(self.number5buttonstatus,forKey: "number5")
                    self.numberbuttonstatus.updateValue(self.number6buttonstatus,forKey: "number6")
                    self.numberbuttonstatus.updateValue(self.number7buttonstatus,forKey: "number7")
                } else if i.key == "number5" && i.value ==  orangebackgroundcolor {
                    self.number5button.backgroundColor = UIColor.white
                    self.number5button.setTitleColor(UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0), for: .normal)
                    number6button.backgroundColor = UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0)
                    number6button.setTitleColor(UIColor.white, for: .normal)
                    
                    self.number4buttonstatus = whitebackgroundcolor
                    self.number5buttonstatus = whitebackgroundcolor
                    self.number6buttonstatus = orangebackgroundcolor
                    self.number7buttonstatus = whitebackgroundcolor
                    self.numberbuttonstatus.updateValue(self.number4buttonstatus,forKey: "number4")
                    self.numberbuttonstatus.updateValue(self.number5buttonstatus,forKey: "number5")
                    self.numberbuttonstatus.updateValue(self.number6buttonstatus,forKey: "number6")
                    self.numberbuttonstatus.updateValue(self.number7buttonstatus,forKey: "number7")
                } else if i.key == "number6" && i.value ==  orangebackgroundcolor{
                    number6button.backgroundColor = UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0)
                    number6button.setTitleColor(UIColor.white, for: .normal)
                    
                    self.number4buttonstatus = whitebackgroundcolor
                    self.number5buttonstatus = whitebackgroundcolor
                    self.number6buttonstatus = orangebackgroundcolor
                    self.number7buttonstatus = whitebackgroundcolor
                    self.numberbuttonstatus.updateValue(self.number4buttonstatus,forKey: "number4")
                    self.numberbuttonstatus.updateValue(self.number5buttonstatus,forKey: "number5")
                    self.numberbuttonstatus.updateValue(self.number6buttonstatus,forKey: "number6")
                    self.numberbuttonstatus.updateValue(self.number7buttonstatus,forKey: "number7")
                } else if i.key == "number7" && i.value ==  orangebackgroundcolor{
                    self.number7button.backgroundColor = UIColor.white
                    self.number7button.setTitleColor(UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0), for: .normal)
                    number6button.backgroundColor = UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0)
                    number6button.setTitleColor(UIColor.white, for: .normal)
                    
                    self.number4buttonstatus = whitebackgroundcolor
                    self.number5buttonstatus = whitebackgroundcolor
                    self.number6buttonstatus = orangebackgroundcolor
                    self.number7buttonstatus = whitebackgroundcolor
                    self.numberbuttonstatus.updateValue(self.number4buttonstatus,forKey: "number4")
                    self.numberbuttonstatus.updateValue(self.number5buttonstatus,forKey: "number5")
                    self.numberbuttonstatus.updateValue(self.number6buttonstatus,forKey: "number6")
                    self.numberbuttonstatus.updateValue(self.number7buttonstatus,forKey: "number7")
                }
            }
        }
        

    }
    
    @IBAction func number7tapped(_ sender: CustomButton) {
        if numberbuttonstatus.isEmpty == true {
            number7button.backgroundColor = UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0)
            number7button.setTitleColor(UIColor.white, for: .normal)
            self.number4buttonstatus = whitebackgroundcolor
            self.number5buttonstatus = whitebackgroundcolor
            self.number6buttonstatus = whitebackgroundcolor
            self.number7buttonstatus = orangebackgroundcolor
            self.numberbuttonstatus.updateValue(self.number4buttonstatus,forKey: "number4")
            self.numberbuttonstatus.updateValue(self.number5buttonstatus,forKey: "number5")
            self.numberbuttonstatus.updateValue(self.number6buttonstatus,forKey: "number6")
            self.numberbuttonstatus.updateValue(self.number7buttonstatus,forKey: "number7")
            print(self.numberbuttonstatus)
        } else {
            for i in self.numberbuttonstatus {
                //オレンンジのところを探して、その部分を白に変えて
                if i.key == "number4" && i.value ==  orangebackgroundcolor {
                    self.number4button.backgroundColor = UIColor.white
                    self.number4button.setTitleColor(UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0), for: .normal)
                    number7button.backgroundColor = UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0)
                    number7button.setTitleColor(UIColor.white, for: .normal)
                    
                    self.number4buttonstatus = whitebackgroundcolor
                    self.number5buttonstatus = whitebackgroundcolor
                    self.number6buttonstatus = whitebackgroundcolor
                    self.number7buttonstatus = orangebackgroundcolor
                    self.numberbuttonstatus.updateValue(self.number4buttonstatus,forKey: "number4")
                    self.numberbuttonstatus.updateValue(self.number5buttonstatus,forKey: "number5")
                    self.numberbuttonstatus.updateValue(self.number6buttonstatus,forKey: "number6")
                    self.numberbuttonstatus.updateValue(self.number7buttonstatus,forKey: "number7")
                } else if i.key == "number5" && i.value ==  orangebackgroundcolor {
                    self.number5button.backgroundColor = UIColor.white
                    self.number5button.setTitleColor(UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0), for: .normal)
                    number7button.backgroundColor = UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0)
                    number7button.setTitleColor(UIColor.white, for: .normal)
                    
                    self.number4buttonstatus = whitebackgroundcolor
                    self.number5buttonstatus = whitebackgroundcolor
                    self.number6buttonstatus = whitebackgroundcolor
                    self.number7buttonstatus = orangebackgroundcolor
                    self.numberbuttonstatus.updateValue(self.number4buttonstatus,forKey: "number4")
                    self.numberbuttonstatus.updateValue(self.number5buttonstatus,forKey: "number5")
                    self.numberbuttonstatus.updateValue(self.number6buttonstatus,forKey: "number6")
                    self.numberbuttonstatus.updateValue(self.number7buttonstatus,forKey: "number7")
                } else if i.key == "number6" && i.value ==  orangebackgroundcolor{
                    self.number6button.backgroundColor = UIColor.white
                    self.number6button.setTitleColor(UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0), for: .normal)
                    number7button.backgroundColor = UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0)
                    number7button.setTitleColor(UIColor.white, for: .normal)
                    
                    self.number4buttonstatus = whitebackgroundcolor
                    self.number5buttonstatus = whitebackgroundcolor
                    self.number6buttonstatus = whitebackgroundcolor
                    self.number7buttonstatus = orangebackgroundcolor
                    self.numberbuttonstatus.updateValue(self.number4buttonstatus,forKey: "number4")
                    self.numberbuttonstatus.updateValue(self.number5buttonstatus,forKey: "number5")
                    self.numberbuttonstatus.updateValue(self.number6buttonstatus,forKey: "number6")
                    self.numberbuttonstatus.updateValue(self.number7buttonstatus,forKey: "number7")
                } else if i.key == "number7" && i.value ==  orangebackgroundcolor{
                    number7button.backgroundColor = UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0)
                    number7button.setTitleColor(UIColor.white, for: .normal)
                    
                    self.number4buttonstatus = whitebackgroundcolor
                    self.number5buttonstatus = whitebackgroundcolor
                    self.number6buttonstatus = whitebackgroundcolor
                    self.number7buttonstatus = orangebackgroundcolor
                    self.numberbuttonstatus.updateValue(self.number4buttonstatus,forKey: "number4")
                    self.numberbuttonstatus.updateValue(self.number5buttonstatus,forKey: "number5")
                    self.numberbuttonstatus.updateValue(self.number6buttonstatus,forKey: "number6")
                    self.numberbuttonstatus.updateValue(self.number7buttonstatus,forKey: "number7")
                }
            }
        }
        

    }
    
    @IBAction func amount1000tapped(_ sender: CustomButton) {
        if amountbuttonstatus.isEmpty == true {
            amount1000button.backgroundColor = UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0)
            amount1000button.setTitleColor(UIColor.white, for: .normal)
            self.amount1000buttonstatus = orangebackgroundcolor
            self.amount2000buttonstatus = whitebackgroundcolor
            self.amount3000buttonstatus = whitebackgroundcolor
            self.amountbuttonstatus.updateValue(self.amount1000buttonstatus,forKey: "amount1000")
            self.amountbuttonstatus.updateValue(self.amount2000buttonstatus,forKey: "amount2000")
            self.amountbuttonstatus.updateValue(self.amount3000buttonstatus,forKey: "amount3000")
        } else {
            for i in self.amountbuttonstatus {
                //オレンンジのところを探して、その部分を白に変えて
                if i.key == "amount1000" && i.value ==  orangebackgroundcolor {
                    amount1000button.backgroundColor = UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0)
                    amount1000button.setTitleColor(UIColor.white, for: .normal)
                    self.amount1000buttonstatus = orangebackgroundcolor
                    self.amount2000buttonstatus = whitebackgroundcolor
                    self.amount3000buttonstatus = whitebackgroundcolor
                    self.amountbuttonstatus.updateValue(self.amount1000buttonstatus,forKey: "amount1000")
                    self.amountbuttonstatus.updateValue(self.amount2000buttonstatus,forKey: "amount2000")
                    self.amountbuttonstatus.updateValue(self.amount3000buttonstatus,forKey: "amount3000")

                } else if i.key == "amount2000" && i.value ==  orangebackgroundcolor {
                    amount2000button.backgroundColor = UIColor.white
                    amount2000button.setTitleColor(UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0), for: .normal)

                    amount1000button.backgroundColor = UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0)
                    amount1000button.setTitleColor(UIColor.white, for: .normal)
                    self.amount1000buttonstatus = orangebackgroundcolor
                    self.amount2000buttonstatus = whitebackgroundcolor
                    self.amount3000buttonstatus = whitebackgroundcolor
                    self.amountbuttonstatus.updateValue(self.amount1000buttonstatus,forKey: "amount1000")
                    self.amountbuttonstatus.updateValue(self.amount2000buttonstatus,forKey: "amount2000")
                    self.amountbuttonstatus.updateValue(self.amount3000buttonstatus,forKey: "amount3000")
                } else if i.key == "amount3000" && i.value ==  orangebackgroundcolor{
                    amount3000button.backgroundColor = UIColor.white
                    amount3000button.setTitleColor(UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0), for: .normal)
                    
                    amount1000button.backgroundColor = UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0)
                    amount1000button.setTitleColor(UIColor.white, for: .normal)
                    self.amount1000buttonstatus = orangebackgroundcolor
                    self.amount2000buttonstatus = whitebackgroundcolor
                    self.amount3000buttonstatus = whitebackgroundcolor
                    self.amountbuttonstatus.updateValue(self.amount1000buttonstatus,forKey: "amount1000")
                    self.amountbuttonstatus.updateValue(self.amount2000buttonstatus,forKey: "amount2000")
                    self.amountbuttonstatus.updateValue(self.amount3000buttonstatus,forKey: "amount3000")
                }
            }
            
            
        }
    }
    @IBAction func amount2000tapped(_ sender: CustomButton) {
        if amountbuttonstatus.isEmpty == true {
            amount2000button.backgroundColor = UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0)
            amount2000button.setTitleColor(UIColor.white, for: .normal)
            self.amount1000buttonstatus = whitebackgroundcolor
            self.amount2000buttonstatus = orangebackgroundcolor
            self.amount3000buttonstatus = whitebackgroundcolor
            self.amountbuttonstatus.updateValue(self.amount1000buttonstatus,forKey: "amount1000")
            self.amountbuttonstatus.updateValue(self.amount2000buttonstatus,forKey: "amount2000")
            self.amountbuttonstatus.updateValue(self.amount3000buttonstatus,forKey: "amount3000")
        } else {
            for i in self.amountbuttonstatus {
                //オレンンジのところを探して、その部分を白に変えて
                if i.key == "amount1000" && i.value ==  orangebackgroundcolor {
                    amount1000button.backgroundColor = UIColor.white
                    amount1000button.setTitleColor(UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0), for: .normal)
                    
                    amount2000button.backgroundColor = UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0)
                    amount2000button.setTitleColor(UIColor.white, for: .normal)
                    self.amount1000buttonstatus = whitebackgroundcolor
                    self.amount2000buttonstatus = orangebackgroundcolor
                    self.amount3000buttonstatus = whitebackgroundcolor
                    self.amountbuttonstatus.updateValue(self.amount1000buttonstatus,forKey: "amount1000")
                    self.amountbuttonstatus.updateValue(self.amount2000buttonstatus,forKey: "amount2000")
                    self.amountbuttonstatus.updateValue(self.amount3000buttonstatus,forKey: "amount3000")
                    
                } else if i.key == "amount2000" && i.value ==  orangebackgroundcolor {
                    amount2000button.backgroundColor = UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0)
                    amount2000button.setTitleColor(UIColor.white, for: .normal)
                    
                    self.amount1000buttonstatus = whitebackgroundcolor
                    self.amount2000buttonstatus = orangebackgroundcolor
                    self.amount3000buttonstatus = whitebackgroundcolor
                    self.amountbuttonstatus.updateValue(self.amount1000buttonstatus,forKey: "amount1000")
                    self.amountbuttonstatus.updateValue(self.amount2000buttonstatus,forKey: "amount2000")
                    self.amountbuttonstatus.updateValue(self.amount3000buttonstatus,forKey: "amount3000")
                } else if i.key == "amount3000" && i.value ==  orangebackgroundcolor{
                    amount3000button.backgroundColor = UIColor.white
                    amount3000button.setTitleColor(UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0), for: .normal)
                    
                    amount2000button.backgroundColor = UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0)
                    amount2000button.setTitleColor(UIColor.white, for: .normal)
                    self.amount1000buttonstatus = whitebackgroundcolor
                    self.amount2000buttonstatus = orangebackgroundcolor
                    self.amount3000buttonstatus = whitebackgroundcolor
                    self.amountbuttonstatus.updateValue(self.amount1000buttonstatus,forKey: "amount1000")
                    self.amountbuttonstatus.updateValue(self.amount2000buttonstatus,forKey: "amount2000")
                    self.amountbuttonstatus.updateValue(self.amount3000buttonstatus,forKey: "amount3000")
                }
            }
            
            
        }
    }
    @IBAction func amount3000tapped(_ sender: CustomButton) {
        if amountbuttonstatus.isEmpty == true {
            amount3000button.backgroundColor = UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0)
            amount3000button.setTitleColor(UIColor.white, for: .normal)
            self.amount1000buttonstatus = whitebackgroundcolor
            self.amount2000buttonstatus = whitebackgroundcolor
            self.amount3000buttonstatus = orangebackgroundcolor
            self.amountbuttonstatus.updateValue(self.amount1000buttonstatus,forKey: "amount1000")
            self.amountbuttonstatus.updateValue(self.amount2000buttonstatus,forKey: "amount2000")
            self.amountbuttonstatus.updateValue(self.amount3000buttonstatus,forKey: "amount3000")
        } else {
            for i in self.amountbuttonstatus {
                //オレンンジのところを探して、その部分を白に変えて
                if i.key == "amount1000" && i.value ==  orangebackgroundcolor {
                    amount1000button.backgroundColor = UIColor.white
                    amount1000button.setTitleColor(UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0), for: .normal)
                    
                    amount3000button.backgroundColor = UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0)
                    amount3000button.setTitleColor(UIColor.white, for: .normal)
                    self.amount1000buttonstatus = whitebackgroundcolor
                    self.amount2000buttonstatus = whitebackgroundcolor
                    self.amount3000buttonstatus = orangebackgroundcolor
                    self.amountbuttonstatus.updateValue(self.amount1000buttonstatus,forKey: "amount1000")
                    self.amountbuttonstatus.updateValue(self.amount2000buttonstatus,forKey: "amount2000")
                    self.amountbuttonstatus.updateValue(self.amount3000buttonstatus,forKey: "amount3000")
                    
                } else if i.key == "amount2000" && i.value ==  orangebackgroundcolor {
                    amount2000button.backgroundColor = UIColor.white
                    amount2000button.setTitleColor(UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0), for: .normal)
                    
                    amount3000button.backgroundColor = UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0)
                    amount3000button.setTitleColor(UIColor.white, for: .normal)
                    self.amount1000buttonstatus = whitebackgroundcolor
                    self.amount2000buttonstatus = whitebackgroundcolor
                    self.amount3000buttonstatus = orangebackgroundcolor
                    self.amountbuttonstatus.updateValue(self.amount1000buttonstatus,forKey: "amount1000")
                    self.amountbuttonstatus.updateValue(self.amount2000buttonstatus,forKey: "amount2000")
                    self.amountbuttonstatus.updateValue(self.amount3000buttonstatus,forKey: "amount3000")
                } else if i.key == "amount3000" && i.value ==  orangebackgroundcolor{

                    
                    amount3000button.backgroundColor = UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0)
                    amount3000button.setTitleColor(UIColor.white, for: .normal)
                    self.amount1000buttonstatus = whitebackgroundcolor
                    self.amount2000buttonstatus = whitebackgroundcolor
                    self.amount3000buttonstatus = orangebackgroundcolor
                    self.amountbuttonstatus.updateValue(self.amount1000buttonstatus,forKey: "amount1000")
                    self.amountbuttonstatus.updateValue(self.amount2000buttonstatus,forKey: "amount2000")
                    self.amountbuttonstatus.updateValue(self.amount3000buttonstatus,forKey: "amount3000")
                }
            }
            
            
        }
    }
    
    @IBAction func publictapped(_ sender: CustomButton) {
        
        if unpublicbutton.backgroundColor == UIColor.white {
            
           publicbutton.backgroundColor = UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0)
           publicbutton.setTitleColor(UIColor.white, for: .normal)
        } else if unpublicbutton.backgroundColor == UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0) {
            unpublicbutton.backgroundColor = UIColor.white
            unpublicbutton.setTitleColor(UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0), for: .normal)
            
            publicbutton.backgroundColor = UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0)
            publicbutton.setTitleColor(UIColor.white, for: .normal)
        } else {
            publicbutton.backgroundColor = UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0)
            publicbutton.setTitleColor(UIColor.white, for: .normal)
        }
        
    }
    
    @IBAction func unpublictapped(_ sender: CustomButton) {
        if publicbutton.backgroundColor == UIColor.white {
            
            unpublicbutton.backgroundColor = UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0)
            unpublicbutton.setTitleColor(UIColor.white, for: .normal)
        } else if publicbutton.backgroundColor == UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0) {
            publicbutton.backgroundColor = UIColor.white
            publicbutton.setTitleColor(UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0), for: .normal)
            
            unpublicbutton.backgroundColor = UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0)
            unpublicbutton.setTitleColor(UIColor.white, for: .normal)
        } else {
            unpublicbutton.backgroundColor = UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0)
            unpublicbutton.setTitleColor(UIColor.white, for: .normal)
        }
        
    }
    @IBAction func sharetapped(_ sender: CustomButton) {

    }
    
}
