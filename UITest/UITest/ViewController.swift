//
//  ViewController.swift
//  UITest
//
//  Created by tang quang an on 4/14/19.
//  Copyright © 2019 tang quang an. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

@IBDesignable
class DesignableView: UIView {
}

@IBDesignable
class DesignableButton: UIButton {
}

@IBDesignable
class DesignableLabel: UILabel {
}

@IBDesignable
class DesignableTextField: UITextField {
}

extension UIView {

    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }

    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }

    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }

    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }

    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}

extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}

struct MyPlace {
    var name: String
    var lat: Double
    var long: Double
}

//class ViewController:UIViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//}


class ViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate, UITextFieldDelegate, GMSAutocompleteTableDataSourceDelegate, GMSAutocompleteViewControllerDelegate
{
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
//        let lat = place.coordinate.latitude
//        let long = place.coordinate.longitude
//
//
//        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 17.0)
//        myMapView.camera = camera
//        txtField.text=place.formattedAddress
//        chosenPlace = MyPlace(name: place.formattedAddress!, lat: lat, long: long)
//        let marker=GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
//        marker.title = "\(place.name)"
//        marker.snippet = "\(place.formattedAddress!)"
//        marker.map = myMapView
//
//        self.dismiss(animated: false, completion: nil) // dismiss after place selected
    }

    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        
    }

    func wasCancelled(_ viewController: GMSAutocompleteViewController) {

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DirectionViewController {
            vc.camera = self.myMapView.camera
            
            // Pass the selected place to next screen
            vc.endMarker = marker.copy() as! GMSMarker
        }
    }

    func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didAutocompleteWith place: GMSPlace) {

        let lat = place.coordinate.latitude
        let long = place.coordinate.longitude


        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 17.0)


        myMapView.camera = camera
        txtField.text=place.formattedAddress
//        chosenPlace = MyPlace(name: place.formattedAddress!, lat: lat, long: long)

        marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
        marker.title = place.name ?? ""
        marker.snippet = "\(place.formattedAddress!)"
        marker.map = self.myMapView

        txtField.resignFirstResponder()
        placeTitle.text = place.name
        placeAddress.text = place.formattedAddress
        placeInfo.isHidden = false
        tableView.isHidden = true

    }

    func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didFailAutocompleteWithError error: Error) {

    }

    func didRequestAutocompletePredictions(for tableDataSource: GMSAutocompleteTableDataSource) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        tableView.reloadData()
    }

    func didUpdateAutocompletePredictions(for tableDataSource: GMSAutocompleteTableDataSource) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        tableView.reloadData()
    }

    var marker = GMSMarker()
    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var placeInfo: UIView!
    @IBOutlet weak var myTextField: DesignableView!
    @IBOutlet weak var myMapView: GMSMapView!
    @IBOutlet weak var tableView: UITableView!
    //    var tableView: UITableView = UITableView(frame: CGRect(x: 12, y: 80, width: 390, height: 500))
    @IBOutlet weak var placeTitle: UILabel!
    @IBOutlet weak var placeAddress: UILabel!


    @IBOutlet weak var menuBtn: UIButton!
    @IBAction func didPressMenuBtn(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            // Handle for the side bar
            break
        case 2:
            txtField.text = ""
            txtField.resignFirstResponder()
            tableView.isHidden = true
            placeInfo.isHidden = true
            marker.map = nil
            menuBtn.tag = 1
            menuBtn.setImage(UIImage(named: "menu-1"), for: UIControl.State.normal)
            break
        default: break
        }
    }

    let currentLocationMarker = GMSMarker()
    var locationManager = CLLocationManager()
//    var chosenPlace: MyPlace?

    let customMarkerWidth: Int = 50
    let customMarkerHeight: Int = 70

    var tableData=[String]()
//    var fetcher: GMSAutocompleteFetcher?
    let tableDataSource = GMSAutocompleteTableDataSource()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.white
        myMapView.delegate=self
//        tableView.isHidden = true


        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()

        setupViews()

        initGoogleMaps()

        txtField.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        txtField.delegate = self

        tableDataSource.delegate = self

        tableView.delegate = tableDataSource
        tableView.dataSource = tableDataSource
        tableDataSource.tableCellBackgroundColor = UIColor.white
        tableDataSource.tableCellSeparatorColor = UIColor(red:0.32, green:0.67, blue:0.69, alpha:1.0)
        tableDataSource.primaryTextColor = UIColor(red:0.25, green:0.43, blue:0.57, alpha:1.0)
        tableDataSource.secondaryTextColor = UIColor(red:0.25, green:0.43, blue:0.57, alpha:1.0)


        tableView.reloadData()
        placeInfo.backgroundColor = UIColor.white
