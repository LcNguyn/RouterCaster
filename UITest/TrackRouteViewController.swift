//
//  TrackRouteViewController.swift
//  UITest
//
//  Created by tang quang an on 4/29/19.
//  Copyright © 2019 tang quang an. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import SwiftyJSON
import Alamofire

class TrackRouteViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {

    var camera = GMSCameraPosition()
    var startMarker: GMSMarker = GMSMarker()
    var endMarker: GMSMarker = GMSMarker()
    var polyline = GMSPolyline()
    var endPosition: CLLocation?
    var startDate:NSDate?
    var endDate: NSDate?
    var timeTravelled: TimeInterval?
    
    @IBOutlet weak var myMapView: GMSMapView!
    @IBOutlet weak var destinationLb: UILabel!
    @IBOutlet weak var destionationInfo: UIView!
    @IBOutlet weak var destionationLb: UILabel!
    @IBOutlet weak var cancelRouteBtn: UIButton!
    @IBOutlet weak var myLocation: UIButton!
    
    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        
        for (index,gesture) in myMapView.gestureRecognizers!.enumerated() {
            if index == 0 {
                myMapView.removeGestureRecognizer(gesture)
            }
        }
        
        // Setup view
        self.myMapView.addSubview(destionationInfo)
        destionationLb.text = endMarker.title
        myMapView.delegate = self
        myMapView.camera = self.camera
        myMapView.isMyLocationEnabled = true
        myMapView.addSubview(cancelRouteBtn)
        myMapView.addSubview(myLocation)
        endPosition = CLLocation(latitude: endMarker.position.latitude, longitude: endMarker.position.longitude)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    @IBAction func didCancelRoute(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Do you want to quit this route", message: "", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Quit", style: .destructive, handler: { (action) in
            self.locationManager.delegate = nil
            self.dismiss(animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error while getting location \(error)")
    }
    
    
    
    var firstLoad = true
    let myPath = GMSMutablePath()
    let myPolyline = GMSPolyline()
    var isTracking = true
    var outOfRoute = 0
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if (firstLoad) {
            drawPath(startLocation: manager.location!, endLocation: CLLocation(latitude: endMarker.position.latitude, longitude: endMarker.position.longitude))
            startMarker.position = manager.location!.coordinate
            startDate = NSDate()
            firstLoad = false
        } else if let location = locations.last, let path = self.polyline.path {
            // Check if CLLocation is in the route
            if (GMSGeometryIsLocationOnPathTolerance(location.coordinate, path, true, CLLocationDistance(exactly: 10)!)) {
                print("You are on the route")
                
                myPath.add(location.coordinate)
                
                } else {
//                polyline.map = nil  // Delete the old one
                // May put this into function
                
                let alert = UIAlertController(title: "You are out of route", message: "Calculating new route", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action) in
                    alert.dismiss(animated: true, completion: nil)
                    
                    self.drawPath(startLocation: manager.location!, endLocation: CLLocation(latitude: self.endMarker.position.latitude, longitude: self.endMarker.position.longitude))
                    
//
//                    self.myPolyline.path = self.myPath
//                    self.myPolyline.map = self.myMapView
//                    self.myPolyline.strokeWidth = 4
//                    self.myPolyline.strokeColor = UIColor.red
                    
                }))
                
                self.present(alert, animated: true)
                
            }
            
            
            // When stay close to the destination
            if ((locations.last?.distance(from: endPosition!).isLess(than: 5000))!) {
                
                manager.delegate = nil
                
                endDate = NSDate()
                timeTravelled = endDate!.timeIntervalSince(startDate! as Date)
                
                let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sbFinishRouteID") as! FinishRouteViewController
                
                popOverVC.startMarker = (self.startMarker.copy() as! GMSMarker)
                popOverVC.endMarker = (self.endMarker.copy() as! GMSMarker)
                popOverVC.endMarker?.map = nil
                popOverVC.timeTravelled = self.timeTravelled
                //            popOverVC.myPath = self.myPath
                
                // Testing
                popOverVC.myPath = path
                popOverVC.myPolyline = self.polyline
                
                self.addChild(popOverVC)
                popOverVC.view.frame = self.view.frame
                self.view.addSubview(popOverVC.view)
                popOverVC.didMove(toParent: self)
            }
        }
        
        if (isTracking) {
            let lat = (manager.location!.coordinate.latitude)
            let long = (manager.location!.coordinate.longitude)
            let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 17)
            self.myMapView.animate(to: camera)
        }
    }

    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        if (gesture) {
            isTracking = false
            myLocation.isHidden = false
        }
    }
    
    @IBAction func didTapMyLocation(_ sender: UIButton) {
        let lat = (locationManager.location!.coordinate.latitude)
        let long = (locationManager.location!.coordinate.longitude)
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: self.myMapView.camera.zoom)
        self.myMapView.animate(to: camera)
        isTracking = true
        myLocation.isHidden = true
        
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
                    let path = GMSPath.init(fromEncodedPath: points!)
                    //                let polyline = GMSPolyline.init(path: path)
                    
//                    var entirePath = GMSMutablePath()
//                    for i in 0..<self.myPath.count() {
//                        entirePath.add(self.myPath.coordinate(at: i))
//                    }
//                    for i in 0..<path!.count() {
//                        entirePath.add(path!.coordinate(at: i))
//                    }

                    
                    self.polyline.path = path
                    self.polyline.strokeWidth = 4
                    self.polyline.strokeColor = UIColor.red
                    self.polyline.map = self.myMapView
                    
                    
//                    let bounds = GMSCoordinateBounds(path: path!)
//                    self.myMapView.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 50.0))
                }
            } catch {}
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

}
