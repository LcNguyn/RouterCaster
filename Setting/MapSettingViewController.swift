//
//  MapSettingViewController.swift
//  Setting
//
//  Created by tang quang an on 5/7/19.
//  Copyright © 2019 Setting. All rights reserved.
//

import UIKit
import DLRadioButton

class MapSettingViewController: UIViewController {

    @IBAction func didPressBack(_ sender: Any) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        self.dismiss(animated: false) {
        }
        
    }
    
    
    @IBAction func didChangeDistanceMetrics(_ sender: DLRadioButton) {
        if (sender.tag == 1) {
            
        } else {
            
        }
    }
    
    
    @IBAction func didChangeMarkersDisplay(_ sender: DLRadioButton) {
        if (sender.tag == 1) {
            
        } else if (sender.tag == 2) {
            
        } else {
            
        }
    }
    
    
    @IBOutlet weak var btnMarkersDisplay: DLRadioButton!
    
    @IBOutlet weak var btnDistanceMetrics: DLRadioButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        btnDistanceMetrics.isMultipleSelectionEnabled = true
        btnMarkersDisplay.isMultipleSelectionEnabled = true
        
        for button in btnDistanceMetrics.selectedButtons() {
            
            if (button.tag == 2) {
                button.deselectOtherButtons()
            }
        }
        btnDistanceMetrics.isMultipleSelectionEnabled = false
        
        for button in btnMarkersDisplay.selectedButtons() {
            
            if (button.tag == 3) {
                button.deselectOtherButtons()
            }
        }
        btnMarkersDisplay.isMultipleSelectionEnabled = false
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
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
