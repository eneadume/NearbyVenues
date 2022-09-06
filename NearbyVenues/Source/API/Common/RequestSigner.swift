//
//  RequestSigner.swift
//  NearbyVenues
//
//  Created by Enea Dume on 6/22/22.
//

import Foundation
class RequestSigner {

    func sign(requestData: RequestDataProtocol, needsAuthorization: Bool) -> RequestDataProtocol {
        var headers = requestData.headers

        if needsAuthorization {
            headers["Authorization"] = "fsq3CzQJX67sFFKzFjX9fOaARH58gfKktI8QzX/qh8boIWg="
        }

        var signedRequestData = requestData
        signedRequestData.headers = headers

        return signedRequestData
    }
}
