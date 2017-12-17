//
//  SlideViewController.swift
//  
//
//  Created by 高橋勇輝 on 2017/12/10.
//

import UIKit

class SlideViewController: UIPageViewController{

    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var pagecontrol: UIPageControl!
    var joinnumber: String = ""
    var amountlabel: String = ""
    var groupimage: UIImage = UIImage()

    let ud = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
     
        titlelabel.text = ud.string(forKey: "tappedgroupname")
        self.view.backgroundColor = UIColor.white
        self.setViewControllers([getChat()], direction: .forward, animated: true, completion: nil)
        self.dataSource = self as! UIPageViewControllerDataSource
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    func getChat() -> ChatViewController {
        return storyboard!.instantiateViewController(withIdentifier: "chat") as! ChatViewController
    }
    
    func getDetail() -> GroupDetailViewController {
        let GDVC = storyboard!.instantiateViewController(withIdentifier: "detail") as! GroupDetailViewController
        GDVC.joinnumber = self.joinnumber
        GDVC.amountlabel = self.amountlabel
        GDVC.groupimage = self.groupimage
        return GDVC
    }
    
    @IBAction func GobackToGroup(_ sender: Any) {
        if UserDefaults.standard.string(forKey: "tappedgroupname") == nil {
            print("こっちが呼ばれるはず")
            self.dismiss(animated: true, completion: nil)
        } else {
            let ud = UserDefaults.standard
            ud.removeObject(forKey: "tappedgroupname")
            ud.removeObject(forKey: "tappedgroupid")
            ud.removeObject(forKey: "tappedfounder")
            self.dismiss(animated: true)
        }
        
    }
    
    
}

extension SlideViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if viewController.isKind(of:GroupDetailViewController.self) {
            pagecontrol.currentPage = 0
            return getChat()
        }  else {
            pagecontrol.currentPage = 0

            return nil
        }
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if viewController.isKind(of:ChatViewController.self) {
            pagecontrol.currentPage = 1
            return getDetail()
        }  else {
            pagecontrol.currentPage = 1

            return nil
        }
        
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return 2
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
