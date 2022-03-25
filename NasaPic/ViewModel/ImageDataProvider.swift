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
    
    
    /// Needs to be updated by the main controller when error is received
    func modelDidUpdateWithError(error: Error)
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
        let apiManager = APIManager()
        apiManager.getImagesMetadata(onSuccess: { response in
            apiManager.getImageFromURL(using: response.url, onSuccess: { image in
                self.model = ImageModel(metadataResponse: response, image: image)
                self.delegate.modelDidUpdate(with: self.model)
            }, onFailure: {error in
                self.delegate.modelDidUpdateWithError(error: error)
            })
        }, onFailure: {error in
            self.delegate.modelDidUpdateWithError(error: error)
        })
    }
    
}
