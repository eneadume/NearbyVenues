//
//  Color.swift
//  NearbyVenues
//
//  Created by Enea Dume on 6/22/22.
//

import UIKit

class Color {
    
    static var tint: UIColor {
        return .orange
    }
    // White
    static let primaryWhite = UIColor.white
    static let warning = UIColor(red: 1.0, green: 0.7725, blue: 0.0, alpha: 1.0)
    
    struct Label {
        static var primary: UIColor {
            if #available(iOS 13.0, *) {
                return UIColor.label
            } else {
                return .black
            }
        }

        static var secondary: UIColor {
            if #available(iOS 13.0, *) {
                return UIColor.secondaryLabel
            } else {
                return .darkGray
            }
        }

        static var tertiary: UIColor {
            if #available(iOS 13.0, *) {
                return UIColor.tertiaryLabel
            } else {
                return UIColor(hex: 0xF5F5F5)
            }
        }

        static var lightText: UIColor {
            return UIColor.lightText
        }

        static var placeholder: UIColor {
            if #available(iOS 13.0, *) {
                return UIColor.placeholderText
            } else {
                return .lightGray
            }
        }

        static var detail: UIColor {
            if #available(iOS 13.0, *) {
                return UIColor.systemGray
            } else {
                return .darkGray
            }
        }
    }
}
