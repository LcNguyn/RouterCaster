//
//  ShareRouteViewController.swift
//  UITest
//
//  Created by tang quang an on 4/29/19.
//  Copyright © 2019 tang quang an. All rights reserved.
//

import UIKit


class ShareRouteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    // Test data
    var data: [String] = ["Thao Nguyen", "Linh Nguyen", "Bella Nguyen", "Vladimir", "Bear", "Bella Tran"]
    var images: [UIImage] = [UIImage(named: "GPS_Button")!,
                             UIImage(named: "GPS_Button")!,
                             UIImage(named: "GPS_Button")!,
                             UIImage(named: "GPS_Button")!,
                             UIImage(named: "GPS_Button")!,
                             UIImage(named: "GPS_Button")!]
    
    
    @IBOutlet weak var friendList: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        cell.label.text = data[indexPath.row]
        cell.imageProfile.image = images[indexPath.row]
        return cell
    }

    @IBAction func didPressDone(_ sender: UIButton) {
        
        if let selectedRows = friendList.indexPathsForSelectedRows {
            // 1
            var items = [String]()
            for indexPath in selectedRows  {
                items.append(data[indexPath.row])
            }
            // 2
            for item in items {
                if let index = data.index(of: item) {
                    // Code somthing here to apply to the database
                }
            }
        }
        
        self.removeAnimate()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.init(displayP3Red: 0, green: 0, blue: 0, alpha: 0.1)
        
        self.showAnimate()
        
        friendList.delegate = self
        friendList.dataSource = self
        friendList.isEditing = true
        friendList.allowsMultipleSelectionDuringEditing = true
        
    }
    
    func showAnimate() {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25) {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
    
    func removeAnimate() {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
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
