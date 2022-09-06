//
//  NetworkDispatcher.swift
//  NearbyVenues
//
//  Created by Enea Dume on 6/22/22.
//

import Foundation

protocol NetworkDispatcher {
    func dispatch(
        request: RequestDataProtocol,
        progress: ProgressCallback?,
        completion: @escaping (Result<(HTTPStatusCode, Data?), NearbyVenuesError>) -> Void
    )
}
