//
//  Constants.swift
//  NearbyVenues
//
//  Created by Enea Dume on 6/21/22.
//

import UIKit

class Constants {
    static let UILaunchStoryboardNameKey = "UILaunchStoryboardName"
    static let baseURL = "https://api.foursquare.com"
    static let apiVersion = "/v3"
    
    static let minimumTouchSize: CGSize = CGSize(width: 48.0, height: 48.0)
    static let half: CGFloat = 1.0 / 2.0
    static let oneThird: CGFloat = 1.0 / 3.0
    static let twoThirds: CGFloat = 2.0 / 3.0
    static let fourFifths: CGFloat = 4.0 / 5.0
    
    struct Spacing {
        static let quarter: CGFloat = 2.0
        static let half: CGFloat = 4.0
        static let single: CGFloat = 8.0
        static let double: CGFloat = 16.0
        static let triple: CGFloat = 24.0
        static let quad: CGFloat = 32.0
    }
    
    static var appDisplayName: String {
        return (Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String) ?? ""
      }
    
    struct Image {
        static let alertImage = UIImage(named: "alert")
        static let emptyImage = UIImage(named: "empty")
    }

}
