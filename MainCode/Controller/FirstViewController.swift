//
//  FirstViewController.swift
//  MainCode
//
//  Created by Apple on 5/10/19.
//  Copyright © 2019 Kien. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var nameLogo: UIView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var processView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logoImage.alpha = 0
        nameLogo.alpha = 0
        logoImage.frame.origin.x -= 50
        
        self.view.alpha = 0
        self.view.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        self.loadingView.alpha = 0
        self.loadingView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        
        self.processView.frame.size.width -= 167
        
        showFirstVC()
        showLogoIn()
        showLogoNameIn()
        showProcessIn()
        
        // Do any additional setup after loading the view.
    }
    
    func showFirstVC() {
        UIView.animate(withDuration: 0.2) {
            self.view.alpha = 1
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
    

    
    func showLogoIn() {
        UIView.animate(withDuration: 2.0) {
            self.logoImage.alpha = 1
            self.logoImage.frame.origin.x += 50
        }
    }
    
    func showLogoNameIn() {
        self.nameLogo.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 2.0, delay: 0.75, options: [.curveEaseInOut], animations: {
            self.nameLogo.alpha = 1
            self.nameLogo.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }) { completed in
            self.showLoadingViewIn()
        }
    }
    
    func showLoadingViewIn() {
        UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
            self.loadingView.alpha = 1
            self.loadingView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: nil)
    }
    
    func showProcessIn() {
        UIView.animate(withDuration: 2.0, delay: 3.0, options: [], animations: {
            self.processView.frame.size.width += 167
        }) { completed in
            for view in self.view.subviews {
                view.removeFromSuperview()
            }
            let getstartedVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sbGetStartedID") as! SwipingController
            self.addChild(getstartedVC)
            getstartedVC.view.frame = self.view.frame
            self.view.addSubview(getstartedVC.view)
            getstartedVC.didMove(toParent: self)

        }
    }
    
    
    
    
}


