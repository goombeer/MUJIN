//
//  NoticeViewController.swift
//  MUJIN.ios
//
//  Created by 高橋勇輝 on 2017/11/19.
//  Copyright © 2017年 高橋勇輝. All rights reserved.
//

import UIKit

class NoticeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    let imageset:[UIImage] = [
        (UIImage(named:"facebook.png")?.resize(size: CGSize(width:50, height:50))!.withRenderingMode(.alwaysTemplate))!,
        (UIImage(named:"cash.png")?.resize(size: CGSize(width:50, height:50))!.withRenderingMode(.alwaysTemplate))!,
        (UIImage(named:"card.png")?.resize(size: CGSize(width:50, height:50))!.withRenderingMode(.alwaysTemplate))!,
        (UIImage(named:"logout.png")?.resize(size: CGSize(width:50, height:50))!.withRenderingMode(.alwaysTemplate))!,
        ]
    
     let textset:[String] = ["facebook連携","振込申請","クレジットカード登録","ログアウト"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageset.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellImage = imageset[indexPath.row]
        let cellText = textset[indexPath.row]
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "CELL")
        cell.textLabel?.text = cellText
        cell.imageView?.image = cellImage
        
        
        return cell
    }

}
