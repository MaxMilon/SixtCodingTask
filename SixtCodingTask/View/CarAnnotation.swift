//
//  CarAnnotation.swift
//  SixtCodingTask
//
//  Created by Max Trauboth on 18.11.20.
//

import Foundation
import MapKit

public class CarAnnotation: NSObject, MKAnnotation {
    
    // MARK: - Properties
    var car: Car
    public var coordinate: CLLocationCoordinate2D {
        CLLocation(latitude: car.latitude, longitude: car.longitude).coordinate
    }
    
    init(car: Car) {
        self.car = car
        super.init()
    }
    
    public var title: String? {
        return ""
    }
    
    public var subtitle: String? {
        return ""
    }
}

class CarAnnotationView: MKAnnotationView {
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        guard let carAnnotation = annotation as? CarAnnotation else {
            return
        }
        
        customView(for: carAnnotation)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        guard let carAnnotation = annotation as? CarAnnotation else {
            return
        }
        
        customView(for: carAnnotation)
    }
    
    func customView(for annotation: CarAnnotation) {
        let view = CarPin.instanceFromNib()
        view.car = annotation.car
        view.center = self.center
        self.addSubview(view)
    }
}
