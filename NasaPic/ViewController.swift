//
//  ViewController.swift
//  NasaPic
//
//  Created by Apoorv Trikha on 25/03/22.
//

import UIKit

class ViewController: UIViewController, ImageDataProviderManageable {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var descriptionView: UITextView!
    
    private var imageDataProvider: ImageDataProvider!
    private var storageHandler: StorageHandler!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageDataProvider = ImageDataProvider(delegate: self)
        // Do any additional setup after loading the view.
    }
    
    func modelDidUpdate(with data: ImageModel) {
        DispatchQueue.main.async { [weak self] in
            self?.imageView.image = data.image
            self?.titleView.text = data.metadataResponse.title
            self?.descriptionView.text = data.metadataResponse.explanation
        }
    }
    
    func modelDidUpdateWithResultFromStorage(with data: ImageModel, errorMessage: String) {
        modelDidUpdate(with: data)
        showErrorAlert(title: "Error", message: errorMessage)
    }
    
    func modelDidUpdateWithError(error: Error?, customError: String?) {
        var msg: String = ""
        if customError != nil {
            msg = customError ?? "Something went wrong"
        } else {
            if error != nil {
                msg = error?.localizedDescription ?? "Something went wrong"
            }
        }
        showErrorAlert(title: "Error", message: msg)
    }
    
    func showErrorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close",
                                      style: .destructive,
                                      handler: nil))
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
}

