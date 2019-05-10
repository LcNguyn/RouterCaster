//
//  ShowFriendRouteLocationViewController.swift
//  MainCode
//
//  Created by Apple on 5/4/19.
//  Copyright © 2019 Kien. All rights reserved.
//

import UIKit


class FriendRouteLocationList {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}

class ShowFriendRouteLocationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var segmentsView: UISegmentedControl!
    @IBOutlet weak var friendTableView: UITableView!
    @IBOutlet weak var friendLocationTableView: UITableView!
    
    var friendRouteLocationListArray: [FriendRouteLocationList] = []
    var friendLocationListArray: [FriendRouteLocationList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpFriendList()
        setUpFriendLocationList()

        self.view.backgroundColor = UIColor.init(displayP3Red: 0, green: 0, blue: 0, alpha: 0.0)
        // Do any additional setup after loading the view.
    }
    
    private func setUpFriendList() {
        friendRouteLocationListArray.append(FriendRouteLocationList(name: "Bella Nguyen", image: "BellaImage"))
        friendRouteLocationListArray.append(FriendRouteLocationList(name: "Thao Nguyen", image: "ThaoImage"))
        friendRouteLocationListArray.append(FriendRouteLocationList(name: "Vladimir", image: "VladimirImage"))
    }
    
//    private func setUpFriendLocationList() {
//        friendRouteLocationListArray.append(FriendRouteLocationList(name: "Bella Nguyen", image: "BellaImage"))
//        friendRouteLocationListArray.append(FriendRouteLocationList(name: "Thao Nguyen", image: "ThaoImage"))
//        friendRouteLocationListArray.append(FriendRouteLocationList(name: "Vladimir", image: "VladimirImage"))
//        friendRouteLocationListArray.append(FriendRouteLocationList(name: "Bear", image: "BearImage"))
//        friendRouteLocationListArray.append(FriendRouteLocationList(name: "Bella Tran", image: "BellaTranImage"))
//    }
    
    private func setUpFriendLocationList() {
        friendLocationListArray.append(FriendRouteLocationList(name: "Bella Nguyen", image: "BellaImage"))
        friendLocationListArray.append(FriendRouteLocationList(name: "Thao Nguyen", image: "ThaoImage"))
        friendLocationListArray.append(FriendRouteLocationList(name: "Vladimir", image: "VladimirImage"))
        friendLocationListArray.append(FriendRouteLocationList(name: "Bear", image: "BearImage"))
        friendLocationListArray.append(FriendRouteLocationList(name: "Bella Tran", image: "BellaTranImage"))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == friendTableView {
            return friendRouteLocationListArray.count
        } else {
            return friendLocationListArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == friendTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "friendRouteLocationCell", for: indexPath) as! FriendRouteLocationCell
            cell.imageProfile.image = UIImage(named: friendRouteLocationListArray[indexPath.row].image)
            cell.label.text = friendRouteLocationListArray[indexPath.row].name
            cell.checkBox.addTarget(self, action: #selector(checkBoxButtonClicked(sender:)), for: .touchUpInside)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "friendLocationCell", for: indexPath) as! FriendLocationCell
            cell.imageProfile.image = UIImage(named: friendLocationListArray[indexPath.row].image)
            cell.label.text = friendLocationListArray[indexPath.row].name
            cell.checkBox.addTarget(self, action: #selector(checkBoxLocationButtonClicked(sender:)), for: .touchUpInside)
            return cell

        }
    }
    
    @objc func checkBoxButtonClicked( sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
        } else {
            sender.isSelected = true
        }
        friendTableView.reloadData()
    }
    
    @objc func checkBoxLocationButtonClicked( sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
        } else {
            sender.isSelected = true
        }
        friendTableView.reloadData()
    }
    
    
    @IBAction func onClickSegments(_ sender: UISegmentedControl) {
//        if segmentsView.selectedSegmentIndex == 0 {
//            friendRouteLocationListArray = []
//            setUpFriendList()
//            friendTableView.reloadData()
//        } else {
//            friendRouteLocationListArray = []
//            setUpFriendLocationList()
//            friendTableView.reloadData()
//        }
        if segmentsView.selectedSegmentIndex == 0 {
            friendTableView.isHidden = false
            friendLocationTableView.isHidden = true
        } else {
            friendTableView.isHidden = true
            friendLocationTableView.isHidden = false
        }
    }
    
    @IBAction func hideTabBar(_ sender: UIButton) {
        removeAnimate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showAnimate()
    }
    
    func showAnimate() {
        self.view.transform = CGAffineTransform(translationX: 0.5, y: 0.5)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 1.0) {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(translationX: 1.0, y: 1.0)
        }
    }
    
    func removeAnimate() {
        UIView.animate(withDuration: 1.0, animations: {
            self.view.transform = CGAffineTransform(translationX: 0.5, y: 0.5)
            self.view.alpha = 0.0
        }) { completed in
            self.view.removeFromSuperview()
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
