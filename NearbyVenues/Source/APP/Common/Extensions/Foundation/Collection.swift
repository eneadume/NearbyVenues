//
//  Collection.swift
//  NearbyVenues
//
//  Created by Enea Dume on 6/22/22.
//

import Foundation

extension Collection {

    var nilIfEmpty: Self? {
        return self.isEmpty ? nil : self
    }

    var isNotEmpty: Bool {
        return !isEmpty
    }

}
