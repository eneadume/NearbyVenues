//
//  Location.swift
//  NearbyVenues
//
//  Created by Enea Dume on 6/22/22.
//

import Foundation
import CoreData

@objc(Location)
public class Location: NSManagedObject, Codable {
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        do {
            try container.encode(formattedAddress ?? "" , forKey: .formattedAddress)
        } catch {
            print("error")
        }
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard
            let contextUserInfoKey = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Location", in: managedObjectContext)
        else {  fatalError("decode failure") }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        formattedAddress = try container.decode(String.self, forKey: .formattedAddress)
    }
    
    enum CodingKeys: String, CodingKey {
        case formattedAddress = "formatted_address"
    }
    
}

extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var formattedAddress: String?
    @NSManaged public var venue: Venue?

}

extension Location : Identifiable { }
