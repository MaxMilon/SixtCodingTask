//
//  WebService.swift
//  SixtCodingTask
//
//  Created by Max Trauboth on 18.11.20.
//

import Foundation
import Alamofire

class WebService {
    
    private static let url = "https://cdn.sixt.io/codingtask/cars"
    
    static public func loadCars(completion: @escaping ([Car]?) -> Void) {
        AF.request("\(url)", method: .get, encoding: JSONEncoding.default).responseJSON { response in
                
            switch response.result {
            case .success:
                do {
                    guard let jsonData = response.data else {return}
                    let cars = try JSONDecoder().decode([Car].self, from: jsonData)
                    completion(cars)
                } catch let Err {
                    print("There was an Error decoding JSON: ", Err)
                    completion(nil)
                }
            case .failure(let error):
                print("Error: \(error)")
                completion(nil)
            }
        }
    }
    
    static public func loadImage(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
}
