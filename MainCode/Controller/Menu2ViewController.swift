//
//  Menu2ViewController.swift
//  MainCode
//
//  Created by Apple on 5/9/19.
//  Copyright © 2019 Kien. All rights reserved.
//

import UIKit

class Menu2ViewController: UIViewController {
    @IBOutlet weak var sidaBar2: UIView!
    @IBOutlet weak var viewMoveMagic2: UIView!
    @IBOutlet weak var navigationIcon2: UIImageView!
    @IBOutlet weak var navigationText2: UILabel!
    @IBOutlet weak var messengerIcon2: UIImageView!
    @IBOutlet weak var chatsText2: UILabel!
    @IBOutlet weak var peopleIcon2: UIImageView!
    @IBOutlet weak var friendListText2: UILabel!
    @IBOutlet weak var statisticsIcon2: UIImageView!
    @IBOutlet weak var statisticsText2: UILabel!
    @IBOutlet weak var settingsIcon2: UIImageView!
    @IBOutlet weak var settingsText2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sidaBar2.frame.origin.x -= sidaBar2.frame.size.width
        peopleIcon2.tintColor = UIColor(red: CGFloat(79)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(182)/255.0, alpha: 1)
        statisticsIcon2.tintColor = .white
        statisticsText2.textColor = .white
        view.backgroundColor = UIColor(red: CGFloat(0)/255.0, green: CGFloat(0)/255.0, blue: CGFloat(0)/255.0, alpha: 0.05)
        
        // Do any additional setup after loading the view.
        showMenuSideBar2()
    }
    @IBAction func onClickNavigation2(_ sender: UIButton) {
    }
    
    @IBAction func onClickChat2(_ sender: UIButton) {
    }
    
    @IBAction func onClickFriendlist2(_ sender: UIButton) {
        moveToFriendlist()
        closeMenuSideBarMoveToFriendlist()
    }
    
    @IBAction func onClickStatistics2(_ sender: UIButton) {
    }
    
    @IBAction func onClickControlCenter2(_ sender: UIButton) {
    }
    
    @IBAction func onClickLogOut(_ sender: UIButton) {
    }
    
    @IBAction func onClickMoveBack(_ sender: UIButton) {
    }
    
    func showMenuSideBar2() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
            self.sidaBar2.frame.origin.x += self.sidaBar2.frame.size.width
        }, completion: nil)
    }
    
    func moveToFriendlist() {
        UIView.animate(withDuration: 0.25) {
            self.viewMoveMagic2.frame.origin.y = self.peopleIcon2.frame.origin.y - 13
            self.peopleIcon2.tintColor = .white
            self.friendListText2.textColor = .white
        }
        self.messengerIcon2.tintColor = UIColor(red: CGFloat(79)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(182)/255.0, alpha: 1)
        self.chatsText2.textColor = UIColor(red: CGFloat(79)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(182)/255.0, alpha: 1)
        self.settingsIcon2.tintColor = UIColor(red: CGFloat(79)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(182)/255.0, alpha: 1)
        self.settingsText2.textColor = UIColor(red: CGFloat(79)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(182)/255.0, alpha: 1)
        self.navigationIcon2.tintColor = UIColor(red: CGFloat(79)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(182)/255.0, alpha: 1)
        self.navigationText2.textColor = UIColor(red: CGFloat(79)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(182)/255.0, alpha: 1)
        self.statisticsIcon2.tintColor = UIColor(red: CGFloat(79)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(182)/255.0, alpha: 1)
        self.statisticsText2.textColor = UIColor(red: CGFloat(79)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(182)/255.0, alpha: 1)
    }
    
    func closeMenuSideBarMoveToFriendlist() {
        UIView.animate(withDuration: 0.5, delay: 0.25, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
            self.sidaBar2.frame.origin.x -= self.sidaBar2.frame.size.width
            
        }) { completed in
            
//            self.removeFromParent()
            for view in self.view.subviews {
                view.removeFromSuperview()
            }
            for view in self.view.subviews {
                view.removeFromSuperview()
            }
            
            
            let friendlistVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sbFriendlistID") as! FriendlistViewController
            self.addChild(friendlistVC)
            friendlistVC.view.frame = self.view.frame
            self.view.addSubview(friendlistVC.view)
            friendlistVC.didMove(toParent: self)
            
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
