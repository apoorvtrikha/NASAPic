//
//  AppConstants.swift
//  NasaPic
//
//  Created by Apoorv Trika on 25/03/22.
//

import Foundation
import UIKit

struct APIManagerConstants {
    static let key = "393oAjpuCqwRUPCvElAiDl97Xvda1dfShsD0B7eF"
    static let endpoint = "https://api.nasa.gov/planetary/apod?api_key="
}

/// Struct to represent the response received from the metadatacall
struct ImageResponse: Codable {
    var date: String
    var explanation: String
    var hdurl: String
    var media_type: String
    var service_version: String
    var title: String
    var url: String
}

struct ImageModel {
    var metadataResponse: ImageResponse
    // Adding image as optional to load elements as soon as they are received
    var image: UIImage?
    // Will keep this as String for ease
    var date: String
}
