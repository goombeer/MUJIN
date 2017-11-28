//
//  GroupDetailViewController.swift
//  MUJIN.ios
//
//  Created by 高橋勇輝 on 2017/11/23.
//  Copyright © 2017年 高橋勇輝. All rights reserved.
//

import UIKit

class GroupDetailViewController: UIViewController {
    var groupimage: UIImage = UIImage()
    var namelabel: String = ""
    var joinnumber: String = ""
    var amountlabel: String = ""
    
    
    @IBOutlet weak var navigatiobar: UINavigationBar!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var join: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var period: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = namelabel
        image.image = groupimage
        join.text = joinnumber
        amount.text = amountlabel
        if joinnumber == "4人" {
            period.text = "4ヶ月"
        } else if joinnumber == "5人" {
            period.text = "4ヶ月"
        } else if joinnumber == "6人" {
            period.text = "4ヶ月"
        } else if joinnumber == "7人" {
            period.text = "4ヶ月"
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tappedchat(_ sender: UIButton) {
        
        performSegue(withIdentifier: "Gotochat", sender: namelabel)

    }
    
    // Segue 準備
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "Gotochat") {
            guard let ChatVC = segue.destination as? ChatViewController else {
                return
            }
          
            // SubViewController のselectedImgに選択された画像を設定する
            ChatVC.groupname = namelabel
          
        }
    }
    
    
    @IBAction func goBacktoGrouodetail(_ segue:UIStoryboardSegue) {

        
    }

    

}
