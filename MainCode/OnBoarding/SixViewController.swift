//
//  SixViewController.swift
//  MainCode
//
//  Created by Apple on 5/12/19.
//  Copyright © 2019 Kien. All rights reserved.
//

import UIKit

class SixViewController: UIViewController {
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var mainTheme: UIImageView!
    @IBOutlet weak var searchRoute: UIView!
    @IBOutlet weak var arrowUView: UIView!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var hiddenSearchRoute: UIView!
    @IBOutlet weak var searchLabel: UILabel!
    @IBOutlet weak var searchTableView: UIView!
    @IBOutlet weak var arrowUTwoView: UIView!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var finalButtonView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.alpha = 0
        self.view.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        
        
        showSixVC()
        showArrowUAndFirstLabel()
    }
    
    @IBAction func onClickSearchRoute(_ sender: UIButton) {
        hiddenSearchRouteArrowUFirstLabelAndShowTableRoute()
    }
    
    @IBAction func onClickToChoosePlace(_ sender: UIButton) {
        for view in self.view.subviews {
            view.removeFromSuperview()
        }
        let sevenVC = UIStoryboard(name: "OnBoarding", bundle: nil).instantiateViewController(withIdentifier: "sbSevenViewID") as! SevenViewController
        self.addChild(sevenVC)
        sevenVC.view.frame = self.view.frame
        self.view.addSubview(sevenVC.view)
        sevenVC.didMove(toParent: self)
    }
    
    func showSixVC() {
        UIView.animate(withDuration: 0.2) {
            self.view.alpha = 1
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
    
    func showArrowUAndFirstLabel() {
        self.arrowUView.alpha = 0
        self.firstLabel.alpha = 0
        self.arrowUView.frame.origin.y += self.view.frame.size.height / 20
        self.firstLabel.frame.origin.y += self.view.frame.size.height / 20
        UIView.animate(withDuration: 1.0, delay: 0.2, options: [], animations: {
            self.arrowUView.alpha = 1
            self.firstLabel.alpha = 1
            self.arrowUView.frame.origin.y -= self.view.frame.size.height / 20
            self.firstLabel.frame.origin.y -= self.view.frame.size.height / 20
        }, completion: nil)
    }
    
    func hiddenSearchRouteArrowUFirstLabelAndShowTableRoute() {
        UIView.animate(withDuration: 1.0, delay: 0, options: [], animations: {
            self.arrowUView.alpha = 0
            self.firstLabel.alpha = 0
        }) { completed in
            self.arrowUView.isHidden = true
            self.firstLabel.isHidden = true
            self.hiddenSearchRoute.isHidden = false
            self.searchLabel.text = "Apple Union S"
            self.searchTableView.isHidden = false
            self.searchTableView.alpha = 0
            self.searchTableView.frame.origin.y += self.view.frame.size.height / 20
            UIView.animate(withDuration: 1.0, delay: 0, options: [], animations: {
                self.searchTableView.alpha = 1
                self.searchTableView.frame.origin.y -= self.view.frame.size.height / 20
            }, completion: { completed in
                self.arrowUTwoView.isHidden = false
                self.secondLabel.isHidden = false
                self.arrowUTwoView.alpha = 0
                self.secondLabel.alpha = 0
                self.arrowUTwoView.frame.origin.y += self.view.frame.size.height / 20
                self.secondLabel.frame.origin.y += self.view.frame.size.height / 20
                UIView.animate(withDuration: 1.0, delay: 0, options: [], animations: {
                    self.arrowUTwoView.alpha = 1
                    self.secondLabel.alpha = 1
                    self.arrowUTwoView.frame.origin.y -= self.view.frame.size.height / 20
                    self.secondLabel.frame.origin.y -= self.view.frame.size.height / 20
                }, completion: { completed in
                    self.finalButtonView.isHidden = false
                })
            })
        }
    }
    
}
