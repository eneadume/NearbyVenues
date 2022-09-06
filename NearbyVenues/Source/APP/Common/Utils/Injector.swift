//
//  Injector.swift
//  NearbyVenues
//
//  Created by Enea Dume on 6/21/22.
//

import UIKit
import CoreData

class Injector {
    let venuesRepository: VenuesRepositoryProtocol
    let persistentContainer: NSPersistentContainer
    
    init(persistentContainer: NSPersistentContainer){
        self.persistentContainer = persistentContainer
        self.venuesRepository = VenuesRepository(
            venuesRemoteSource: VenuesRemoteSource(persistentContainer: self.persistentContainer),
            venuesLocalSource: VenuesLocalSource( persistentContainer: self.persistentContainer)
        )
    }
}
