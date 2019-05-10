//
//  ShareRouteViewController.swift
//  MainCode
//
//  Created by Apple on 5/4/19.
//  Copyright © 2019 Kien. All rights reserved.
//

import UIKit

class ShareRouteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func showRouteLocation(_ sender: UIButton) {
        let showFriendRouteLocationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sbShowFriendRouteLocation") as! ShowFriendRouteLocationViewController
        self.addChild(showFriendRouteLocationVC)
        showFriendRouteLocationVC.view.frame = self.view.frame
        self.view.addSubview(showFriendRouteLocationVC.view)
        showFriendRouteLocationVC.didMove(toParent: self)
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
