//
//  StorageModel.swift
//  NasaPic
//
//  Created by I339156 on 25/03/22.
//

import Foundation

struct StorageModel: Codable {
    let metdata: ImageResponse
    let imageData: Data
    let date: String
}
