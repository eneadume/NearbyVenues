//
//  VenuesService.swift
//  NearbyVenues
//
//  Created by Enea Dume on 6/22/22.
//

import UIKit

protocol VenuesServiceProtocol {
    func getNearbyVenues(lat: String?, lng: String?, limit: Int?, completion: @escaping NetworkCallback)
}

class VenuesService: VenuesServiceProtocol {
    func getNearbyVenues(lat: String?, lng: String?, limit: Int?, completion: @escaping NetworkCallback) {
        GetVenuesRequest(lat: lat, lng: lng, limit: limit).execute(completion: completion)
    }
}
