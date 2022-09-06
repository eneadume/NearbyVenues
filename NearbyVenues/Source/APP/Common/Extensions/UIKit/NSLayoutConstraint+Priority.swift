//
//  NSLayoutConstraint+Priority.swift
//  NearbyVenues
//
//  Created by Enea Dume on 6/22/22.
//

import UIKit

extension NSLayoutConstraint {
    func withPriority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
}
