//
//  MenuSideBarViewController.swift
//  MainCode
//
//  Created by Apple on 4/23/19.
//  Copyright © 2019 Kien. All rights reserved.
//

import UIKit
import JGProgressHUD
class MenuSideBarViewController: UIViewController {
    @IBOutlet weak var sideBar: UIView!
    @IBOutlet weak var viewMoveMagic: UIView!
    @IBOutlet weak var peopleIcon: UIImageView!
    @IBOutlet weak var friendListText: UILabel!
    @IBOutlet weak var settingsIcon: UIImageView!
    @IBOutlet weak var controlCenterText: UILabel!
    @IBOutlet weak var messageIcon: UIImageView!
    @IBOutlet weak var chatsText: UILabel!
    @IBOutlet weak var navigationIcon: UIImageView!
    @IBOutlet weak var navigationText: UILabel!
    @IBOutlet weak var statisticsIcon: UIImageView!
    @IBOutlet weak var statisticsText: UILabel!
    
    @IBOutlet weak var defaultProfile: UIImageView!
    @IBOutlet weak var profilebarname: UILabel!

    
    var finalName = ""
    
    let hud: JGProgressHUD = {
        let hud = JGProgressHUD(style: .light)
        hud.interactionType = .blockAllTouches
        return hud
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCurrentUser()

        //testLabel.text = finalName
        //setupViews()
        // Do any additional setup after loading the view.
        
//        if finalName == "friendlist" {
//            self.viewMoveMagic.frame.origin.y = self.peopleIcon.frame.origin.y - 13
//        } else if finalName == "statistic" {
//            self.viewMoveMagic.frame.origin.y = self.statisticsIcon.frame.origin.y - 10
//            self.statisticsIcon.tintColor = .white
//            self.statisticsText.textColor = .white
//            self.peopleIcon.tintColor = UIColor(red: CGFloat(79)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(182)/255.0, alpha: 1)
//            self.friendListText.textColor = UIColor(red: CGFloat(79)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(182)/255.0, alpha: 1)
//        }
//
        self.statisticsIcon.tintColor = UIColor(red: CGFloat(79)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(182)/255.0, alpha: 1)
        sideBar.frame.origin.x -= sideBar.frame.size.width
        self.view.backgroundColor = UIColor.init(displayP3Red: 0, green: 0, blue: 0, alpha: 0.05)
        
        
        
        //Fire animations
        showMenuSideBar()
        
        
    }
    
 
    
//    let profileImageViewHeight: CGFloat = 78
//    lazy var profileImageView: UIImageView = {
//        var iv = UIImageView()
//        iv.backgroundColor = Service.baseColor
//        iv.contentMode = .scaleAspectFill
//        iv.layer.cornerRadius = profileImageViewHeight / 2
//        iv.clipsToBounds = true
//        return iv
//    }()
//
//    let nameLabel: UILabel = {
//        let label = UILabel()
//        label.text = "User's Name"
//        label.font = UIFont.boldSystemFont(ofSize: 18)
//        return label
//    }()
//
//    let uidLabel: UILabel = {
//        let label = UILabel()
//        label.text = "User's Uid"
//        label.font = UIFont.systemFont(ofSize: 14)
//        label.textColor = .lightGray
//        return label
//    }()
//
//    let emailLabel: UILabel = {
//        let label = UILabel()
//        label.text = "User's Email"
//        label.font = UIFont.systemFont(ofSize: 14)
//        label.textColor = .lightGray
//        return label
//    }()
//
 
    
    
  
    
    func fetchCurrentUser() {
    
        Spark.fetchCurrentSparkUser { (message, err, sparkUser) in
            if let err = err {
                SparkService.dismissHud(self.hud, text: "Error", detailText: "\(message) \(err.localizedDescription)", delay: 0)
                return
            }
            guard let sparkUser = sparkUser else {
                SparkService.dismissHud(self.hud, text: "Error", detailText: "Failed to fetch user", delay: 0 )
                return
            }
                
                DispatchQueue.main.async {
                    self.defaultProfile.loadImageUsingCacheWithUrlString(sparkUser.profileImageUrl)
                    
                    self.profilebarname.text = sparkUser.name
       
               
                }
                
                SparkService.dismissHud(self.hud, text: "Success", detailText: "Successfully fetched user", delay: 0)
            
        }
    }
    @IBAction func logOutButton(_ sender: UIButton) {
        handleSignOutButtonTapped()
    }
    
