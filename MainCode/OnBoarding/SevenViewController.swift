//
//  SevenViewController.swift
//  MainCode
//
//  Created by Apple on 5/12/19.
//  Copyright © 2019 Kien. All rights reserved.
//

import UIKit

class SevenViewController: UIViewController {
    @IBOutlet weak var boxView: UIView!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var arrowLeft: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.alpha = 0
        self.view.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        
        
        showSevenVC()
        showBoxViewIn()
    }
    
    @IBAction func onClickDirection(_ sender: UIButton) {
        for view in self.view.subviews {
            view.removeFromSuperview()
        }
        let eightVC = UIStoryboard(name: "OnBoarding", bundle: nil).instantiateViewController(withIdentifier: "sbEightViewID") as! EightViewController
        self.addChild(eightVC)
        eightVC.view.frame = self.view.frame
        self.view.addSubview(eightVC.view)
        eightVC.didMove(toParent: self)
    }
    
    func showSevenVC() {
        UIView.animate(withDuration: 0.2) {
            self.view.alpha = 1
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
    
    func showBoxViewIn() {
        self.arrowLeft.alpha = 0
        self.firstLabel.alpha = 0
        self.arrowLeft.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        self.firstLabel.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        self.boxView.alpha = 0
        self.boxView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        UIView.animate(withDuration: 1.0, delay: 0.2, options: [], animations: {
            self.boxView.alpha = 1
            self.boxView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }) { completed in
            UIView.animate(withDuration: 1.0, delay: 0, options: [], animations: {
                self.arrowLeft.alpha = 1
                self.firstLabel.alpha = 1
                self.arrowLeft.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self.firstLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: { completed in
                self.showFirstLabelIn()
                self.showArrowLeftIn()
            })
        }
    }
    
    func showFirstLabelIn() {
        UIView.animate(withDuration: 0.5, delay: 0.2, options: [.repeat], animations: {
            self.firstLabel.alpha = 0
            self.firstLabel.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }, completion: nil)
    }
    
    func showArrowLeftIn() {
        self.arrowLeft.frame.origin.x += self.view.frame.size.width / 20
        UIView.animate(withDuration: 0.5, delay: 0.2, options: [.repeat, .autoreverse], animations: {
            self.arrowLeft.frame.origin.x -= self.view.frame.size.width / 20
        }, completion: nil)
    }
}
