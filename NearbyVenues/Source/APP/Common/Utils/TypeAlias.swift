//
//  TypeAlias.swift
//  NearbyVenues
//
//  Created by Enea Dume on 6/21/22.
//

import Foundation
import CoreLocation

typealias Callback = () -> Void
typealias NearbyVenuesResult<T> = Result<T, NearbyVenuesError>
typealias NearbyVenuesCallback<T> = (NearbyVenuesResult<T>) -> Void

typealias ProgressCallback = (_ progress: Float) -> Void
typealias NetworkResult = NearbyVenuesResult<JSON>
typealias NetworkCallback = (_ result: NetworkResult) -> Void