    @objc func handleSignOutButtonTapped() {
        Spark.logout { (result, err) in
            if let err = err {
                SparkService.showAlert(style: .alert, title: "Sign Out Error", message: "Failed to sign out with error: \(err.localizedDescription)")
                return
            }
            
            if result {
                let controller = LoginViewController()
                let navController = UINavigationController(rootViewController: controller)
                self.present(navController, animated: true, completion: nil)
            } else {
                SparkService.showAlert(style: .alert, title: "Sign Out Error", message: "Failed to sign out")
            }
        }
    }
    

    fileprivate func setupViews() {
 
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    @IBAction func toCloseMenuSideBar(_ sender: UIButton) {
        closeMenuSideBar()
    }
    
    @IBAction func onClickChats(_ sender: UIButton) {
        moveToChats()
    }
    
    @IBAction func onClickNavigation(_ sender: UIButton) {
        moveToNavigation()
    }
    
    @IBAction func onClickSettings(_ sender: UIButton) {
        moveToSettings()
    }
    
    @IBAction func onClickStatictis(_ sender: UIButton) {
        moveToStatistics()
        closeMenuSideBarMoveToStatistic()
    }
    
    @IBAction func onClickFriendlist(_ sender: UIButton) {
        moveToFriendlist()
        closeMenuSideBarMoveToFriendlist()
    }
    
    
    func showMenuSideBar() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
            self.sideBar.frame.origin.x += self.sideBar.frame.size.width
        }, completion: nil)
    }
    
    func closeMenuSideBar() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
            self.sideBar.frame.origin.x -= self.sideBar.frame.size.width
        }) { completed in
            self.view.removeFromSuperview()
        }
    }
    
    func closeMenuSideBarMoveToStatistic() {
        UIView.animate(withDuration: 0.5, delay: 0.25, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
            self.sideBar.frame.origin.x -= self.sideBar.frame.size.width
            
        }) { completed in
            
            for view in self.view.subviews {
                view.removeFromSuperview()
            }
            //self.removeFromParent()

            let statisticVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sbStatisticsID") as! StatisticsViewController
            self.addChild(statisticVC)
            statisticVC.view.frame = self.view.frame
            self.view.addSubview(statisticVC.view)
            statisticVC.didMove(toParent: self)
        
        }
    }
    
    func closeMenuSideBarMoveToFriendlist() {
        UIView.animate(withDuration: 0.5, delay: 0.25, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
            self.sideBar.frame.origin.x -= self.sideBar.frame.size.width
            
        }) { completed in
            
            for view in self.view.subviews {
                view.removeFromSuperview()
            }
            
            let friendlistVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "viewControllerID") as! ViewController
            self.addChild(friendlistVC)
            friendlistVC.view.frame = self.view.frame
            self.view.addSubview(friendlistVC.view)
            friendlistVC.didMove(toParent: self)
        }
    }
    
    func moveToSettings() {
        UIView.animate(withDuration: 0.5) {
            self.viewMoveMagic.frame.origin.y = self.settingsIcon.frame.origin.y - 13
            self.peopleIcon.tintColor = UIColor(red: CGFloat(79)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(182)/255.0, alpha: 1)
            self.friendListText.textColor = UIColor(red: CGFloat(79)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(182)/255.0, alpha: 1)
            self.settingsIcon.tintColor = .white
            self.controlCenterText.textColor = .white
        }
        self.messageIcon.tintColor = UIColor(red: CGFloat(79)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(182)/255.0, alpha: 1)
        self.chatsText.textColor = UIColor(red: CGFloat(79)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(182)/255.0, alpha: 1)
        self.navigationIcon.tintColor = UIColor(red: CGFloat(79)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(182)/255.0, alpha: 1)
        self.navigationText.textColor = UIColor(red: CGFloat(79)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(182)/255.0, alpha: 1)
        self.statisticsIcon.tintColor = UIColor(red: CGFloat(79)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(182)/255.0, alpha: 1)
        self.statisticsText.textColor = UIColor(red: CGFloat(79)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(182)/255.0, alpha: 1)
    }
    
    func moveToChats() {
        UIView.animate(withDuration: 0.5) {
            self.viewMoveMagic.frame.origin.y = self.messageIcon.frame.origin.y - 12
            self.peopleIcon.tintColor = UIColor(red: CGFloat(79)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(182)/255.0, alpha: 1)
            self.friendListText.textColor = UIColor(red: CGFloat(79)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(182)/255.0, alpha: 1)
            self.messageIcon.tintColor = .white
            self.chatsText.textColor = .white
        }
        self.navigationIcon.tintColor = UIColor(red: CGFloat(79)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(182)/255.0, alpha: 1)
        self.navigationText.textColor = UIColor(red: CGFloat(79)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(182)/255.0, alpha: 1)
        self.settingsIcon.tintColor = UIColor(red: CGFloat(79)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(182)/255.0, alpha: 1)
        self.controlCenterText.textColor = UIColor(red: CGFloat(79)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(182)/255.0, alpha: 1)
        self.statisticsIcon.tintColor = UIColor(red: CGFloat(79)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(182)/255.0, alpha: 1)
        self.statisticsText.textColor = UIColor(red: CGFloat(79)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(182)/255.0, alpha: 1)
    }
    
    func moveToNavigation() {
        UIView.animate(withDuration: 0.5) {
            self.viewMoveMagic.frame.origin.y = self.navigationIcon.frame.origin.y - 10
            self.peopleIcon.tintColor = UIColor(red: CGFloat(79)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(182)/255.0, alpha: 1)
            self.friendListText.textColor = UIColor(red: CGFloat(79)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(182)/255.0, alpha: 1)
            self.navigationIcon.tintColor = .white
            self.navigationText.textColor = .white
        }
        self.messageIcon.tintColor = UIColor(red: CGFloat(79)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(182)/255.0, alpha: 1)
        self.chatsText.textColor = UIColor(red: CGFloat(79)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(182)/255.0, alpha: 1)
        self.settingsIcon.tintColor = UIColor(red: CGFloat(79)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(182)/255.0, alpha: 1)
        self.controlCenterText.textColor = UIColor(red: CGFloat(79)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(182)/255.0, alpha: 1)
        self.statisticsIcon.tintColor = UIColor(red: CGFloat(79)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(182)/255.0, alpha: 1)
        self.statisticsText.textColor = UIColor(red: CGFloat(79)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(182)/255.0, alpha: 1)
    }
    
    func moveToStatistics() {
        UIView.animate(withDuration: 0.25) {
            self.viewMoveMagic.frame.origin.y = self.statisticsIcon.frame.origin.y - 10
            self.peopleIcon.tintColor = UIColor(red: CGFloat(79)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(182)/255.0, alpha: 1)
            self.friendListText.textColor = UIColor(red: CGFloat(79)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(182)/255.0, alpha: 1)
            self.statisticsIcon.tintColor = .white
            self.statisticsText.textColor = .white
        }
        self.messageIcon.tintColor = UIColor(red: CGFloat(79)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(182)/255.0, alpha: 1)
        self.chatsText.textColor = UIColor(red: CGFloat(79)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(182)/255.0, alpha: 1)
        self.settingsIcon.tintColor = UIColor(red: CGFloat(79)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(182)/255.0, alpha: 1)
        self.controlCenterText.textColor = UIColor(red: CGFloat(79)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(182)/255.0, alpha: 1)
        self.navigationIcon.tintColor = UIColor(red: CGFloat(79)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(182)/255.0, alpha: 1)
        self.navigationText.textColor = UIColor(red: CGFloat(79)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(182)/255.0, alpha: 1)
    }
    
    func moveToFriendlist() {
        UIView.animate(withDuration: 0.25) {
            self.viewMoveMagic.frame.origin.y = self.peopleIcon.frame.origin.y - 13
            self.peopleIcon.tintColor = .white
            self.friendListText.textColor = .white
        }
        self.messageIcon.tintColor = UIColor(red: CGFloat(79)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(182)/255.0, alpha: 1)
        self.chatsText.textColor = UIColor(red: CGFloat(79)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(182)/255.0, alpha: 1)
        self.settingsIcon.tintColor = UIColor(red: CGFloat(79)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(182)/255.0, alpha: 1)
        self.controlCenterText.textColor = UIColor(red: CGFloat(79)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(182)/255.0, alpha: 1)
        self.navigationIcon.tintColor = UIColor(red: CGFloat(79)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(182)/255.0, alpha: 1)
        self.navigationText.textColor = UIColor(red: CGFloat(79)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(182)/255.0, alpha: 1)
        self.statisticsIcon.tintColor = UIColor(red: CGFloat(79)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(182)/255.0, alpha: 1)
        self.statisticsText.textColor = UIColor(red: CGFloat(79)/255.0, green: CGFloat(138)/255.0, blue: CGFloat(182)/255.0, alpha: 1)
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
