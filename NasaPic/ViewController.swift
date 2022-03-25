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
    
    func modelDidUpdateWithError(error: Error) {
        //Something
    }
    
}

