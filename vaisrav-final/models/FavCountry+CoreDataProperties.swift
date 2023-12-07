//
//  FavCountry+CoreDataProperties.swift
//  vaisrav-final
//
//  Created by Graphic on 2023-07-11.
//
//

import Foundation
import CoreData


extension FavCountry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavCountry> {
        return NSFetchRequest<FavCountry>(entityName: "FavCountry")
    }

    @NSManaged public var name: String
    @NSManaged public var capital: String
    @NSManaged public var flag: String
    @NSManaged public var id: UUID?
    @NSManaged public var population: Int64

}

extension FavCountry : Identifiable {

}
