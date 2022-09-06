//
//  VenuesLocalSource.swift
//  NearbyVenues
//
//  Created by Enea Dume on 6/24/22.
//

import UIKit
import CoreData

protocol VenuesLocalSourceProtocol {
    func getVenues(completion: @escaping NearbyVenuesCallback<[Venue]>)
    func saveVenues()
    
}

class VenuesLocalSource: VenuesLocalSourceProtocol {
    let persistentContainer: NSPersistentContainer
    
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }
    
    func getVenues(completion: @escaping NearbyVenuesCallback<[Venue]>) {
        let request: NSFetchRequest<Venue> = Venue.fetchRequest()
        
        do {
            let venues = try persistentContainer.viewContext.fetch(request)
            print("Got \(venues.count) venues")
            completion(.success(venues))
        } catch {
            print("Fetch failed")
            completion(.failure(.server))
        }
    }
    
    func saveVenues() {
        if persistentContainer.viewContext.hasChanges {
            do {
                //delete before save
                try self.deleteAllEntities()
                print ("Saved")
                try persistentContainer.viewContext.save()
            } catch {
                print("An error occurred while saving: \(error)")
            }
        }
    }
    
    private func deleteAllEntities() throws {
        let entities = persistentContainer.managedObjectModel.entities
        do {
            for entity in entities {
                try delete(entityName: entity.name!)
            }
        }catch(let error) {
            throw(error)
        }
    }
    
    private func delete(entityName: String) throws {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try persistentContainer.viewContext.execute(deleteRequest)
        } catch let error as NSError {
            debugPrint(error)
            throw(error)
        }
    }
}
