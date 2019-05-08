//
//  ChangePasswordViewController.swift
//  Setting
//
//  Created by tang quang an on 5/8/19.
//  Copyright © 2019 Setting. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {

    @IBOutlet weak var btnSavePassword: UIButton!
    @IBOutlet weak var currentPasswordLb: UITextField!
    
    @IBOutlet weak var newPasswordLb: UITextField!
    @IBOutlet weak var confirmPasswordLb: UITextField!
    
    @IBAction func didPressSavePassword(_ sender: UIButton) {
        
    }
    @IBOutlet weak var showCurrentPasswordBtn: UIButton!
    
    var longGesture: UILongPressGestureRecognizer?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(ChangePasswordViewController.handleLongPress(_:)))
        longPressGestureRecognizer.minimumPressDuration = 1
        showCurrentPasswordBtn.addGestureRecognizer(longPressGestureRecognizer)
        
//        longGesture = UILongPressGestureRecognizer(target: self, action: #selector(ChangePasswordViewController.longPress(_:)))
//        longGesture!.minimumPressDuration = 0
//        testView.addGestureRecognizer(longGesture!)
    }
    @IBOutlet var testView: UIView!
    
    @objc func longPress(_ sender: UILongPressGestureRecognizer) {
        
        print("AAAAAAAAA")
    }
    
    @objc func handleLongPress(_ sender: UILongPressGestureRecognizer) {
        
       
        if (sender.state == .ended) {
            print("BBBBBBB")
        }
        // do something
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