//        let newView = UIView(frame: CGRect(x: 100, y: 100, width: 40, height: 80))
//        self.view.addSubview(newView)
////        newView.backgroundColor = UIColor.white
        
    }

//    override func viewDidAppear(_ animated: Bool) {
//        let myImageView = UIImageView(frame: CGRect(x: 100, y: 200, width: 40, height: 40))
//        self.myMapView.addSubview(myImageView)
//        //        let myView = UIView(frame: CGRect(x: 100, y: 200, width: 40, height: 40))
//        //        myView.backgroundColor = .black
//        myImageView.image = myMapView.asImage()
//    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        menuBtn.tag = 2
        menuBtn.setImage(UIImage(named: "arrow-back"), for: UIControl.State.normal)
        print("Yes")
        textFieldDidChange(textField)
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        tableDataSource.sourceTextHasChanged(textField.text!)

        if (textField.text?.count == 0) {
            tableView.isHidden = true
        } else {
            tableView.isHidden = false
        }
    }

//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return tableData.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var section = indexPath.section
//
//        var row = indexPath.row
//
//        let cell: UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier:"addCategoryCell")
//
//        cell.selectionStyle =  UITableViewCell.SelectionStyle.none
//        cell.backgroundColor = UIColor.clear
//        cell.contentView.backgroundColor = UIColor.clear
//        cell.textLabel?.textAlignment = NSTextAlignment.left
//        cell.textLabel?.textColor = UIColor.black
//        cell.textLabel?.font = UIFont.systemFont(ofSize: 14.0)
//
//        cell.textLabel?.text = tableData[indexPath.row]
//
//        return cell
//    }



    func initGoogleMaps() {
        let camera = GMSCameraPosition.camera(withLatitude: 28.7041, longitude: 77.1025, zoom: 17.0)
        self.myMapView.camera = camera
        self.myMapView.delegate = self
        self.myMapView.isMyLocationEnabled = true

    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error while getting location \(error)")
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.delegate = nil
        locationManager.stopUpdatingLocation()
        let location = locations.last
        let lat = (location?.coordinate.latitude)!
        let long = (location?.coordinate.longitude)!
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 17.0)

        self.myMapView.animate(to: camera)
//        self.myMapView = GMSMapView.map(withFrame: self.view.bounds, camera: camera)

    }

    @objc func btnMyLocationAction() {
        let location: CLLocation? = myMapView.myLocation
        if location != nil {
            myMapView.animate(toLocation: (location?.coordinate)!)
        }
    }

    @objc func btnFriendDisplayAction() {
    }
    
    func setupViews() {
//        myMapView.frame = CGRect(x: 0, y: 49, width: 50, height: 10)
//        self.view.addSubview(myMapView)

        // Remove unneccasry gestures (for textfield to work)
        for (index,gesture) in myMapView.gestureRecognizers!.enumerated() {
            if index == 0 {
                myMapView.removeGestureRecognizer(gesture)
            }
        }

        menuBtn.tag = 1  // Set tag to 1 for homescreen
        self.myMapView.addSubview(myTextField)
        self.myMapView.addSubview(tableView)
//        tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 120).isActive=true
//        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 12).isActive=true
//        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -12).isActive=true


//        tableView.widthAnchor.constraint(equalToConstant: 390).isActive=true
//        tableView.heightAnchor.constraint(equalToConstant: 500).isActive=true

//        myMapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 60).isActive=true

//        myTextField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 52).isActive = true
//
//        myTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 12).isActive = true
//
//        myTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -12).isActive = true

        myMapView.topAnchor.constraint(equalTo: view.topAnchor).isActive=true
        myMapView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive=true
        myMapView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive=true
        myMapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 60).isActive=true

        self.myMapView.addSubview(btnMyLocation)
        btnMyLocation.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -160).isActive=true
        btnMyLocation.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive=true
        btnMyLocation.widthAnchor.constraint(equalToConstant: 66).isActive=true
        btnMyLocation.heightAnchor.constraint(equalTo: btnMyLocation.widthAnchor).isActive=true
        
        self.myMapView.addSubview(btnFriendDisplay)
        btnFriendDisplay.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80).isActive=true
        btnFriendDisplay.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive=true
        btnFriendDisplay.widthAnchor.constraint(equalToConstant: 66).isActive=true
        btnFriendDisplay.heightAnchor.constraint(equalTo: btnMyLocation.widthAnchor).isActive=true

