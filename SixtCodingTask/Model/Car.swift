//
//  Car.swift
//  SixtCodingTask
//
//  Created by Max Trauboth on 18.11.20.
//

import Foundation

/// The modle object that is created and passed around the whole application.
struct Car: Identifiable, Codable {
    let id: String
    let modelIdentifier: String
    let modelName: String
    let name: String
    let make: String
    let group: String
    let color: String
    let series: String
    let fuelType: String
    let fuelLevel: Double
    let transmission: String
    let licensePlate: String
    let latitude: Double
    let longitude: Double
    let innerCleanliness: String
    let carImageUrl: String
}
