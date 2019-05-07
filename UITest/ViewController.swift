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
import IGColorPicker

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

class ViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate, UITextFieldDelegate, GMSAutocompleteTableDataSourceDelegate, GMSAutocompleteViewControllerDelegate, ColorPickerViewDelegate, ColorPickerViewDelegateFlowLayout, ShowFriendRouteLocationViewControllerDelegate
{
    func didSelectFriendsLocation(selectedIndices: [IndexPath]) {
        var bounds = GMSCoordinateBounds()
        print("Get selected Indices................................")
        for selectedIndex in selectedIndices {
            bounds = bounds.includingCoordinate(CLLocationCoordinate2D(latitude: previewDemoData[selectedIndex.row].lat, longitude: previewDemoData[selectedIndex.row].long))
        }
        print("Get selected Indices................................")
        let update = GMSCameraUpdate.fit(bounds, withPadding: 60)
        myMapView.animate(with: update)
    }
    
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
        btnMyLocation.isHidden = true
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
    var colorPickerView: ColorPickerView!  // For changing friend's route color
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
            btnMyLocation.isHidden = false
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
//    private var clusterManager: GMUClusterManager!
//    var chosenPlace: MyPlace?

    let customMarkerWidth: Int = 50
    let customMarkerHeight: Int = 70

    var tableData=[String]()
//    var fetcher: GMSAutocompleteFetcher?
    let tableDataSource = GMSAutocompleteTableDataSource()

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.layoutIfNeeded()
        
        if (traitCollection.horizontalSizeClass == UIUserInterfaceSizeClass.compact && traitCollection.verticalSizeClass == UIUserInterfaceSizeClass.regular) {
            yPosColorPicker = 120
        } else {
            yPosColorPicker = -40
        }
        
        if let tappedMarker = tappedMarker {
            mapView(myMapView, didTap: tappedMarker)
        }
    }

    func enableBasicLocationServices() {
        locationManager.delegate = self
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            // Request when-in-use authorization initially
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            locationManager.startMonitoringSignificantLocationChanges()
            break
            
        case .restricted, .denied:
            // Disable location features
            print("Disabled Authorization........................")
            let alert = UIAlertController(title: "Need Authorization", message: "This app is unusable if you don't authorize this app to use your location!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { _ in
                let url = URL(string: UIApplication.openSettingsURLString)!
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }))
            self.present(alert, animated: true, completion: nil)
            break
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
            locationManager.startMonitoringSignificantLocationChanges()
            break
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        enableBasicLocationServices()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.white
        myMapView.delegate=self
//        tableView.isHidden = true
        

//        locationManager.delegate = self
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
//        locationManager.startMonitoringSignificantLocationChanges()
        
        

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
        
//        // Set up the cluster manager with default icon generator and renderer.
//        let iconGenerator = GMUDefaultClusterIconGenerator()
//        let algorithm = GMUNonHierarchicalDistanceBasedAlgorithm()
//        let renderer = GMUDefaultClusterRenderer(mapView: myMapView, clusterIconGenerator: iconGenerator)
//        renderer.delegate = self
//        clusterManager = GMUClusterManager(map: myMapView, algorithm: algorithm, renderer: renderer)
        
//        var overlayView = GMSMapView(frame: CGRect(x: 0, y: 0, width: self.myMapView.frame.width, height: self.myMapView.frame.height))
//        overlayView.backgroundColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0)
        
        
        // Save image to dir
//        let nsDocumentDirectory = NSSearchPathDirectory.DocumentDirectory
//        let nsUserDomainMask = NSSearchPathDomainMask.UserDomainMask
//        if let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true) {
//            if paths.count > 0 {
//                if let dirPath = paths[0] as? String {
//                    let readPath = dirPath.stringByAppendingPathComponent("Image.png")
//                    let image = UIImage(named: readPath)
//                    let writePath = dirPath.stringByAppendingPathComponent("Image2.png")
//                    UIImagePNGRepresentation(image).writeToFile(writePath, atomically: true)
//                }
//            }
//        }
        
        
        
//        self.myMapView.addSubview(overlayView)
        showFriendMarkers()
        
