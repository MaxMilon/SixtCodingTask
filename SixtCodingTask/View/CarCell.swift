//
//  CarCell.swift
//  SixtCodingTask
//
//  Created by Max Trauboth on 18.11.20.
//

import UIKit
import CoreLocation

class CarCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet var carImageView: UIImageView!
    @IBOutlet var modelName: UILabel!
    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var carName: UILabel!
    
    
    // MARK: - Properties
    var viewModel: CarCellViewModel! {
        didSet {
            carImageView.image = viewModel.image
            modelName.text = viewModel.modelName
            distanceLabel.text = viewModel.distanceText
            carName.text = viewModel.carName
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

// MARK: - ViewModelToCarCellDelegate
extension CarCell: ViewModelToCarCellDelegate {
    func didLoad(image: UIImage) {
        carImageView.image = image
    }
}
