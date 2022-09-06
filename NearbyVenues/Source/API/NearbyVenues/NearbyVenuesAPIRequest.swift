//
//  NearbyVenuesAPIRequest.swift
//  NearbyVenues
//
//  Created by Enea Dume on 6/22/22.
//

import Foundation

protocol NearbyVenuesAPIRequest {
    var data: RequestDataProtocol { get }
    var needsAuthorization: Bool { get }
}

extension NearbyVenuesAPIRequest {
    func execute(
        dispatcher: NetworkDispatcher = URLSessionNetworkDispatcher(),
        signer: RequestSigner = RequestSigner(),
        progress: ProgressCallback? = nil,
        completion: @escaping NetworkCallback
    ){
        let requestData = processRequestData(signer: signer)

        let timestamp = Date()

        dispatcher.dispatch(request: requestData, progress: progress, completion: { result in
            switch result {
            case .success((let statusCode, let data)):
                switch statusCode.rawValue {
                case 200...299:
                    let result = self.handleSuccessfulResponse(withStatusCode: statusCode, data: data)
                    switch result {
                    case .success(let response):
                        let duration = self.elapsedTimeString(sinceDate: timestamp)
                        print("<-- \(self.data.method.rawValue) \(self.data.path ?? "<No Data Or Path>") (\(statusCode.rawValue), \(duration))")

                        completion(.success(response))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                case 500:
                    let duration = self.elapsedTimeString(sinceDate: timestamp)
                    print("<-- \(self.data.method.rawValue) \(self.data.path ?? "<No Data Or Path>") (\(statusCode.rawValue), \(duration))")

                    completion(.failure(.server))

                default:
                    let duration = self.elapsedTimeString(sinceDate: timestamp)
                    print("<-- \(self.data.method.rawValue) \(self.data.path ?? "<No Data Or Path>") (\(statusCode.rawValue), \(duration))")

                    let error = NearbyVenuesError.parseAPIError(endpoint: requestData.path ?? "Unknown", statusCode: statusCode, data: data)
                    completion(.failure(error))
                }

            case .failure(let error):
                let duration = self.elapsedTimeString(sinceDate: timestamp)
                print("<-- \(self.data.method.rawValue) \(self.data.path ?? "<No Data Or Path>") (???, \(duration))")

                print(error)
                completion(.failure(error))
            }
        })
    }
    
    private func processRequestData(signer: RequestSigner) -> RequestDataProtocol {
        return signer.sign(requestData: data, needsAuthorization: needsAuthorization)
    }

    private func handleSuccessfulResponse(withStatusCode statusCode: HTTPStatusCode, data: Data?) -> NetworkResult {
        guard let responseData = data else {
            return .failure(.network)
        }

        guard !responseData.isEmpty else {
            return .success(JSON([:]))
        }

        do {
            let responseJSON = try JSON(data: responseData)

            return .success(responseJSON)
        } catch let decodingError {
            print(decodingError)
            return .failure(.parsing)
        }
    }

    private func elapsedTimeString(sinceDate date: Date) -> String {
        return String(format: "%.2fms", Date().timeIntervalSince(date) * 1000.0)
    }
}
