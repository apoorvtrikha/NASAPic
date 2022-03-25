//
//  ViewController.swift
//  NasaPic
//
//  Created by Apoorv Trikha on 25/03/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var descriptionView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callAndGet()
        // Do any additional setup after loading the view.
    }
    
    func callAndGet() {
        let apiManager = APIManager()
        apiManager.getImagesMetadata(onSuccess: { response in
            apiManager.getImageFromURL(using: response.url, onSuccess: { image in
                DispatchQueue.main.async { [weak self] in
                    self?.imageView.image = image
                    self?.titleView.text = response.title
                    self?.descriptionView.text = response.explanation
                }
            }, onFailure: {error in
                print(error)
            })
        }, onFailure: {error in
            print(error)
        })
    }
    
    
}

