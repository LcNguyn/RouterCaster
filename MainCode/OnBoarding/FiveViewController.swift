//
//  FiveViewController.swift
//  MainCode
//
//  Created by Apple on 5/12/19.
//  Copyright © 2019 Kien. All rights reserved.
//

import UIKit

class FiveViewController: UIViewController {
    @IBOutlet weak var arrowUpView: UIView!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var firstHiddenView: UIView!
    @IBOutlet weak var colorTableView: UIView!
    @IBOutlet weak var arrowDownView: UIView!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var theme: UIImageView!
    @IBOutlet weak var ThirdLabel: UILabel!
    @IBOutlet weak var roundClick: UIView!
    @IBOutlet weak var handClick: UIView!
    @IBOutlet weak var finalView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.alpha = 0
        self.view.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        
        
        showFiveVC()
        showArrowUAndFirstLabel()
    }

    @IBAction func onClickImage(_ sender: UIButton) {
        hiddenArrowUFirstLabelAndShowTableColor()
    }
    
    @IBAction func onClickColorTable(_ sender: UIButton) {
        hiddenEverything()
    }
    
    @IBAction func didTapMove(_ sender: UIButton) {
        for view in self.view.subviews {
            view.removeFromSuperview()
        }
        let sixVC = UIStoryboard(name: "OnBoarding", bundle: nil).instantiateViewController(withIdentifier: "sbSixViewID") as! SixViewController
        self.addChild(sixVC)
        sixVC.view.frame = self.view.frame
        self.view.addSubview(sixVC.view)
        sixVC.didMove(toParent: self)
    }
    
    
    func showFiveVC() {
        UIView.animate(withDuration: 0.2) {
            self.view.alpha = 1
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
    
    func showArrowUAndFirstLabel(){
        self.arrowUpView.alpha = 0
        self.firstLabel.alpha = 0
        self.arrowUpView.frame.origin.y += self.view.frame.size.height / 20
        self.firstLabel.frame.origin.y += self.view.frame.size.height / 20
        UIView.animate(withDuration: 1.0, delay: 0.2, options: [], animations: {
            self.arrowUpView.alpha = 1
            self.firstLabel.alpha = 1
            self.arrowUpView.frame.origin.y -= self.view.frame.size.height / 20
            self.firstLabel.frame.origin.y -= self.view.frame.size.height / 20
        }, completion: nil)
    }
    
    func hiddenArrowUFirstLabelAndShowTableColor() {
        self.arrowUpView.isHidden = true
        self.firstLabel.isHidden = true
        self.firstHiddenView.isHidden = false
        self.colorTableView.isHidden = false
        self.arrowDownView.isHidden = false
        self.secondLabel.isHidden = false
        self.colorTableView.alpha = 0
        self.arrowDownView.alpha = 0
        self.secondLabel.alpha = 0
        self.colorTableView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        self.arrowDownView.frame.origin.y -= self.view.frame.size.height / 20
        self.secondLabel.frame.origin.y -= self.view.frame.size.height / 20
        UIView.animate(withDuration: 1.0, delay: 0, options: [], animations: {
            self.colorTableView.alpha = 1
            self.arrowDownView.alpha = 1
            self.secondLabel.alpha = 1
            self.colorTableView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.arrowDownView.frame.origin.y += self.view.frame.size.height / 20
            self.secondLabel.frame.origin.y += self.view.frame.size.height / 20
        }, completion: nil)
    }
    
    func hiddenEverything() {
        UIView.animate(withDuration: 1.0, delay: 0, options: [], animations: {
            self.colorTableView.alpha = 0
            self.arrowDownView.alpha = 0
            self.secondLabel.alpha = 0
        }) { completed in
            UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
                self.colorTableView.isHidden = true
                self.arrowDownView.isHidden = true
                self.secondLabel.isHidden = true
                self.theme.isHidden = true
            }, completion: { completed in
                self.ThirdLabel.isHidden = false
                self.roundClick.isHidden = false
                self.handClick.isHidden = false
                self.ThirdLabel.alpha = 0
                self.ThirdLabel.frame.origin.y += self.view.frame.size.height / 20
                UIView.animate(withDuration: 1.0, delay: 0, options: [], animations: {
                    self.ThirdLabel.alpha = 1
                    self.ThirdLabel.frame.origin.y -= self.view.frame.size.height / 20
                }, completion: { completed in
                    self.showRoundClickIn()
                    self.showHandClickIn()
                    self.finalView.isHidden = false
                })
            })
        }
    }
    
    func showRoundClickIn() {
        UIView.animate(withDuration: 1.0, delay: 0.15, options: [.repeat], animations: {
            self.roundClick.alpha = 0
            self.roundClick.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }, completion: nil)
    }
    
    func showHandClickIn() {
        UIView.animate(withDuration: 1.0, delay: 0, options: [.repeat], animations: {
            //            self.handClickView.alpha = 0
            self.handClick.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }, completion: nil)
    }
}
