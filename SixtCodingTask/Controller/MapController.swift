//
//  MapController.swift
//  SixtCodingTask
//
//  Created by Max Trauboth on 18.11.20.
//

import UIKit
import MapKit
import CoreLocation

class MapController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var listButton: UIButton! {
        didSet {
            listButton.layer.cornerRadius = 0.5 * listButton.bounds.size.width
            listButton.clipsToBounds = true
            listButton.layer.shadowColor = UIColor.black.cgColor
            listButton.layer.shadowOpacity = 1
            listButton.layer.shadowRadius = 40
            listButton.layer.masksToBounds = false
        }
    }
    
    // MARK: - Properties
    var cars = [Car]()
    
    // MARK: - LocationManager
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUserLocation()
        populateMap()
    }
    
    // MARK: - Methods
    private func setUpUserLocation() {
        determineCurrentLocation()
        centerViewOnUserLocation()
        mapView.showsUserLocation = true
    }
    
    private func centerViewOnUserLocation() {
        if let location = self.locationManager.location {
            setRegion(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        }
    }
    
    private func setRegion(latitude: Double, longitude: Double) {
        let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
    }
    
    private func determineCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    /// Loads cars asynchronously and stores result in the 'cars' property
    private func populateMap() {
        WebService.loadCars { cars in
            guard let cars = cars else { return }
            self.cars = cars
            
            for car in cars {
                self.createCarAnnotation(view: self.mapView, car: car)
            }
        }
    }
    
    /// Creates a customized pin on the map
    private func createCarAnnotation(view: MKMapView, car: Car) {
        let annotation = CarAnnotation(car: car)
        view.addAnnotation(annotation)
    }
}

// MARK: - CLLocationManagerDelegate
extension MapController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error - locationManager: \(error.localizedDescription)")
    }
}

// MARK: - MKMapViewDelegate
extension MapController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil }
        
        let identifier = "annotation"

        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = CarAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        } else {
            annotationView?.annotation = annotation
        }

        return annotationView
    }
}

// MARK: - CarListToMapDelegate
extension MapController: CarListToMapDelegate {
    func didTap(car: Car) {
        setRegion(latitude: car.latitude, longitude: car.longitude)
    }
}

// MARK: - Segue
extension MapController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? CarListController {
            vc.delegate = self
            vc.cars = self.cars
            vc.location = locationManager.location
        }
    }
}
