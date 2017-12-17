//
//  SegmentViewController.swift
//  MUJIN.ios
//
//  Created by 高橋勇輝 on 2017/12/09.
//  Copyright © 2017年 高橋勇輝. All rights reserved.
//

import UIKit

class SegmentViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
  
    let idList: [String] = ["Home", "Group"]
    
    var pageViewController: UIPageViewController!
    var viewControllers: [UIViewController] = []
  
    @IBOutlet weak var segmenttab: UISegmentedControl!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        for id in idList {
          viewControllers.append((storyboard?.instantiateViewController(withIdentifier: id))!)
        }
        self.navigationItem.title = "ホーム"

        pageViewController = childViewControllers[0] as! UIPageViewController
        pageViewController.setViewControllers([viewControllers[0]], direction: .forward, animated: true, completion: nil)
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index = idList.index(of: viewController.restorationIdentifier!)!
       
        if (index > 0) {
            
            return storyboard!.instantiateViewController(withIdentifier: idList[index - 1])
        }
      
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = idList.index(of: viewController.restorationIdentifier!)!
        
        if (index < idList.count - 1) {
            return storyboard!.instantiateViewController(withIdentifier: idList[index + 1])
        }
  
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let index = idList.index(of: (pageViewController.viewControllers?.first!.restorationIdentifier)!)
        if index == 0 {
            self.navigationItem.title = "ホーム"
        } else {
            self.navigationItem.title = "参加グループ"
        }
        self.segmenttab.selectedSegmentIndex = index!
    }

    @IBAction func selecttapped(_ sender: Any) {
        switch (sender as AnyObject).selectedSegmentIndex {
        case 0:
            pageViewController.setViewControllers([viewControllers[0]], direction: .reverse, animated: true, completion: nil)
            self.navigationItem.title = "ホーム"
            break
        case 1:
            pageViewController.setViewControllers([viewControllers[1]], direction: .forward, animated: true, completion: nil)
            self.navigationItem.title = "参加グループ"
            break
        default:
            return
        }
    }
    
}
