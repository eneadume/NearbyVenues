//
//  Optional.swift
//  NearbyVenues
//
//  Created by Enea Dume on 6/22/22.
//

import Foundation

extension Optional {

    var isNilOrEmpty: Bool {
        if self == nil { return true }

        if let stringSelf = self as? String {
            return stringSelf.isEmpty
        }

        return false
    }

    var isNotNil: Bool {
        return self != nil
    }

}

extension Optional where Wrapped: Collection {

    var isNilOrEmpty: Bool {
        return self?.isEmpty ?? true
    }

    var isNotNilOrEmpty: Bool {
        return self?.isNotEmpty ?? false
    }

}
