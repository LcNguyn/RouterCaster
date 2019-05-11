//
//  SecuritySettingViewController.swift
//  Setting
//
//  Created by tang quang an on 5/8/19.
//  Copyright © 2019 Setting. All rights reserved.
//

import UIKit

class SecuritySettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Check account type here
        
//        changePasswordBtn.isEnabled = false
//        let overlayView = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: self.changePasswordView.frame.size))
//        overlayView.backgroundColor = UIColor(red:0.00, green:0.00, blue:0.00, alpha:0.2)
//        overlayView.cornerRadius = 5
//        changePasswordView.addSubview(overlayView)
        
    }
    
    @IBOutlet weak var changePasswordView: UIView!
    @IBOutlet weak var changePasswordBtn: UIButton!
    @IBAction func didPressBack(_ sender: UIButton) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        self.dismiss(animated: false) {
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