//        clusterManager.cluster()
//        clusterManager.setDelegate(self, mapDelegate: self)
        
        // Setup colorPickerView
        colorPickerView.delegate = self
        colorPickerView.layoutDelegate = self
        colorPickerView.style = .circle
        colorPickerView.selectionStyle = .check
        colorPickerView.isSelectedColorTappable = false
//        colorPickerView.preselectedIndex = colorPickerView.colors.indices.first
        
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

//    @objc func btnMyLocationAction() {
//        let location: CLLocation? = myMapView.myLocation
//        if location != nil {
//            myMapView.animate(toLocation: (location?.coordinate)!)
//        }
//    }
    
    
    @IBAction func didPressMyLocation(_ sender: Any) {
        let location: CLLocation? = myMapView.myLocation
        if location != nil {
            myMapView.animate(toLocation: (location?.coordinate)!)
        }
    }
    
    @IBAction func didPressFriendDisplay(_ sender: Any) {
        
        let showFriendRouteLocationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sbShowFriendRouteLocation") as! ShowFriendRouteLocationViewController
        self.addChild(showFriendRouteLocationVC)
        showFriendRouteLocationVC.view.frame = self.view.frame
        showFriendRouteLocationVC.delegate = self
        self.view.addSubview(showFriendRouteLocationVC.view)
        showFriendRouteLocationVC.didMove(toParent: self)
        
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
//        btnMyLocation.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -160).isActive=true
//        btnMyLocation.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive=true
//        btnMyLocation.widthAnchor.constraint(equalToConstant: 66).isActive=true
//        btnMyLocation.heightAnchor.constraint(equalTo: btnMyLocation.widthAnchor).isActive=true
        
        self.myMapView.addSubview(btnFriendDisplay)
//        btnFriendDisplay.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80).isActive=true
//        btnFriendDisplay.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive=true
//        btnFriendDisplay.widthAnchor.constraint(equalToConstant: 66).isActive=true
//        btnFriendDisplay.heightAnchor.constraint(equalTo: btnMyLocation.widthAnchor).isActive=true

//        btnMyLocation.imageView?.heightAnchor.constraint(equalToConstant: 30)

        colorPickerView = ColorPickerView(frame: CGRect(x: 0, y: 0, width: 98, height: 98))
        colorPickerView.backgroundColor = .white
        colorPickerView.shadowColor = UIColor(red:0.68, green:0.77, blue:0.77, alpha:1.0)
        colorPickerView.shadowRadius = 2
        colorPickerView.shadowOpacity = 1
        colorPickerView.shadowOffset = CGSize(width: 0, height: 2)
        colorPickerView.colors = [#colorLiteral(red: 0.862745098, green: 0.5568627451, blue: 0.5019607843, alpha: 1),#colorLiteral(red: 0.9098039216, green: 0.6509803922, blue: 0.4941176471, alpha: 1), #colorLiteral(red: 0.8196078431, green: 0.7882352941, blue: 0.5725490196, alpha: 1), #colorLiteral(red: 0.5176470588, green: 0.7960784314, blue: 0.7568627451, alpha: 1), #colorLiteral(red: 0.4549019608, green: 0.6901960784, blue: 0.862745098, alpha: 1), #colorLiteral(red: 1, green: 0.7265317578, blue: 0.7629562013, alpha: 1), #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.5019607843, alpha: 1), #colorLiteral(red: 0.862745098, green: 0.862745098, blue: 0.862745098, alpha: 1)]
        
        self.myMapView.addSubview(placeInfo)
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        let overlayView = UIView(frame: CGRect(x: 0, y: 0, width: self.myMapView.frame.width, height: self.myMapView.frame.height))
//        overlayView.backgroundColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:0.7)
//        self.myMapView.addSubview(overlayView)
//
//        self.myMapView.addSubview(tableView)
//        menuBtn.tag = 2
//        menuBtn.setImage(UIImage(named: "arrow-back"), for: UIControl.State.normal)
//        txtField.text = "Apple Union S"
//        txtField.becomeFirstResponder()
//        tableDataSource.sourceTextHasChanged("Apple Union S")
//        tableView.isHidden = false
//    }

//    let myMapView: GMSMapView = {
//        let v=GMSMapView()
//        v.translatesAutoresizingMaskIntoConstraints=false
//        return v
//    }()

    @IBOutlet weak var btnMyLocation: UIButton!
    @IBOutlet weak var btnFriendDisplay: UIButton!
    
    
    //    let btnMyLocation: UIButton = {
//        let btn=UIButton()
//        btn.backgroundColor = UIColor.white
//        btn.setImage(#imageLiteral(resourceName: "GPS_Button"), for: .normal)
////        btn.layer.frame = CGRect(x: 336, y: 686, width: 66, height: 66)
//        btn.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
//        btn.layer.cornerRadius = 35
//        btn.layer.shadowRadius = 5.0
//        btn.layer.shadowColor = UIColor(red: 0.00, green:0.00, blue:0.00, alpha: 1.0).cgColor
//        btn.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
//        btn.layer.shadowOpacity = 1.0
//        btn.layer.masksToBounds = true
//        btn.clipsToBounds=true
//        btn.tintColor = UIColor.gray
//        btn.imageView?.tintColor=UIColor.gray
//        btn.addTarget(self, action: #selector(btnMyLocationAction), for: .touchUpInside)
//        btn.translatesAutoresizingMaskIntoConstraints=false
//        return btn
//    }()
    
//    let btnFriendDisplay: UIButton = {
//        let btn=UIButton()
//        btn.backgroundColor = UIColor.white
//        btn.setImage(#imageLiteral(resourceName: "route"), for: .normal)
//        //        btn.layer.frame = CGRect(x: 336, y: 686, width: 66, height: 66)
//        btn.imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
//        btn.layer.cornerRadius = 35
//        btn.layer.shadowRadius = 5
//        btn.layer.shadowOpacity = 1
//        btn.layer.shadowOffset = CGSize(width: 0, height: 2)
//        btn.layer.shadowColor = (UIColor(red:0.00, green:0.00, blue:0.00, alpha:0.2)).cgColor
//        btn.clipsToBounds=true
//        btn.tintColor = UIColor.gray
//        btn.imageView?.tintColor=UIColor.gray
//        btn.addTarget(self, action: #selector(btnFriendDisplayAction), for: .touchUpInside)
//        btn.translatesAutoresizingMaskIntoConstraints=false
//        return btn
//    }()
    
//    var previewDemoData = [(name: "Friend1", img: #imageLiteral(resourceName: "Rectangle"), lat: 37.788633, long: -122.407050, polyline: GMSPolyline(path: GMSPath(fromEncodedPath: "_qseF|rbjVGq@r@ElDc@~ASt@ICa@KyAOaC")), start: GMSMarker(position: CLLocationCoordinate2DMake(37.788751, -122.407055)), end: GMSMarker(position: CLLocationCoordinate2D(latitude: 37.787059, longitude: -122.405181)), colorID: 0),
//        (name: "Friend2", img: #imageLiteral(resourceName: "initialpoint"), lat: 37.788409, long: -122.404891, polyline: GMSPolyline(path: GMSPath(fromEncodedPath:"uoseFlebjVDx@fAMTCJrAJxAHvADl@b@Gv@Kf@Gt@ICa@KyAKsACm@")), start: GMSMarker(position: CLLocationCoordinate2DMake(37.788409, -122.404891)), end: GMSMarker(position: CLLocationCoordinate2D(latitude: 37.787059, longitude: -122.405181)), colorID: 0),
//        (name: "Friend3", img: #imageLiteral(resourceName: "GPS_Button"), lat: 37.786273, long: -122.405723, polyline: GMSPolyline(path: GMSPath(fromEncodedPath: "_qseF|rbjVGq@r@ElDc@~ASt@ICa@KyAOaC")), start: GMSMarker(position: CLLocationCoordinate2DMake(37.786273, -122.405723)), end: GMSMarker(position: CLLocationCoordinate2D(latitude: 37.787059, longitude: -122.405181)), colorID: 0)]
    
    var previewDemoData = [(name: "Thao Nguyen", img: #imageLiteral(resourceName: "Unknown"), lat: 37.788212, long: -122.406747, polyline: GMSPolyline(path: GMSPath(fromEncodedPath: "_qseF|rbjVGq@r@ElDc@~ASt@ICa@KyAOaC")), start: GMSMarker(position: CLLocationCoordinate2DMake(37.788751, -122.407055)), end: GMSMarker(position: CLLocationCoordinate2D(latitude: 37.787059, longitude: -122.405181)), colorID: 0)]
    
    // Should be call in accordance to the user dragging the screen (to save data)
    // Should be added with if else statement inside to enable/disable viewing of friends location/route
    func showFriendMarkers() {
        myMapView.clear()
        for (i, data) in previewDemoData.enumerated() {
            let marker=GMSMarker()
            let customMarker = CustomMarkerView(name: data.name, image: data.img, borderColor: UIColor.black, tag: i)
            marker.iconView=customMarker
            marker.position = CLLocationCoordinate2D(latitude: CLLocationDegrees(data.lat), longitude: CLLocationDegrees(data.long))
            marker.map = self.myMapView
            
            data.polyline.strokeWidth = 3
            data.polyline.strokeColor = colorPickerView.colors[data.colorID]
            data.polyline.map = self.myMapView
            data.start.icon = GMSMarker.markerImage(with: UIColor.green)
            data.start.map = self.myMapView
            data.end.icon = GMSMarker.markerImage(with: UIColor.red)
            data.end.map = self.myMapView
            
            
//            marker.userData =  POIItem(position: marker.position)
//            generatePOIItems("Index \(i)", position: marker.position)
//            clusterManager.add(marker.userData as! POIItem)
        }
    }
    
    // MARK: GOOGLE MAP DELEGATE
//    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
////        guard let customMarkerView = marker.iconView as? CustomMarkerView else { return false }
////        let img = customMarkerView.img!
////        let customMarker = CustomMarkerView(image: img, borderColor: UIColor.white, tag: customMarkerView.tag)
////
////        marker.iconView = customMarker
//
//        return false
//    }
//
////    func mapView(_ mapView: GMSMapView, markerInfoContents marker: GMSMarker) -> UIView? {
////        guard let customMarkerView = marker.iconView as? CustomMarkerView else { return nil }
//////        let data = previewDemoData[customMarkerView.tag]
//////        restaurantPreviewView.setData(title: data.title, img: data.img, price: data.price)
//////        return restaurantPreviewView
////
////
////        return colorPickerView
////
////    }
//
//    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
//        guard let customMarkerView = marker.iconView as? CustomMarkerView else { return }
////        let tag = customMarkerView.tag
////        restaurantTapped(tag: tag)
//    }
//
//    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
//        guard let customMarkerView = marker.iconView as? CustomMarkerView else { return nil }
//        return colorPickerView
//    }
//
//
//    func mapView(_ mapView: GMSMapView, didCloseInfoWindowOf marker: GMSMarker) {
////        guard let customMarkerView = marker.iconView as? CustomMarkerView else { return }
////        let img = customMarkerView.img!
////        let customMarker = CustomMarkerView(image: img, borderColor: UIColor.darkGray, tag: customMarkerView.tag)
////        marker.iconView = customMarker
//    }
    
    
//    // initialize and keep a marker and a custom infowindow
//
//    //empty the default infowindow
//    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
//        return colorPickerView
//    }
//
//    @objc func testAction() {
//        print("Pressed")
//    }
    
    
//    // reset custom infowindow whenever marker is tapped
//    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
//        let location = CLLocationCoordinate2D(latitude: marker.position.latitude, longitude: marker.position.longitude)
//
//        tappedMarker = marker
//        colorPickerView.removeFromSuperview()
////        colorPickerView = ColorPickerView(frame: CGRect(x: 0, y: -50, width: 98, height: 98))
////        infoWindow.Name.text = (marker.userData as! location).name
////        infoWindow.Price.text = (marker.userData as! location).price.description
////        infoWindow.Zone.text = (marker.userData as! location).zone.rawValue
//        colorPickerView.center = CGPoint(x: (mapView.projection.point(for: marker.position)).x, y: (mapView.projection.point(for: marker.position)).y)
////        colorPickerView.button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
//        self.view.addSubview(colorPickerView)
//
//        // Remember to return false
//        // so marker event is still handled by delegate
//        return false
//    }
//
//    // let the custom infowindow follows the camera
//    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
//        if (tappedMarker.userData != nil){
//            let location = CLLocationCoordinate2D(latitude: marker.position.latitude, longitude: marker.position.longitude)
////            colorPickerView.center = mapView.projection.point(for: location)
//            colorPickerView.center = CGPoint(x: (mapView.projection.point(for: marker.position)).x, y: (mapView.projection.point(for: marker.position)).y)
//        }
//    }
//
//    // take care of the close event
//    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
//        colorPickerView.removeFromSuperview()
//    }
    
    var yPosColorPicker: CGFloat = 0
    var tappedMarker: GMSMarker?
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        guard let customMarkerView = marker.iconView as? CustomMarkerView else { return true }
        NSLog("marker was tapped")
        tappedMarker = marker
        
        //get position of tapped marker
        let position = marker.position
        mapView.animate(toLocation: position)
        let point = mapView.projection.point(for: position)
        let newPoint = mapView.projection.coordinate(for: point)
        let camera = GMSCameraUpdate.setTarget(newPoint)
        mapView.animate(with: camera)
        
        let opaqueWhite = UIColor(white: 1, alpha: 0.85)
        colorPickerView.tag = customMarkerView.tag
        if (colorPickerView.indexOfSelectedColor != nil) {
            colorPickerView.isSelectedColorTappable = true
            colorPickerView.selectColor(at: colorPickerView.indexOfSelectedColor!, animated: true)
        }
        colorPickerView.isSelectedColorTappable = false
//        colorPickerView.preselectedIndex = previewDemoData[colorPickerView.tag].colorID
//        colorPickerView.selectColor(at: previewDemoData[colorPickerView.tag].colorID, animated: true)
//        colorPickerView.isSelectedColorTappable = true
        colorPickerView.layer.backgroundColor = opaqueWhite.cgColor
        colorPickerView.layer.cornerRadius = 8
        colorPickerView.center = mapView.projection.point(for: position)
        colorPickerView.center.y -= yPosColorPicker
        self.myMapView.insertSubview(colorPickerView, belowSubview: myTextField)
        
        return false
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        return UIView()
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        colorPickerView.selectColor(at: previewDemoData[colorPickerView.tag].colorID, animated: true)
        colorPickerView.removeFromSuperview()
        tappedMarker = nil
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        
        if let position = tappedMarker?.position {
            colorPickerView.center = mapView.projection.point(for: position)
            colorPickerView.center.y -= yPosColorPicker
        }
    }
    
    
    func colorPickerView(_ colorPickerView: ColorPickerView, didSelectItemAt indexPath: IndexPath) {
        self.previewDemoData[colorPickerView.tag].polyline.strokeColor = colorPickerView.colors[indexPath.item]
        self.previewDemoData[colorPickerView.tag].colorID = indexPath.item
    }
    
    // MARK: - ColorPickerViewDelegateFlowLayout
    
    func colorPickerView(_ colorPickerView: ColorPickerView, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 22, height:  22)
    }
    
    func colorPickerView(_ colorPickerView: ColorPickerView, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    func colorPickerView(_ colorPickerView: ColorPickerView, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func colorPickerView(_ colorPickerView: ColorPickerView, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

//    // MARK: ADD MARKER TO CLUSTER
//    private func generatePOIItems(_ accessibilityLabel: String, position: CLLocationCoordinate2D) {
//        let item = POIItem(position: position, name: accessibilityLabel)
//        self.clusterManager.add(item)
//    }
//
//    func clusterManager(_ clusterManager: GMUClusterManager, didTap cluster: GMUCluster) -> Bool {
//        let newCamera = GMSCameraPosition.camera(withTarget: cluster.position,
//                                                 zoom: myMapView.camera.zoom + 1)
//        let update = GMSCameraUpdate.setCamera(newCamera)
//        myMapView.moveCamera(update)
//        return false
//    }
}

///// Point of Interest Item which implements the GMUClusterItem protocol.
//class POIItem: NSObject, GMUClusterItem  {
//    var position: CLLocationCoordinate2D
//    
////    var position: CLLocationCoordinate2D
////    var name: String!
////
//    init(position: CLLocationCoordinate2D) {
//        self.position = position
////        self.name = name
//    }
//}


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
