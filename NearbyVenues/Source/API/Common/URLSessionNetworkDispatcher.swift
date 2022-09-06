//
//  URLSessionNetworkDispatcher.swift
//  NearbyVenues
//
//  Created by Enea Dume on 6/22/22.
//

import Foundation
class URLSessionNetworkDispatcher: NetworkDispatcher {

    private var progressObservation: NSKeyValueObservation?

    func dispatch(
        request: RequestDataProtocol,
        progress: ProgressCallback?,
        completion: @escaping (Result<(HTTPStatusCode, Data?), NearbyVenuesError>) -> Void
    ) {
        guard let path = request.path, let url = URL(string: path) else {
            completion(.failure(.parsing))
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        urlRequest.httpBody = request.body

        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            defer {
                self.progressObservation = nil
            }

            if let error = error {
                print("URLSession DataTask Error:", error)
                completion(.failure(.network))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                print("URLSession DataTask Invalid Response")
                completion(.failure(.network))
                return
            }

            let statusCode = HTTPStatusCode(rawValue: httpResponse.statusCode) ?? .unknown
            if statusCode == .unknown {
                print("Unknown HTTP Status Code: \(httpResponse.statusCode)")
            }
            completion(.success((statusCode, data)))
        }

        progressObservation = task.progress.observe(\.fractionCompleted) { observedProgress, _ in
            progress?(Float(observedProgress.fractionCompleted))
        }

        task.resume()
    }
}
