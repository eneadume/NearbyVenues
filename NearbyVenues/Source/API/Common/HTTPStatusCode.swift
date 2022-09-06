//
//  HTTPStatusCode.swift
//  NearbyVenues
//
//  Created by Enea Dume on 6/22/22.
//

import Foundation

enum HTTPStatusCode: Int {
    // 2xx Success
    case ok = 200
    case created = 201
    case accepted = 202
    case noContent = 204

    // 4xx Client Error
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case unprocessableEntity = 422

    // 5xx Server Error
    case internalServerError = 500
    case badGateway = 502
    case serviceUnavailable = 503

    // Unknown
    case unknown = 666

    var humanReadableName: String {
        switch self {
        case .ok: return Localizable.commonHttp200
        case .created: return Localizable.commonHttp201
        case .accepted: return Localizable.commonHttp202
        case .noContent: return Localizable.commonHttp204
        case .badRequest: return Localizable.commonHttp400
        case .unauthorized: return Localizable.commonHttp401
        case .forbidden: return Localizable.commonHttp403
        case .notFound: return Localizable.commonHttp404
        case .unprocessableEntity: return Localizable.commonHttp422
        case .internalServerError: return Localizable.commonHttp500
        case .badGateway: return Localizable.commonHttp502
        case .serviceUnavailable: return Localizable.commonHttp503
        case .unknown: return Localizable.commonHttp666
        }
    }
}
