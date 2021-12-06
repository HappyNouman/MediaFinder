//
//  MapVC.swift
//  AugustGrpFirstDe
//
//  Created by Happy Hadhood on 10/24/21.
//  Copyright © 2021 Happy Hadhood. All rights reserved.
//

import UIKit
import MapKit

//MARK:- MessageSendingDelegate
protocol MessageSendingDelegate: class {
    func sendMessage(message: String)
}

class MapVC: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var detailedAddressLable: UILabel!
    
    //MARK:- Propreties
    private let locationManager = CLLocationManager()
    weak var delegate: MessageSendingDelegate?
    var theMessage: String?
    
    //MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        mapView.delegate = self
    }
    
    //MARK:- Private Methods
    private func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            checkLocationAuthorisationStatus()
        }else {
            //show alart
            print("show alart")
        }
    }
    private func checkLocationAuthorisationStatus(){
        switch CLLocationManager.authorizationStatus(){
        case .authorizedAlways , .authorizedWhenInUse :
            //centerMapOnUserClocation
            centerMapOnSpecificLocation()
        case .restricted , .denied :
            //sho alart
            print("show alart")
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        default:
            //if ppel add new case
            print ( "unknown status")
        }
    }
    private func centerMapOnSpecificLocation() {
        let location = CLLocation( latitude: 30.033333, longitude: 31.233334)
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(region, animated: true)
        self.setAddressFrom(location: location)
        
    }
    private func setAddressFrom (location: CLLocation){
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location){ (placeMarks ,error ) in
            if let error = error {
                print("show error \(error.localizedDescription)")
            } else if let firstPlaceMark = placeMarks?.first {
                if let country = firstPlaceMark.country,
                    let city = firstPlaceMark.locality,
                    let region = firstPlaceMark.subLocality,
                    let street = firstPlaceMark.thoroughfare {
                    let detailedaddress = "\(country), \(city), \(region), \(street)"
                    self.detailedAddressLable.text = detailedaddress
                    self.theMessage = detailedaddress
                }
            }
        }
    }
    
    //MARK:- Actions
    @IBAction func ConfirmBtnTapped(_ sender: UIButton) {
        delegate?.sendMessage(message: theMessage ?? "" )
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK:- MKMapViewDelegate
extension MapVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool){
        let lat = mapView.centerCoordinate.latitude
        let long = mapView.centerCoordinate.longitude
        let location = CLLocation(latitude: lat, longitude: long)
        self.setAddressFrom(location: location)
    }
}
