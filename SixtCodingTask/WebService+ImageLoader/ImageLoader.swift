//
//  ImageLoader.swift
//  SixtCodingTask
//
//  Created by Max Trauboth on 19.11.20.
//

import Foundation
import UIKit

class ImageLoader {
    private var loadedImages = [URL: UIImage]()
    private var runningRequests = [UUID: URLSessionDataTask]()
    
    /// Loads images asynchronously and caches them if necessary
    /// - Parameters:
    ///   - url: the source image URL
    ///   - completion: completion handler for the response
    /// - Returns: an identifier that is used to identify the data task
    func loadImage(_ url: URL, _ completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID? {
        if let image = loadedImages[url] {
            completion(.success(image))
            return nil
        }

        let uuid = UUID()

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            defer {self.runningRequests.removeValue(forKey: uuid) }

            if let data = data, let image = UIImage(data: data) {
                self.loadedImages[url] = image
                completion(.success(image))
                return
            }

            guard let error = error else {
                return
            }

            guard (error as NSError).code == NSURLErrorCancelled else {
              completion(.failure(error))
              return
            }
      }
      task.resume()

      runningRequests[uuid] = task
      return uuid
    }
    
    /// Cancels any current loading task
    /// - Parameter uuid: an identifier that is used to identify the data task
    func cancelLoad(_ uuid: UUID) {
        runningRequests[uuid]?.cancel()
        runningRequests.removeValue(forKey: uuid)
    }
}
