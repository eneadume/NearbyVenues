//
//  UserLocationService.swift
//  NearbyVenues
//
//  Created by Enea Dume on 6/22/22.
//

import Foundation
import CoreLocation

protocol UserLocationServiceProtocol {
    func requestCurrentLocation(completionHandler: @escaping NearbyVenuesCallback<CLLocation>)
}

class UserLocationService: NSObject, UserLocationServiceProtocol, CLLocationManagerDelegate {
    
    func requestCurrentLocation(completionHandler: @escaping NearbyVenuesCallback<CLLocation>) {
        requestCompletionHandler = completionHandler
        let manager = CLLocationManager()
        switch manager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
        case .denied, .restricted:
            finishCurrentLocationRequest(with: .failure(.permission(type: .location)))
        @unknown default:
            finishCurrentLocationRequest(with: .failure(.permission(type: .location)))
        }
    }
    
    private func finishCurrentLocationRequest(with result: NearbyVenuesResult<CLLocation>) {
        requestCompletionHandler?(result)
        requestCompletionHandler = nil
    }
    
    private var requestCompletionHandler: NearbyVenuesCallback<CLLocation>?
    
    // MARK: Location Manager
    
    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        return locationManager
    }()
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.requestLocation()
        case .denied, .restricted:
            finishCurrentLocationRequest(with: .failure(.permission(type: .location)))
        case .notDetermined:
            break
        @unknown default:
            break
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            finishCurrentLocationRequest(with: .success(location))
        } else {
            finishCurrentLocationRequest(with: .failure(.permission(type: .location)))
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        finishCurrentLocationRequest(with: .failure(.permission(type: .location)))
    }
    
}
