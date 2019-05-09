//
//  LocationSharingViewController.swift
//  Setting
//
//  Created by tang quang an on 5/9/19.
//  Copyright © 2019 Setting. All rights reserved.
//

import UIKit

class LocationSharingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    class LocationSharingFriend {
        var name: String
        var image: UIImage
        var isSelected: Bool
        
        init(name: String, image: String, isSelected: Bool) {
            self.name = name
            self.image = UIImage(named: image)!
            self.isSelected = isSelected
        }
    }
    
    var locationSharingArray: [LocationSharingFriend] = [
    
        LocationSharingFriend(name: "Thao Nguyen", image: "ThaoImage", isSelected: true),
        
        LocationSharingFriend(name: "Linh Nguyen", image: "ThaoImage", isSelected: false)
        
    ]
    
//    var data: [String] = ["Thao Nguyen", "Linh Nguyen"]
//    var images: [UIImage] = [UIImage(named: "ThaoImage")!,
//                             UIImage(named: "ThaoImage")!]
    
    
    @IBOutlet weak var LocationSharingSw: UISwitch!
    @IBOutlet weak var hideFriendListView: UIView!
    
    @IBOutlet weak var markAllBtn: UIButton!
    
    @IBAction func didPressMarkAll(_ sender: Any) {
        
        for (i, _) in locationSharingArray.enumerated() {
            self.friendList.selectRow(at: IndexPath.init(row: i, section: 0), animated: true, scrollPosition: UITableView.ScrollPosition.middle)
        }
    }
    
    @IBAction func didChangeLocationSharing(_ sender: UISwitch) {
        
        if (sender.isOn) {
            markAllBtn.isHidden = false
            hideFriendListView.isHidden = true
        } else {
            markAllBtn.isHidden = true
            hideFriendListView.isHidden = false
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationSharingArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        cell.label.text = locationSharingArray[indexPath.row].name
        cell.imageProfile.image = locationSharingArray[indexPath.row].image
        return cell
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Load the location sharing state from the user
        LocationSharingSw.setOn(true, animated: false)
        friendList.delegate = self
        friendList.dataSource = self
        friendList.isEditing = true
        
        // Check for location sharing
        if (LocationSharingSw.isOn) {
            markAllBtn.isHidden = false
            hideFriendListView.isHidden = true
        } else {
            markAllBtn.isHidden = true
            hideFriendListView.isHidden = false
        }
        friendList.allowsMultipleSelectionDuringEditing = true
        
        // Load for user previous selection
        for (i, selectedFriend) in locationSharingArray.enumerated() {
            if (selectedFriend.isSelected) {
                self.friendList.selectRow(at: IndexPath.init(row: i, section: 0), animated: true, scrollPosition: UITableView.ScrollPosition.middle)
            }
        }
        
        
    }
    
    @IBOutlet weak var friendList: UITableView!
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
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
