//
//  ViewController.swift
//  MainCode
//
//  Created by Apple on 4/22/19.
//  Copyright © 2019 Kien. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import JGProgressHUD
import SwiftyJSON
import FirebaseStorage
import Dwifft
//class Person {
//    var name: String = ""
//    var image: UIImage
//
//    init(name: String, image: UIImage) {
//
//    }
//}

@IBDesignable
class DesignableView: UIView {
}

@IBDesignable
class DesignableButton: UIButton {
}

@IBDesignable
class DesignableLabel: UILabel {
}

extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
}

class FriendList {
    var name: String
    var image: String
    var uid: String
    init(name: String, image: String, uid : String) {
        self.uid = uid
        self.name = name
        self.image = image
    }
}



class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let hud: JGProgressHUD = {
        let hud = JGProgressHUD(style: .light)
        hud.interactionType = .blockAllTouches
        return hud
    }()
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var listTableView: UITableView!
    var friendListArray = [FriendList]()
    var searchString: [FriendList] = []
    var deleteSearchString: [FriendList] = []
    var addFriendListArray: [FriendList] = []
    var searchAddFriendString: [FriendList] = []
    var users = [User]()
    var searching = false
    var deleteSearching = false
    
    func combineTwoArray(indexPathRow: Int) {
        
        friendListArray = friendListArray.filter({ friendList -> Bool in
            !friendList.uid.contains("\(searchString[indexPathRow].uid)")
        })

    }
    
    private func fetchAllUsers() {
        Firestore.firestore().collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                   let user = User()
                   self.users.append(user)
//                    print("\(document.documentID) => \(document.data())")
                    let userdata = document.data()
                    user.email = userdata["email"] as? String
                    user.name = userdata["name"] as? String
                    user.uid = userdata["uid"] as? String
                    user.profileImageUrl = userdata["profileImageUrl"] as? String
                    print(user.profileImageUrl as Any)
                    print(user.name as Any)
                   
                    self.friendListArray.append(FriendList(name: user.name! , image: user.profileImageUrl!, uid: user.uid!))
                    self.addFriendListArray.append(FriendList(name: user.name!, image: user.profileImageUrl!, uid: user.uid!))
                    //this will crash because of background thread, so lets use dispatch_async to fix
                    DispatchQueue.main.async(execute: {
                        self.listTableView.reloadData()
                    })
                        
                   
                    }
               
                
                var indexPathsToReload = [IndexPath]()
                for index in self.friendListArray.indices {
                    let indexPath = IndexPath(row: index, section: 0)
                    indexPathsToReload.append(indexPath)
                }
                print("bug here")
                for u in self.friendListArray {
                    print("email")
                    print(u.name)
                }
                self.listTableView.reloadData()
