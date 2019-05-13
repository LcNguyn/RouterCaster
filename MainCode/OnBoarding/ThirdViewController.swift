//
//  ThirdViewController.swift
//  MainCode
//
//  Created by Apple on 5/11/19.
//  Copyright © 2019 Kien. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    @IBOutlet weak var arrowHorizontal: UIView!
    @IBOutlet weak var arrowVertical: UIView!
    
    @IBOutlet weak var tapText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.alpha = 0
        self.view.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        
        
        showThirdVC()
        showArrowHorizontalIn()
        showArrowVerticalIn()
        showTapIn()
    }

    func showThirdVC() {
        UIView.animate(withDuration: 0.2) {
            self.view.alpha = 1
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
    
    @IBAction func didTapMove(_ sender: UIButton) {
        for view in self.view.subviews {
            view.removeFromSuperview()
        }
        let fourVC = UIStoryboard(name: "OnBoarding", bundle: nil).instantiateViewController(withIdentifier: "sbFourViewID") as! FourViewController
        self.addChild(fourVC)
        fourVC.view.frame = self.view.frame
        self.view.addSubview(fourVC.view)
        fourVC.didMove(toParent: self)
    }
    
    func showArrowHorizontalIn() {
        UIView.animate(withDuration: 1.0, delay: 0.2, options: [.repeat, .autoreverse], animations: {
            self.arrowHorizontal.frame.origin.x += self.view.frame.size.width / 10
        }, completion: nil)
        
    }
    
    func showArrowVerticalIn() {
        UIView.animate(withDuration: 1.0, delay: 0.2, options: [.repeat, .autoreverse], animations: {
            self.arrowVertical.frame.origin.y += self.view.frame.size.height / 10
        }, completion: nil)
    }
    
    func showTapIn() {
        UIView.animate(withDuration: 1.0, delay: 0.2, options: [.repeat], animations: {
            self.tapText.alpha = 0
            self.tapText.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }, completion: nil)
    }

}
