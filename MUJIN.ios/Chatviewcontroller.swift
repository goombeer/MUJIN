//
//  Chatviewcontroller.swift
//  MUJIN.ios
//
//  Created by 高橋勇輝 on 2017/11/25.
//  Copyright © 2017年 高橋勇輝. All rights reserved.
//

import UIKit
import SnapKit
import SlackTextViewController
import Firebase
import FirebaseDatabase

class ChatViewController: SLKTextViewController {
    var groupname:String = ""
    var messages = [Message]()
    let username = UserDefaults.standard.string(forKey: "Username")
    let user = UserDefaults.standard.string(forKey: "UID")
    let groupid = UserDefaults.standard.string(forKey: "tappedgroupid")
    var ref = Database.database().reference()
    private var databaseHandle: DatabaseHandle!
    
    
    override class func tableViewStyle(for decoder: NSCoder) -> UITableViewStyle {
        return .plain
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = groupname
        self.textView.placeholder = "メッセージを入力してください";
        
        if let tableView = self.tableView {
            tableView.separatorStyle = .none
            tableView.register(TableViewCell.classForCoder(),forCellReuseIdentifier: "cell")
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = 2
        }
        
        // NSNotification
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ChatViewController.noticeReceived),
                                               name: NSNotification.Name(rawValue: "notireceived"), object: nil)
        self.tableView?.reloadData()
        self.tableView!.sectionHeaderHeight = 300
        
        startObservingDatabase ()
    }
    
   
    //↓この処理を書いたらテキストフォームが隠れるようになってしまった。ライブラリーの何かを上書きしたみたいで、テキストフォームが動かなくなった
//    override func viewDidAppear(_ animated: Bool) {
//    }
    @objc func noticeReceived() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        ref.child("Messages").child(groupid!).removeAllObservers()
    }
    
    func addMessage(name: String,msg: String,right: Bool = true) {
        ref.child("Messages").child(groupid!).childByAutoId().setValue(["sender":username,"text":msg,"time":ServerValue.timestamp()])
        

    }
    
    func startObservingDatabase () {

        databaseHandle = ref.child("Messages").child(self.groupid!).observe(.value, with: { (snapshot) in
            var newmessages = [Message]()
            print(self.databaseHandle)
            for itemSnapShot in snapshot.children {
                let item = Message(snapshot: itemSnapShot as! DataSnapshot)
                newmessages.insert(item!,at:0)
            }
            
            self.messages = newmessages
            self.tableView?.reloadData()

        })
    }

    override func didPressRightButton(_ sender: Any?) {
        addMessage(name: username!,msg:self.textView.text)
        self.textView.text = ""
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView,numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath as IndexPath) as! TableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        let m = messages[indexPath.row]
        cell.name.text = m.sendername
        cell.comment.text = m.text
        cell.comment.numberOfLines = 0
        cell.transform = self.tableView!.transform
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    @IBAction func gobacktapped(_ sender: UIBarButtonItem) {
        let ud = UserDefaults.standard
        ud.removeObject(forKey: "groupid")
        self.dismiss(animated: true)
    }
    
    
}


