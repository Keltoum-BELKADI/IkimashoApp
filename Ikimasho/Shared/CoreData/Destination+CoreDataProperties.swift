//
//  Destination+CoreDataProperties.swift
//  Ikimasho (iOS)
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

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var imageData: Data?
    @NSManaged public var destionationToTravel: Set<Travel>?

    public var travel: [Travel]{
        let setOfTravel = destionationToTravel
        return setOfTravel!.sorted{
            $0.date ?? "" < $1.date ?? ""
        }
    }

}

// MARK: Generated accessors for destionationToTravel
extension Destination {

    @objc(addDestionationToTravelObject:)
    @NSManaged public func addToDestionationToTravel(_ value: Travel)

    @objc(removeDestionationToTravelObject:)
    @NSManaged public func removeFromDestionationToTravel(_ value: Travel)

    @objc(addDestionationToTravel:)
    @NSManaged public func addToDestionationToTravel(_ values: NSSet)

    @objc(removeDestionationToTravel:)
    @NSManaged public func removeFromDestionationToTravel(_ values: NSSet)

}

extension Destination : Identifiable {

}
