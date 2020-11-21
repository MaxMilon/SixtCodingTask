//
//  CarPin.swift
//  SixtCodingTask
//
//  Created by Max Trauboth on 19.11.20.
//

import UIKit

class CarPin: UIView {

    // MARK: - Outlets
    @IBOutlet var carContainer: UIView! {
        didSet {
            carContainer.tintColor = UIColor.white
            carContainer.backgroundColor = UIColor.white
            carContainer.layer.cornerRadius = 0.5 * carContainer.bounds.size.width
            carContainer.clipsToBounds = true
        }
    }
    @IBOutlet var carImageView: UIImageView!
    
    // MARK: - Properties
    var car: Car! {
        didSet {
            loadImage()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 0.5 * self.bounds.size.width
        self.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 0.5 * self.bounds.size.width
        self.clipsToBounds = true
    }
    
    /// Loads image asynchronously
    private func loadImage() {
        guard let url = URL(string: car.carImageUrl) else { return }

        _ = ImageLoader().loadImage(url) { result in
          do {
            let image = try result.get()
            DispatchQueue.main.async {
                self.carImageView.image = image
            }
          } catch {
            print(error)
          }
        }
    }
    
    class func instanceFromNib() -> CarPin {
        return UINib(nibName: "CarPin", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CarPin
    }
}
