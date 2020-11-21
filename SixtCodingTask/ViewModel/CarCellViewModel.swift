//
//  CarCellViewModel.swift
//  SixtCodingTask
//
//  Created by Max Trauboth on 20.11.20.
//

import Foundation
import UIKit
import CoreLocation

protocol ViewModelToCarCellDelegate {
    func didLoad(image: UIImage)
}

class CarCellViewModel {
    
    // MARK: - Data
    let car: Car
    
    // MARK: - Delegate
    var delegate: ViewModelToCarCellDelegate?
    
    // MARK: - Properties
    var image: UIImage? {
        didSet {
            delegate?.didLoad(image: image ?? UIImage(systemName: "exclamationmark.circle")!)
        }
    }
    var modelName: String
    var carName: String
    var distanceText = "Entfernung nicht gefunden."
    
    var location: CLLocation! {
        didSet {
            let distance = calculateDistance(location: location, car: car)
            distanceText = format(distance)
        }
    }
    
    init(car: Car) {
        self.car = car
        modelName = car.modelName
        carName = car.name
        loadImage()
    }
    
    // MARK: - Methods
    private func loadImage() {
        guard let url = URL(string: car.carImageUrl) else { return }

        _ = ImageLoader().loadImage(url) { result in
          do {
            let image = try result.get()
            DispatchQueue.main.async {
                self.image = image
            }
          } catch {
            print(error)
          }
        }
    }
    
    private func format(_ distance: Double) -> String {
        if Int(distance) < 999 {
            return "\(Int(distance)) m entfernt"
        }
        return "\(Int(round(distance / 1000))) km entfernt"
    }
    
    private func calculateDistance(location: CLLocation, car: Car) -> Double {
        let carLocation = CLLocation(latitude: car.latitude, longitude: car.longitude)
        let distance = location.distance(from: carLocation)
        return distance
    }
}
