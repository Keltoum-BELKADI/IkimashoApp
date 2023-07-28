//
//  Destination+CoreDataProperties.swift
//  Ikimasho
//
//  Created by Kel_Jellysh on 28/07/2023.
//
//

import Foundation
import CoreData


extension Destination {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Destination> {
        return NSFetchRequest<Destination>(entityName: "Destination")
    }

    @NSManaged public var image: Data?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var travels: Set<Travel>?

    public var wrappedimage: Data {
        image ?? Data()
    }

    public var wrappedName: String {
        name ?? "Unknown flag"
    }

    public var wrappedID: UUID {
        id ?? UUID()
    }

    public var wrappedTravels: [Travel]{
        let setOfTravel = travels
        return setOfTravel!.sorted{
            $0.id > $1.id
        }
    }



}

// MARK: Generated accessors for travels
extension Destination {

    @objc(addTravelsObject:)
    @NSManaged public func addToTravels(_ value: Travel)

    @objc(removeTravelsObject:)
    @NSManaged public func removeFromTravels(_ value: Travel)

    @objc(addTravels:)
    @NSManaged public func addToTravels(_ values: NSSet)

    @objc(removeTravels:)
    @NSManaged public func removeFromTravels(_ values: NSSet)

}

extension Destination : Identifiable {

}
