//
//  ImageViewModel.swift
//  NasaPic
//
//  Created by Apoorv Trikha on 25/03/22.
//

import Foundation

protocol ImageDataProviderManageable {
    
    /// Needs to be implemented by main controller to receive the data that should be updated to the UI
    func modelDidUpdate(with data: ImageModel)
    
    
    func modelDidUpdateWithResultFromStorage(with data: ImageModel, errorMessage: String)
    
    
    /// Needs to be updated by the main controller when error is received
    func modelDidUpdateWithError(error: Error?, customError: String?)
}

class ImageDataProvider {
    
    var delegate: ImageDataProviderManageable!
    
    private var model: ImageModel!
    
    init(delegate: ImageDataProviderManageable) {
        self.delegate = delegate
        self.fetchImages()
    }
    
    
    /// Fetches the images by talking to APIManager
    /// - Parameter noOfImages: Number of images we need to fetch
    private func fetchImages() {
        // If there is a saved response
        if let savedResponse = StorageHandler().getSavedImageResponse() {
            // If saved response date matches with current date
            // We don't need to make API call, simply return with save response
            if savedResponse.date == Date.getCurrentDate() {
                self.delegate.modelDidUpdate(with: savedResponse)
                return
            } else {
                // Check if there is internet available
                if !NetworkManager.shared.isReachable {
                    self.delegate.modelDidUpdateWithResultFromStorage(with: savedResponse, errorMessage: "We are not connected to the internet, showing you the last image we have.")
                    return
                }
            }
            
        } else {
            // If no saved response is there and internet not reachable
            if !NetworkManager.shared.isReachable {
                self.delegate.modelDidUpdateWithError(error: nil, customError: "Internet Not Available")
                return
            }
        }

        let apiManager = APIManager()
        apiManager.getImagesMetadata(onSuccess: { response in
            self.model = ImageModel(metadataResponse: response, date: Date.getCurrentDate())
            self.updateViewController()
            apiManager.getImageFromURL(using: response.url, onSuccess: { image in
                self.model = ImageModel(metadataResponse: response, image: image, date: Date.getCurrentDate())
                StorageHandler().saveImageResponse(response: self.model)
                self.updateViewController()
            }, onFailure: {error in
                self.delegate.modelDidUpdateWithError(error: error, customError: nil)
            })
        }, onFailure: {error in
            self.delegate.modelDidUpdateWithError(error: error, customError: nil)
        })
    }
    
    private func updateViewController() {
        self.delegate.modelDidUpdate(with: self.model)
    }
    
}
