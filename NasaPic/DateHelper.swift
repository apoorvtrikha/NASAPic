//
//  DateHelper.swift
//  NasaPic
//
//  Created by I339156 on 25/03/22.
//

import Foundation

extension Date {

 static func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: Date())

    }
}
