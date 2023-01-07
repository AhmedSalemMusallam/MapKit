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

    
}

// Mark:-  The Basic Operations
extension ViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

// Mark:- IBActions
extension ViewController{
    @IBAction func getDirectionTapped(_ sender: UIButton) {
    }
}

