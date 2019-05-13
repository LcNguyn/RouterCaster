//
//  SecondViewController.swift
//  MainCode
//
//  Created by Apple on 5/10/19.
//  Copyright © 2019 Kien. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var roundClickView: UIView!
    @IBOutlet weak var handClickView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.alpha = 0
        self.view.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        
        showSecondVC()
        showHandClickIn()
        showRoundClickIn()
    }
    
    @IBAction func didTapMove(_ sender: UIButton) {
        for view in self.view.subviews {
            view.removeFromSuperview()
        }
        let thirdVC = UIStoryboard(name: "OnBoarding", bundle: nil).instantiateViewController(withIdentifier: "sbThirdViewID") as! ThirdViewController
        self.addChild(thirdVC)
        thirdVC.view.frame = self.view.frame
        self.view.addSubview(thirdVC.view)
        thirdVC.didMove(toParent: self)
    }
    
    func showSecondVC() {
        UIView.animate(withDuration: 0.2) {
            self.view.alpha = 1
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
    
    func showRoundClickIn() {
        UIView.animate(withDuration: 1.0, delay: 0.15, options: [.repeat], animations: {
            self.roundClickView.alpha = 0
            self.roundClickView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }, completion: nil)
    }
    
    func showHandClickIn() {
        UIView.animate(withDuration: 1.0, delay: 0, options: [.repeat], animations: {
//            self.handClickView.alpha = 0
            self.handClickView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }, completion: nil)
    }

}
