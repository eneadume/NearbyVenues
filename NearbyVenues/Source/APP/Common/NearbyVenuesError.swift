//
//  NearbyVenuesError.swift
//  NearbyVenues
//
//  Created by Enea Dume on 6/22/22.
//

import Foundation

enum NearbyVenuesError: Error, Equatable {
    
    case api(message: String, statusCode: HTTPStatusCode, endpoint: String, json: JSON?)
    case encoding
    case custom(title: String?, message: String?)
    case server
    case data
    case database
    case databaseLoadFailure
    case general
    case inactiveDispatcher
    case network
    case parsing
    case permission(type: PermissionType)
    
    var title: String? {
        switch self {
        case .custom(let title, _):
            return title
        default:
            return Localizable.commonErrorTitle
        }
    }

    var detail: String? {
        switch self {
        case .api(let message, _, _, _):
            return message
        case .custom(_, let message):
            return message
        case .permission(let type):
            return type.errorDescription
        default:
            return Localizable.commonErrorDetail
        }
    }
    
    enum PermissionType {
        case location

        var errorDescription: String {
            switch self {
            case .location: return Localizable.permissionErrorLocation
            }
        }

        var settingsPromptTitle: String {
            switch self {
            case .location: return Localizable.permissionErrorLocationSettingsPromptTitle
            }
        }

        var settingsPromptMessage: String {
            switch self {
            case .location: return String.localizedStringWithFormat(Localizable.permissionErrorLocationSettingsPromptMessage, Constants.appDisplayName)
            }
        }
    }
    
    static func == (lhs: NearbyVenuesError, rhs: NearbyVenuesError) -> Bool {
        switch (lhs, rhs) {
        case let (.api(_, lcode, _, _), .api(_, rcode, _, _)):
            return lcode == rcode
        case let (.custom(lTitle, lMessage), .custom(rTitle, rMessage)):
            return lTitle == rTitle && lMessage == rMessage
        case (.data, .data),
             (.database, .database),
             (.general, .general),
             (.inactiveDispatcher, .inactiveDispatcher),
             (.network, .network),
             (.parsing, .parsing),
             (.encoding, .encoding):
            return true
        default:
            return false
        }
    }
    
    
    static func parseAPIError(endpoint: String, statusCode: HTTPStatusCode, data: Data?) -> NearbyVenuesError {
        do {
            guard let data = data else { return .parsing }
            let responseJSON = try JSON(data: data, options: [.allowFragments])

            // Changed this from Log to Print becuase it seems likely that we'd accidentally send PHI to bugfender otherwise
            print("[API] Parsing for error in:", responseJSON)

            if let detail = responseJSON["message"].string {
                return .api(message: detail, statusCode: statusCode, endpoint: endpoint, json: responseJSON)
            } else if let detail = responseJSON["message"].array?.first?.string {
                return .api(message: detail, statusCode: statusCode, endpoint: endpoint, json: responseJSON)
            } else {
                return .api(message: Localizable.commonErrorDetail, statusCode: statusCode, endpoint: endpoint, json: responseJSON)
            }
        } catch let error {
            print(error)
            return .api(message: Localizable.commonErrorDetail, statusCode: statusCode, endpoint: endpoint, json: nil)
        }
    }
}
