//
//  RequestData.swift
//  NearbyVenues
//
//  Created by Enea Dume on 6/22/22.
//

import Foundation

struct RequestData: RequestDataProtocol {

    var path: String?
    var method: HTTPMethod
    var headers: [String: String]

    var body: Data? {
        guard
            method == .post ||
            method == .put ||
            method == .patch
        else {
            return nil
        }

        do {
            guard let params = params else { return nil }
            return try params.rawData()
        } catch let error {
            print("RequestData parameter error:", error)
            return nil
        }
    }

    var contentType: String {
        switch method {
        case .get:
            return ""
        default:
            return "application/json"
        }
    }

    let params: JSON?

    init(
        path: String?,
        method: HTTPMethod = .get,
        headers: [String: String] = [:],
        params: JSON? = nil
    ) {
        self.method = method

        self.headers = headers

        if method == .get {
            if let path = path {
                self.path = path + (path.contains("?") ? "&" : "?") + makeQueryString(from: params)
            } else {
                self.path = nil
            }
            self.params = nil
        } else {
            self.path = path
            self.params = params
            self.headers["Content-Type"] = self.contentType
        }
    }

}

private func makeQueryString(from params: JSON?) -> String {
    guard let params = params, let dictionary = params.dictionary else { return "" }

    let queryStringFragments: [String] = dictionary.compactMap {
        let key = $0.0
        if let value = $0.1.rawString()?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            return "\(key)=\(value)"
        } else {
            print("Ignore param \($0.0)=\($0.1) for request")
            return nil
        }
    }

    return queryStringFragments.joined(separator: "&")
}
