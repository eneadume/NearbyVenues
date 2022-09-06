//
//  AnnchoredConstrained.swift
//  NearbyVenues
//
//  Created by Enea Dume on 6/22/22.
//

import UIKit

struct AnchoredConstraints {
    var top, leading, bottom, trailing, width, height: NSLayoutConstraint?
    
    func activate() {
        top?.isActive = true
        leading?.isActive = true
        trailing?.isActive = true
        width?.isActive = true
        height?.isActive = true
        bottom?.isActive = true
    }
}
