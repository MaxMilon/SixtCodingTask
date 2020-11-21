//
//  CarCellViewModelTests.swift
//  SixtCodingTaskTests
//
//  Created by Max Trauboth on 20.11.20.
//

import XCTest
import CoreLocation
@testable import SixtCodingTask

class CarCellViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDistanceText() {
        // Arrange
        let car = Car(id: "WMWSW31030T222518", modelIdentifier: "mini", modelName: "MINI", name: "Vanessa", make: "BMW", group: "MINI", color: "midnight_black", series: "MINI", fuelType: "D", fuelLevel: 0.7, transmission: "M", licensePlate: "M-VO0259", latitude: 48.134557, longitude: 11.576921, innerCleanliness: "REGULAR", carImageUrl: "https://cdn.sixt.io/codingtask/images/mini.png")
        let model = CarCellViewModel(car: car)
        model.location = CLLocation(latitude: 48.114988, longitude: 11.598359)
        
        // Act
        XCTAssertEqual(model.distanceText, "3 km entfernt")
    }
    
    func testDistanceTextWithSameLocation() {
        // Arrange
        let car = Car(id: "WMWSW31030T222518", modelIdentifier: "mini", modelName: "MINI", name: "Vanessa", make: "BMW", group: "MINI", color: "midnight_black", series: "MINI", fuelType: "D", fuelLevel: 0.7, transmission: "M", licensePlate: "M-VO0259", latitude: 48.134557, longitude: 11.576921, innerCleanliness: "REGULAR", carImageUrl: "https://cdn.sixt.io/codingtask/images/mini.png")
        let model = CarCellViewModel(car: car)
        model.location = CLLocation(latitude: 48.134557, longitude: 11.576921)
        
        // Act
        XCTAssertEqual(model.distanceText, "0 m entfernt")
    }

}
