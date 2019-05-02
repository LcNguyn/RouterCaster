//
//  FinishRouteViewController.swift
//  UITest
//
//  Created by tang quang an on 4/30/19.
//  Copyright © 2019 tang quang an. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class FinishRouteViewController: UIViewController, UIScrollViewDelegate, GMSMapViewDelegate {

    @IBOutlet weak var routeImage: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var routeDistanceLb: UILabel!
    @IBOutlet weak var timeTravelledLb: UILabel!
    
    var myPath: GMSPath?
    var myPolyline: GMSPolyline = GMSPolyline()
    var startMarker: GMSMarker?
    var endMarker: GMSMarker?
    var timeTravelled: TimeInterval?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.init(displayP3Red: 0, green: 0, blue: 0, alpha: 0.1)
        
//        scrollView.decelerationRate = .normal
        
//        self.myPolyline.path = myPath
        
        // OK version
//        var staticMapUrl: String = "https://maps.googleapis.com/maps/api/staticmap?size=\(Int(routeImage.frame.width))x\(Int(routeImage.frame.height))&path=weight:3|color:red|enc:s`seFdnbjVZEAQAa@De@DQX_@vBqClA{AFKTNnAbBbDnExAtBqD~EiBbCe@l@IDKBMCoBR}@Ha@Lm@RgBPWwDk@cJ[{E&key=AIzaSyCMYfiszedRS_hcUjJUyRCx9QPsaR2zUPQ"
        
        let staticMapUrl: String = "https://maps.googleapis.com/maps/api/staticmap?size=\(Int(routeImage.frame.width))x\(Int(routeImage.frame.height))&markers=color:green|label:S|\(Double((startMarker?.position.latitude)!)),\(Double((startMarker?.position.longitude)!))&markers=color:red|label:E|\(Double((endMarker?.position.latitude)!)),\(Double((endMarker?.position.longitude)!))&path=weight:3|color:red|enc:\(self.myPath!.encodedPath())&key=AIzaSyCMYfiszedRS_hcUjJUyRCx9QPsaR2zUPQ"

//        print(self.myPolyline.path?.encodedPath())
//        print(routeImage.frame.width)
        
        let imageSession = URLSession(configuration: .ephemeral)
        
        if let url = NSURL(string: (staticMapUrl.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed))!) {
            
            print("Yessssssssssss")
            let task = imageSession.dataTask(with: url as URL) { (imageData, _, _) in
                guard let imageData = imageData, let image = UIImage(data: imageData) else {return}
                
                DispatchQueue.main.async {
                    self.routeImage.image = image
    //                routeImage.frame = CGRect(x: 0, y: 50, width: 200, height: 200)
//                    self.routeImage.contentMode = UIView.ContentMode.scaleAspectFit
                    //                    imageView.sizeToFit()
                }
            }
            task.resume()
        }
        
        
        routeDistanceLb.text = String((Double((GMSGeometryLength(myPath!)) / 1000) / 1.609).roundToDecimal(2))
        
        timeTravelledLb.text = timeTravelled!.stringFromTimeInterval()
        
        self.showAnimate()
        
    }
    
    //    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        self.view.frame.origin.x += self.view.frame.size.width
//    }
    
    @IBAction func didCloseView(_ sender: Any) {
        
        weak var pvc = self.parent as! TrackRouteViewController
        self.dismiss(animated: true) {
            pvc?.dismiss(animated: true, completion: {
                
            })
        }
        
    }
    @IBAction func didPressShare(_ sender: Any) {
        
        
    }
    @IBAction func didSaveRoute(_ sender: Any) {
        print("Yes")
        scrollView.setContentOffset(CGPoint(x: 434, y: 0), animated: true)
    }
    
    func showAnimate() {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25) {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
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
    
    
//    func getRouteImage() {
//
//        let myMapView = GMSMapView()
//        myMapView.delegate = self
//
//        let myView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//        myView.backgroundColor = .black
//        self.routeImage.image = myView.asImage()
//        self.routeImage.sizeToFit()
//    }
    
    

}

extension Double {
    func roundToDecimal(_ fractionDigits: Int) -> Double {
        let multiplier = pow(10, Double(fractionDigits))
        return Darwin.round(self * multiplier) / multiplier
    }
}

extension TimeInterval{
    
    func stringFromTimeInterval() -> String {
        
        let time = NSInteger(self)
        
        let seconds = time % 60
        let minutes = (time / 60) % 60
        let hours = (time / 3600)
        
        return String(format: "%0.2d:%0.2d:%0.2d",hours,minutes,seconds)
    }
}

