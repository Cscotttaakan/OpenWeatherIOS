//
//  Extensions.swift
//  WeatherAppV2
//
//  Created by Craig Scott on 9/20/18.
//  Copyright © 2018 Craig Scott. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Rounds the double to decimal places value
extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    func celsiusToFahr() -> Double{
        return (self * 1.8 + 32)
    }
}

// MARK: - Date Extension to covert date to a day in String type.
extension Date {
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}

extension UIImageView {
        func load(url: URL) {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                        }
                    }
                }
            }
        }
}
