//
//  Icon.swift
//  NearbyVenues
//
//  Created by Enea Dume on 6/22/22.
//

import UIKit

// https://ionicons.com/v2/
// https://github.com/sweetmandm/ionicons-iOS/blob/master/ionicons/ionicons-codes.h
enum IconName: String {
    case addCircle = "\u{f359}"
    case alarm = "\u{f3c8}"
    case alert = "\u{f101}"
    case alertCircled = "\u{f100}"
}

struct Icon {
    static let warning = make(.alert, (30, 40))
    static let bigWarning = make(.alertCircled, (100, 100))

    static let networkWarning = make(.alertCircled, (28, 28))



    // We should probably use CGSize for all the icon sizes but that's for another time...
    private static func make(_ name: IconName, _ size: CGSize) -> UIImage? {
        return make(name, (size.width, size.height))
    }

    private static func make(_ name: IconName, _ size: (CGFloat, CGFloat)) -> UIImage? {
        return UIImage.icon(named: name, size: size)
    }
}

