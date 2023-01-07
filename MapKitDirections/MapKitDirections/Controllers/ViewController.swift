//
//  ViewController.swift
//  MapKitDirections
//
//  Created by Ahmed Salem on 07/01/2023.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {

    //Mark:- Outlets
    @IBOutlet weak var directionTextFiled: UITextField!
    @IBOutlet weak var directionButton: UIButton!
    @IBOutlet weak var mapKit: MKMapView!

    //Mark:- Variabels
    var locationManager = CLLocationManager()
    
}

// Mark:-  The Basic Operations
extension ViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //location manager configuration
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        //Map configuration
        mapKit.delegate = self
    }
}

// Mark:- IBActions
extension ViewController{
    @IBAction func getDirectionTapped(_ sender: UIButton) {
        // here we call get address function
        getAddress()
    }
}

// Mark:- Private Functions
extension ViewController{
    private func getAddress()
    {
        let getCoder = CLGeocoder()
        getCoder.geocodeAddressString(directionTextFiled.text!){
            (palceMarks , error) in
            guard let palceMarks = palceMarks, let location = palceMarks.first?.location
            else {
                print("Location Not Found.")
                return
            }
            
            print("Location is : \(location)")
            
            self.mapThis(destinationCord: location.coordinate)
            
        }
    }
}

//Mark:- Location manager functions, MapViewDelegate
extension ViewController: CLLocationManagerDelegate, MKMapViewDelegate
{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
    }
    
    func mapThis(destinationCord : CLLocationCoordinate2D)
    {
        guard let sourceCoordinate = locationManager.location?.coordinate else {
            print("Cann't get the user Location.")
            return
        }
        
        let sourcePlaceMark = MKPlacemark(coordinate: sourceCoordinate)
        let desPlaceMark = MKPlacemark(coordinate: destinationCord)
        
        let sourceItem = MKMapItem(placemark: sourcePlaceMark)
        let destinationItem = MKMapItem(placemark: desPlaceMark)
        
        let destinationRequest = MKDirections.Request()
        destinationRequest.source = sourceItem
        destinationRequest.destination = destinationItem
        destinationRequest.transportType = .automobile
        destinationRequest.requestsAlternateRoutes = true
        
        let direction = MKDirections(request: destinationRequest)
        direction.calculate{ (response , error) in
            guard let response = response else {
                if let error = error
                {
                    print("Some thong Went Wrong")
                }
                
                return
            }
            
            let route = response.routes[0]
            self.mapKit.addOverlay(route.polyline)
            self.mapKit.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            
        }
        
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        render.strokeColor = .brown
        return render
    }
}

