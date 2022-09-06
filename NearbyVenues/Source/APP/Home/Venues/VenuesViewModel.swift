//
//  VenuesViewModel.swift
//  NearbyVenues
//
//  Created by Enea Dume on 6/21/22.
//

import UIKit
import CoreLocation

enum VenuesDataState {
    case loading
    case reloading
    case loaded([Venue])
    case error(NearbyVenuesError)
}

protocol VenuesViewModelProtocol {
    var onDataStateChanged: ((VenuesDataState) -> Void)? { get set }
    
    func viewDidLoad()
    func fetchData()
    func reloadData()
}

class VenuesViewModel: VenuesViewModelProtocol {
    
    private let venuesRepository: VenuesRepositoryProtocol
    private let userLocationService: UserLocationServiceProtocol
    private var isFetching: Bool = false
    private var limit = 5
    private var currentLocation: CLLocation?
    
    var onDataStateChanged: ((VenuesDataState) -> Void)?
    
    init(
        venuesRepository: VenuesRepositoryProtocol,
        userLocationService: UserLocationServiceProtocol = UserLocationService()
    ){
        self.venuesRepository = venuesRepository
        self.userLocationService = userLocationService
    }
    
    func viewDidLoad() {
        self.fetchData()
    }
    
    func fetchData() {
        guard !isFetching else {
            return
        }
        
        isFetching = true
        self.onDataStateChanged?(.loading)
        self.getUserLocatinAndSearchForVenues()
    }
    
    func reloadData() {
            guard !isFetching else {
                return
            }
        
        isFetching = true
        self.onDataStateChanged?(.reloading)
        self.getUserLocatinAndSearchForVenues()
    }
    
    private func getUserLocatinAndSearchForVenues() {
        if let currentLocation = currentLocation {
            self.getVenues(near: currentLocation)
            return
        }
        
        userLocationService.requestCurrentLocation { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(location):
                self.currentLocation = location
                self.getVenues(near: location)
            case let .failure(error):
                self.onDataStateChanged?(.error(error))
            }
        }
    }
    
    private func getVenues(near currentLocation: CLLocation) {
        
        getVenues(lat: "\(currentLocation.coordinate.latitude)", lng: "\(currentLocation.coordinate.longitude)", limit: self.limit)
    }
    
    private func getVenues(lat: String?, lng: String?, limit: Int?) {
        venuesRepository.getNearbyVenues(lat: lat, lng: lng, limit: limit) { [weak self] result in
            guard let self = self else { return }
            
            self.isFetching = false
            switch result {
            case .success(let venues):
                self.onDataStateChanged?(.loaded(venues))
            case.failure(let error):
                self.onDataStateChanged?(.error(error))
            }
        }
    }
}
