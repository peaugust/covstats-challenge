//
//  Double.swift
//  cov-stats
//
//  Created by Arthur Sady on 16/07/19.
//  Copyright © 2021 Jungle Devs. All rights reserved.
//

import Foundation

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
