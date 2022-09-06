//
//  VenuesRepository.swift
//  NearbyVenues
//
//  Created by Enea Dume on 6/22/22.
//

import UIKit

protocol VenuesRepositoryProtocol {
    func getNearbyVenues(lat: String?, lng: String?, limit: Int?, completion: @escaping NearbyVenuesCallback<[Venue]>)
}

class VenuesRepository: VenuesRepositoryProtocol {
    private let venuesRemoteSource: VenuesRemoteSourceProtocol
    private let venuesLocalSource: VenuesLocalSourceProtocol
    
    init(
        venuesRemoteSource: VenuesRemoteSourceProtocol,
        venuesLocalSource: VenuesLocalSourceProtocol
    ){
        self.venuesRemoteSource = venuesRemoteSource
        self.venuesLocalSource = venuesLocalSource
    }
    
    func getNearbyVenues(lat: String?, lng: String?, limit: Int?, completion: @escaping NearbyVenuesCallback<[Venue]>) {
        if NetworkMonitor.shared.isReachable {
            self.getRemoteVenues(lat: lat, lng: lng, limit: limit, completion: completion)
        }else {
            self.getLocalVenues(completion: completion)
        }
    }
    
    private func getRemoteVenues(lat: String?, lng: String?, limit: Int?, completion: @escaping NearbyVenuesCallback<[Venue]>) {
        venuesRemoteSource.getNearbyVenues(lat: lat, lng: lng, limit: limit) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let venues):
                self.venuesLocalSource.saveVenues()
                completion(.success(venues))
            case .failure:
                completion(result)
            }
        }
    }
    
    private func getLocalVenues(completion: @escaping NearbyVenuesCallback<[Venue]>) {
        venuesLocalSource.getVenues(completion: completion)
    }
    

}
