//
//  DirectionViewController.swift
//  UITest
//
//  Created by tang quang an on 4/17/19.
//  Copyright © 2019 tang quang an. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import SwiftyJSON
import Alamofire

class DirectionViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate, UITextFieldDelegate, PlaceSelectViewControllerDelegate {
    
    var camera: GMSCameraPosition = GMSCameraPosition()
    var endMarker = GMSMarker()
    var startMarker = GMSMarker()
    let polyline = GMSPolyline()
    
    @IBOutlet weak var directionInfo: UIView!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var timeLb: UILabel!
    @IBOutlet weak var distanceLb: UILabel!
    
    @IBOutlet weak var directionBar: UIView!
    @IBOutlet weak var startTxtField: UITextField!
    @IBOutlet weak var endTxtField: UITextField!
    @IBAction func didTapBack(_ sender: UIButton) {
        self.dismiss(animated: true) {
        }
    }
    @IBOutlet weak var myMapView: GMSMapView!
    let currentLocationMarker = GMSMarker()
    var locationManager = CLLocationManager()
    
    
    @IBAction func didPressShare(_ sender: Any) {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sbShareRouteID") as! ShareRouteViewController
        self.addChild(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
    }
    
    @IBAction func didPressStart(_ sender: UIButton) {
        
        weak var pvc = self.presentingViewController as! ViewController
        self.dismiss(animated: true) {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sbTrackRouteID") as! TrackRouteViewController
            
            vc.endMarker = self.endMarker
            vc.camera = self.camera

            pvc!.present(vc, animated: true)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // Set up location
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        
        // Setup view
        // Remove unneccasry gestures (for textfield to work)
        for (index,gesture) in myMapView.gestureRecognizers!.enumerated() {
            if index == 0 {
                myMapView.removeGestureRecognizer(gesture)
            }
        }
        self.myMapView.addSubview(directionBar)
        self.myMapView.addSubview(directionInfo)
        myMapView.delegate = self
        myMapView.camera = self.camera
        myMapView.isMyLocationEnabled = true
        
        
//        if let location = myMapView.myLocation {
//            myMapView.animate(toLocation: (location.coordinate))
//
//        }
        
        endTxtField.text = (endMarker.title!)
        endTxtField.delegate = self
        startTxtField.delegate = self
        
        endMarker.map = self.myMapView
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        performSegue(withIdentifier: "changePlace", sender: textField)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PlaceSelectViewController {
            vc.delegate = self
            vc.camera = self.myMapView.camera
            
            if ((sender as? UITextField) == startTxtField) {
                vc.isEditingStartPoint = true
                vc.currentMarker = startMarker
            } else {
                vc.isEditingStartPoint = false
                vc.currentMarker = endMarker
            }
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error while getting location \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
//        if let lastLocation = lastLocation, let newLocation = locations.last {
//            if (lastLocation.distance(from: newLocation) < manager.distanceFilter) {
//                return
//            }
//        }
        
        if (locations.count == 1) {
            locationManager.stopUpdatingLocation()
            let location = locations.last
            //        print("Yessssssssssssssss")
            
            startMarker.title = "Your location"
            startMarker.position = (location?.coordinate)!
            startTxtField.text = startMarker.title
            
            startBtn.isHidden = false
            shareBtn.isHidden = false
            
            drawPath(startLocation: location!, endLocation: CLLocation(latitude: endMarker.position.latitude, longitude: endMarker.position.longitude))
        } else {
            return
        }
//        locationManager.delegate = nil  // To stop constant updating
//        self.myMapView.animate(to: camera)
        //        self.myMapView = GMSMapView.map(withFrame: self.view.bounds, camera: camera)
        
    }
    
    func drawPath(startLocation: CLLocation, endLocation: CLLocation)
    {
        let origin = "\(startLocation.coordinate.latitude),\(startLocation.coordinate.longitude)"
        let destination = "\(endLocation.coordinate.latitude),\(endLocation.coordinate.longitude)"
        
        
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving&key=AIzaSyCMYfiszedRS_hcUjJUyRCx9QPsaR2zUPQ"
        
            
        Alamofire.request(url).responseJSON { (response) in
            
            print(response.request as Any)  // original URL request
            print(response.response as Any) // HTTP URL response
            print(response.data as Any)     // server data
            print(response.result as Any)   // result of response serialization
            
            do {
                let json = try JSON(data: response.data!)
                let routes = json["routes"].arrayValue
                
                // print route using Polyline
                
                //  should be: if routes.count == 0 then 1. hide start and share btn, and have a popup
                for route in routes
                {
//                    print(route)
                    let routeOverviewPolyline = route["overview_polyline"].dictionary
                    let points = routeOverviewPolyline?["points"]?.stringValue
                    // Test
//                    print(points)
                    let path = GMSPath.init(fromEncodedPath: points!)
                    //                let polyline = GMSPolyline.init(path: path)
                    self.polyline.path = path
                    self.polyline.strokeWidth = 4
                    self.polyline.strokeColor = UIColor.red
                    self.polyline.map = self.myMapView
                    
                    let bounds = GMSCoordinateBounds(path: path!)
                    self.myMapView.animate(with:GMSCameraUpdate.fit(bounds, withPadding: 50.0))
                    
//                    var bounds = GMSCoordinateBounds()
//
//                    for index in 1...path!.count() {
//                        bounds = bounds.includingCoordinate(path!.coordinate(at: index))
//                    }
//                    self.myMapView.animate(with: GMSCameraUpdate.fit(bounds))
                    
                    
                    // Set the label
                    let legs =
                        route["legs"].arrayValue
                    
                    let duration = legs[0]["duration"].dictionary
                    self.timeLb.text = duration?["text"]?.stringValue
                    self.timeLb.sizeToFit()
                    let distance = legs[0]["distance"].dictionary
                    self.distanceLb.text = "(\(distance?["text"]?.stringValue ?? ""))"
                    self.distanceLb.sizeToFit()
                    self.directionInfo.isHidden = false
                }
            } catch {}
        }
    }
        
    func changedPlace(newPlaceMarker: GMSMarker, isEditingStartPoint: Bool) {
        
        
        if (isEditingStartPoint) {
            startMarker.map = nil
            startMarker = newPlaceMarker.copy() as! GMSMarker
            
            if (startMarker.title == "Your location") {
//                polyline.map = nil
//                locationManager.delegate = self
//                locationManager.requestWhenInUseAuthorization()
//                locationManager.startUpdatingLocation()
//                locationManager.startMonitoringSignificantLocationChanges()
                
                startBtn.isHidden = false
                shareBtn.isHidden = false
                startMarker.position = locationManager.location!.coordinate
//                startMarker.position = (locationManager.location?.coordinate)!
            } else {
                startMarker.map = self.myMapView
                startBtn.isHidden = true
                shareBtn.isHidden = true
            }
            self.startTxtField.text = startMarker.title
        } else {
            endMarker.map = nil
            endMarker = newPlaceMarker.copy() as! GMSMarker
            endMarker.map = self.myMapView
            self.endTxtField.text = endMarker.title
        }
        polyline.map = nil
        
        drawPath(startLocation: CLLocation(latitude: startMarker.position.latitude, longitude: startMarker.position.longitude), endLocation: CLLocation(latitude: endMarker.position.latitude, longitude: endMarker.position.longitude))
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