//                 DispatchQueue.main.async {
//                    self.listTableView.reloadRows(at: indexPathsToReload, with: .fade)}
            }
        }

    }
    // Mark: -
    // Mark: Fetch users profile img
 
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if searching == true {
                return searchString.count
            }
            else if searching == false && deleteSearching == true {
                return friendListArray.count
            }
            else {
                return friendListArray.count
            }
        } else {
            if searching == true {
                return searchAddFriendString.count
            } else {
                return 0
            }
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell

            if searching == true {
                DispatchQueue.main.async(execute: {
                 
                    cell.label.text = self.searchString[indexPath.row].name
                    let profileUrl = self.searchString[indexPath.row].image
                    cell.imageProfile.loadImageUsingCacheWithUrlString(profileUrl)})
                print("reload1")
            }
            else if searching == false && deleteSearching == true {
              
                DispatchQueue.main.async(execute: {
                    cell.label.text = self.friendListArray[indexPath.row].name
                    let profileUrl = self.friendListArray[indexPath.row].image
                    cell.imageProfile.loadImageUsingCacheWithUrlString(profileUrl)})
            }
            else {
                DispatchQueue.main.async(execute: {
                    cell.label.text = self.friendListArray[indexPath.row].name
                    let profileUrl = self.friendListArray[indexPath.row].image
                    cell.imageProfile.loadImageUsingCacheWithUrlString(profileUrl)}
                )
                
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "addFriendCell", for: indexPath) as! AddFriendCell
            if searching == true {
                cell.label.text = searchString[indexPath.row].name
                let profileUrl = self.searchString[indexPath.row].image
                cell.imageProfile.loadImageUsingCacheWithUrlString(profileUrl)

            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
//        deleteSearching = true
        
        let unfriend = UIContextualAction(style: .destructive, title: "Unfriend") { (action, view, completionHandler) in
//            self.friendListArray.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//            completionHandler(true)
            if self.searching == true {
                print("\(indexPath.row)")
 
                let uid = self.searchString[indexPath.row].uid
                //self.friendListArray.remove(at: indexPath.row)
//                tableView.deleteRows(at: [indexPath], with: .fade)
//                completionHandler(true)
//                self.searchBar.text = ""
//                self.searching = false
//                self.deleteSearching = true
//                self.listTableView.reloadData()
                Firestore.firestore().collection("users").whereField("uid", isEqualTo: uid).getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        DispatchQueue.main.async {
                            self.combineTwoArray(indexPathRow: indexPath.row)
                            self.searchString.remove(at: indexPath.row)
                            //self.users.remove(at: indexPath.row)
                            print(uid)
                            print(indexPath.row)
                            //self.friendListArray.remove(at: indexPath.row)
                            //tableView.deleteRows(at: [indexPath], with: .fade)
                            completionHandler(true)
                            self.searchBar.text = ""
                            self.searching = false
                            self.deleteSearching = true
                            self.listTableView.reloadData()
                            for document in querySnapshot!.documents {
                                document.reference.delete()
                            }
                        }
                        
                    }
                }
                
           
            } else {
                let uid = self.friendListArray[indexPath.row].uid
                self.friendListArray.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                completionHandler(true)
                Firestore.firestore().collection("users").whereField("uid", isEqualTo: uid).getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        DispatchQueue.main.async {
                        for document in querySnapshot!.documents {
                            document.reference.delete()
                        }
                    
                        }}
                }
             
            }
        }
        return UISwipeActionsConfiguration(actions: [unfriend])
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllUsers()
//        setUpFriendList()
//        setUpAddFriendList()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
//    private func setUpFriendList() {
//        friendListArray.append(FriendList(name: "Thao Nguyen", image: "ThaoImage"))
//        friendListArray.append(FriendList(name: "Linh Nguyen", image: "LinhImage"))
//        friendListArray.append(FriendList(name: "Bella Nguyen", image: "BellaImage"))
//        friendListArray.append(FriendList(name: "Vladimir", image: "VladimirImage"))
//        friendListArray.append(FriendList(name: "Bear", image: "BearImage"))
//        friendListArray.append(FriendList(name: "Bella Tran", image: "BellaTranImage"))
//    }
//    
//    private func setUpAddFriendList() {
//        addFriendListArray.append(FriendList(name: "Thao Le", image: "ThaoLeImage"))
//        addFriendListArray.append(FriendList(name: "Nguyen Lam Thao", image: "NguyenLamThaoImage"))
//        addFriendListArray.append(FriendList(name: "Le Thao", image: "LeThaoImage"))
//        addFriendListArray.append(FriendList(name: "Tran Le Thao", image: "TranLeThaoImage"))
//        addFriendListArray.append(FriendList(name: "Nguyen Le Thao", image: "NguyenLeThaoImage"))
//    }

    @IBAction func requestPopup(_ sender: Any) {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sbPopUpID") as! PopUpViewController
        self.addChild(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
    }
    
    
    @IBAction func menuSideBar(_ sender: UIButton) {
        let menuSideBarVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sbSideBarID") as! MenuSideBarViewController
        self.addChild(menuSideBarVC)
        menuSideBarVC.view.frame = self.view.frame
        self.view.addSubview(menuSideBarVC.view)
        menuSideBarVC.didMove(toParent: self)
    }
    

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //Fire animations
        
    }
    
//    func showMainMenu() {
//        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
//            self.mainView.frame.origin.x += self.mainView.frame.origin.x
//        }, completion: nil)
//    }
    
}

extension ViewController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        searchString = friendListArray.filter({$0.name.prefix(searchText.count) == searchText})
//        searching = true
//        listTableView.reloadData()
//    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            searching = false
            view.endEditing(true)
            listTableView.reloadData()
        } else {
            searching = true
//            searchString = friendListArray.filter({ friendList -> Bool in
//                friendList.name.contains(searchText)
//            })
            searchString = friendListArray.filter({$0.name.lowercased().prefix(searchText.count) == searchText.lowercased()})
            searchAddFriendString = addFriendListArray.filter({$0.name.lowercased().prefix(searchText.count) == searchText.lowercased()})
//            searchAddFriendString = addFriendListArray.filter({ addFriendList -> Bool in
//                addFriendList.name.lowercased().contains(searchText.lowercased())
//            })
            listTableView.reloadData()
        }
    }
}
