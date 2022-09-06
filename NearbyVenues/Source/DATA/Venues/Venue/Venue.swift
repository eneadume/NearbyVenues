//
//  Venue.swift
//  NearbyVenues
//
//  Created by Enea Dume on 6/22/22.
//

import Foundation
import CoreData

@objc(Venue)
public class Venue: NSManagedObject, Codable {
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        do {
            try container.encode(name ?? "" , forKey: .name)
            try container.encode(location, forKey: .location)
        } catch {
            print("error")
        }
    }
    
    required convenience public init(from decoder: Decoder) throws {

        guard
            let contextUserInfoKey = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Venue", in: managedObjectContext)
        else { fatalError("decode failure") }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        do {
            name = try values.decode(String.self, forKey: .name)
            location = try values.decode(Location.self, forKey: .location)
        }catch(let error) {
            print(error.localizedDescription)
            throw error
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case location = "location"
    }
}

extension Venue {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Venue> {
        return NSFetchRequest<Venue>(entityName: "Venue")
    }

    @NSManaged public var name: String?
    @NSManaged public var location: Location?

}

extension Venue: Identifiable { }
