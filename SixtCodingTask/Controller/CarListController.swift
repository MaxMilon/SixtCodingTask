//
//  CarListController.swift
//  SixtCodingTask
//
//  Created by Max Trauboth on 18.11.20.
//

import UIKit
import CoreLocation

protocol CarListToMapDelegate {
    func didTap(car: Car)
}

class CarListController: UITableViewController {
    
    // MARK: - Properties
    var cars = [Car]()
    var location: CLLocation?
    
    // MARK: - Delegate
    var delegate: CarListToMapDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarCell", for: indexPath) as! CarCell
        let model = CarCellViewModel(car: cars[indexPath.row])
        model.delegate = cell
        model.location = location
        cell.viewModel = model
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didTap(car: cars[indexPath.row])
        self.dismiss(animated: true, completion: nil)
    }
}
