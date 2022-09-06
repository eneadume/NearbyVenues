//
//  PathBuilder.swift
//  NearbyVenues
//
//  Created by Enea Dume on 6/22/22.
//

import UIKit

class PathBuilder {
    static func createPath(forEndpoint endpoint: String) -> String {
        return Constants.baseURL + Constants.apiVersion + endpoint
    }
}
