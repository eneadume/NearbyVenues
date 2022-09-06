//
//  VenuesRemoteSource.swift
//  NearbyVenues
//
//  Created by Enea Dume on 6/22/22.
//

import UIKit
import CoreData

protocol VenuesRemoteSourceProtocol {
    func getNearbyVenues(lat: String?, lng: String?, limit: Int?, completion: @escaping NearbyVenuesCallback<[Venue]>)
}

class VenuesRemoteSource: VenuesRemoteSourceProtocol {
    private let venuesService: VenuesServiceProtocol
    private let persistentContainer: NSPersistentContainer
    
    init(
        venuesService: VenuesServiceProtocol = VenuesService(),
        persistentContainer: NSPersistentContainer
    ){
        self.venuesService = venuesService
        self.persistentContainer = persistentContainer
    }
    
    func getNearbyVenues(lat: String?, lng: String?, limit: Int?, completion: @escaping NearbyVenuesCallback<[Venue]>) {
        venuesService.getNearbyVenues(lat: lat, lng: lng, limit: limit) { result in
            switch result {
            case .success(let response):
                do {
                    guard let context = CodingUserInfoKey.context else {
                        completion(.failure(.parsing))
                        return
                    }
                    
                    let resultsJSON = response["results"]
                    let decoder = JSONDecoder()
                    decoder.userInfo[context] = self.persistentContainer.viewContext
                    let results = try decoder.decode([Venue].self, from: resultsJSON.rawData())
                    DispatchQueue.main.async {
                        completion(.success(results))
                    }
                }catch(let error) {
                    print(error)
                    completion(.failure(.parsing))
                }
                return
            case .failure(let error):
                completion(.failure(error))
                return
            }
        }
    }
    
    
    
}
