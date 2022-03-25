//
//  StorageHandler.swift
//  NasaPic
//
//  Created by Apoorv Trikha on 25/03/22.
//

import Foundation
import UIKit

class StorageHandler {
    
    private let key = "kImageStorage"
    
    func saveImageResponse(response: ImageModel) {
        if let imageData = response.image?.pngData() {
            let model = StorageModel(metdata: response.metadataResponse, imageData: imageData, date: response.date)
            do {
                let encoder = JSONEncoder()
                let data = try encoder.encode(model)
                UserDefaults.standard.set(data, forKey: key)
            } catch {
                print("Could not save!")
            }
            
        }
    }
    
    func getSavedImageResponse() -> ImageModel? {
        if let data = UserDefaults.standard.value(forKey: key) {
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(StorageModel.self, from: data as! Data)
                let image = UIImage(data: model.imageData)
                return ImageModel(metadataResponse: model.metdata, image: image, date: model.date)
            } catch {
                print("Unable to Decode StorageModel (\(error))")
            }
        }
        return nil
    }
}
