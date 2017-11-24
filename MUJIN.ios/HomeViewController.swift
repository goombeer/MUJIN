//
//  HomeViewController.swift
//  MUJIN.ios
//
//  Created by 高橋勇輝 on 2017/11/07.
//  Copyright © 2017年 高橋勇輝. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class HomeViewController: UIViewController,UICollectionViewDataSource,
UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout{

    var ref: DatabaseReference!
    var items = [GroupData]()
    private var databaseHandle: DatabaseHandle!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
       
        
        ref = Database.database().reference()
        databaseHandle = ref.child("Gruop").observe(.value, with: { (snapshot) in
            
            var newItems = [GroupData]()
            
            for itemSnapShot in snapshot.children {
                let item = GroupData(snapshot: itemSnapShot as! DataSnapshot)
                if item?.publicnum == 1 {
                    newItems.append(item!)
                }
            }
                self.items = newItems
                self.collectionView.reloadData()
       })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return items.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "homecell", for: indexPath as IndexPath)
        let item = items[indexPath.row]
        
        let groupimage = cell.contentView.viewWithTag(1) as? UIImageView
        groupimage?.image = UIImage(named: "line.png")
        
        let namelabel = cell.contentView.viewWithTag(2) as? UILabel
        namelabel?.text = item.name!
        
        
        let joinlabel = cell.contentView.viewWithTag(3) as? UILabel
        joinlabel?.text = String(describing: item.memberofnumber!) + "人"
        
        let amountlabel = cell.contentView.viewWithTag(4) as? UILabel
        amountlabel?.text = String(describing: item.memberofnumber! * item.payment!) + "円"
        
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 6
        cell.layer.borderColor = UIColor.gray.cgColor

        return cell
    }
    
}
