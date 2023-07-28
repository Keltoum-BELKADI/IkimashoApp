//
//  Travel+CoreDataProperties.swift
//  Ikimasho
//
//  Created by Kel_Jellysh on 28/07/2023.
//
//

import Foundation
import CoreData


extension Travel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Travel> {
        return NSFetchRequest<Travel>(entityName: "Travel")
    }

    @NSManaged public var checkin: String?
    @NSManaged public var checkout: String?
    @NSManaged public var date: String?
    @NSManaged public var day: String?
    @NSManaged public var destination: String?
    @NSManaged public var destinationTown: String?
    @NSManaged public var flight: String?
    @NSManaged public var hotel: String?
    @NSManaged public var id: UUID?
    @NSManaged public var imageData: Data?
    @NSManaged public var note: String?
    @NSManaged public var time: String?
    @NSManaged public var town: String?
    @NSManaged public var train: String?
    @NSManaged public var country: Destination?

}

extension Travel : Identifiable {

}