//        btnMyLocation.imageView?.heightAnchor.constraint(equalToConstant: 30)

        self.myMapView.addSubview(placeInfo)

    }

//    let myMapView: GMSMapView = {
//        let v=GMSMapView()
//        v.translatesAutoresizingMaskIntoConstraints=false
//        return v
//    }()


    let btnMyLocation: UIButton = {
        let btn=UIButton()
        btn.backgroundColor = UIColor.white
        btn.setImage(#imageLiteral(resourceName: "GPS_Button"), for: .normal)
//        btn.layer.frame = CGRect(x: 336, y: 686, width: 66, height: 66)
        btn.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        btn.layer.cornerRadius = 30
        btn.clipsToBounds=true
        btn.tintColor = UIColor.gray
        btn.imageView?.tintColor=UIColor.gray
        btn.addTarget(self, action: #selector(btnMyLocationAction), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints=false
        return btn
    }()
    
    let btnFriendDisplay: UIButton = {
        let btn=UIButton()
        btn.backgroundColor = UIColor.white
        btn.setImage(#imageLiteral(resourceName: "route"), for: .normal)
        //        btn.layer.frame = CGRect(x: 336, y: 686, width: 66, height: 66)
        btn.imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        btn.layer.cornerRadius = 30
        btn.clipsToBounds=true
        btn.tintColor = UIColor.gray
        btn.imageView?.tintColor=UIColor.gray
        btn.addTarget(self, action: #selector(btnFriendDisplayAction), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints=false
        return btn
    }()
    
    let previewDemoData = [(name: "Friend1", img: #imageLiteral(resourceName: "Rectangle"), lat: 10, long: 10), (name: "Friend2", img: #imageLiteral(resourceName: "initialpoint"), lat: 10, long: 10), (name: "Friend3", img: #imageLiteral(resourceName: "GPS_Button"), lat: 10, long: 10)]
    // Should be call in accordance to the user dragging the screen (to save data)
    func showFriendMarkers() {
        myMapView.clear()
        for i in 0..<3 {
            let marker=GMSMarker()
            let customMarker = CustomMarkerView(image: previewDemoData[i].img, borderColor: UIColor.darkGray, tag: i)
            marker.iconView=customMarker
            marker.position = CLLocationCoordinate2D(latitude: CLLocationDegrees(previewDemoData[i].lat), longitude: CLLocationDegrees(previewDemoData[i].long))
            marker.map = self.myMapView
        }
    }
    

//    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
//        //        guard let customMarkerView = marker.iconView as? CustomMarkerView else { return false }
//        //        let img = customMarkerView.img!
//        //        let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: customMarkerWidth, height: customMarkerHeight), image: img, borderColor: UIColor.white, tag: customMarkerView.tag)
//        //
//        //        marker.iconView = customMarker
//
//        return false
//    }
//
//    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
//        //        guard let customMarkerView = marker.iconView as? CustomMarkerView else { return }
//        //        let tag = customMarkerView.tag
//        //        restaurantTapped(tag: tag)
//    }
//
//    func mapView(_ mapView: GMSMapView, didCloseInfoWindowOf marker: GMSMarker) {
//        //        guard let customMarkerView = marker.iconView as? CustomMarkerView else { return }
//        //        let img = customMarkerView.img!
//        //        let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: customMarkerWidth, height: customMarkerHeight), image: img, borderColor: UIColor.darkGray, tag: customMarkerView.tag)
//        //        marker.iconView = customMarker
//    }

}




//extension ViewController: GMSAutocompleteFetcherDelegate {
//    func didAutocomplete(with predictions: [GMSAutocompletePrediction]) {
//        tableData.removeAll()
//
//        for prediction in predictions {
//
//            tableData.append(prediction.attributedPrimaryText.string)
//
//            //print("\n",prediction.attributedFullText.string)
//            //print("\n",prediction.attributedPrimaryText.string)
//            //print("\n********")
//        }
//
//        print(tableData)
//        tableView.reloadData()
//    }
//
//    func didFailAutocompleteWithError(_ error: Error) {
//        print(error.localizedDescription)
//    }
//}
