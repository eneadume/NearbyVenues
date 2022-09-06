//
//  GetVenuesRequest.swift
//  NearbyVenues
//
//  Created by Enea Dume on 6/22/22.
//

import UIKit

class GetVenuesRequest: NearbyVenuesAPIRequest {
    let needsAuthorization: Bool = true
    let data: RequestDataProtocol
    
    init(lat: String?, lng: String?, limit: Int?) {
        var params = JSON([:])
        if let lat = lat, let lng = lng {
            params["ll"] = JSON("\(lat),\(lng)")
        }
        
        if let limit = limit {
            params["limit"] = JSON(limit)
        }
        
        data = RequestData(
            path: PathBuilder.createPath(forEndpoint: "/places/search"),
            method: .get,
            params: params
        )
    }
}
