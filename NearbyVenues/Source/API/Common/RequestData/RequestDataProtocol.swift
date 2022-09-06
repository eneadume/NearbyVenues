//
//  RequestDataProtocol.swift
//  NearbyVenues
//
//  Created by Enea Dume on 6/22/22.
//

import Foundation

protocol RequestDataProtocol {
    var path: String? { get set }
    var method: HTTPMethod { get set }
    var headers: [String: String] { get set }

    var body: Data? { get }
    var contentType: String { get }
}
