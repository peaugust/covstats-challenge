//
//  UIColor.swift
//  cov-stats
//
//  Created by Antonio Duarte on 2/2/18.
//  Copyright © 2018 Jungle Devs. All rights reserved.
//

import UIKit

extension UIColor {
    static let brandColor = UIColor("#FF647C")
    static let gray60 = UIColor("#E4E4E4")
    static let gray3 = UIColor("#999999")
    static let black = UIColor("#151522")
    static let green = UIColor("#00C48C")
    
}

extension UIColor {
    convenience init(_ hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let alpha, red, green, blue: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (alpha, red, green, blue) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (alpha, red, green, blue) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (alpha, red, green, blue) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (alpha, red, green, blue) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(red) / 255,
                  green: CGFloat(green) / 255,
                  blue: CGFloat(blue) / 255,
                  alpha: CGFloat(alpha) / 255)
    }
}
