//
//  APIManager.swift
//  NasaPic
//
//  Created by Apoorv Trikha on 25/03/22.
//

import UIKit

class APIManager: NSObject {
    
    let session = URLSession.shared
    
    /// Get the list of images based on the count provided
    /// - Parameters:
    ///   - onSuccess: Success Handler
    ///   - onFailure: Error Handler
    func getImagesMetadata(onSuccess: @escaping(ImageResponse) -> Void, onFailure: @escaping(Error) -> Void) {
        let url = URL(string: "\(APIManagerConstants.endpoint)\(APIManagerConstants.key)")
        
        if let requestUrl = url {
            let task = session.dataTask(with: requestUrl) { data, response, error in
                if let data = data {
                    if let json = try? JSONDecoder().decode(ImageResponse.self, from: data) {
                        onSuccess(json)
                    }
                } else if let error = error {
                    onFailure(error)
                }
            }
            
            task.resume()
        }
    }
    
    
    /// Gets image from the URL received from the metadata call
    /// - Parameters:
    ///   - url: URL from where we need to fetch the image
    ///   - onSuccess: Success Handler
    ///   - onFailure: Error Handler
    func getImageFromURL(using url: String, onSuccess: @escaping(UIImage) -> Void, onFailure: @escaping(Error) -> Void) {
        let requestURL = URL(string: url)
        
        if let requestUrl = requestURL {
            let task = session.dataTask(with: requestUrl) { data, response, error in
                if let data = data {
                    if let image: UIImage = UIImage(data: data) {
                        onSuccess(image)
                    }
                    
                } else if let error = error {
                    onFailure(error)
                }
            }
            
            task.resume()
        }
    }
}
