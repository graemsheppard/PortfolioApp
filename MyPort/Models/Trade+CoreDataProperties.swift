//
//  Trade+CoreDataProperties.swift
//  MyPort
//
//  Created by Graem Sheppard on 2021-02-17.
//
//

import Foundation
import CoreData


extension Trade {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Trade> {
        return NSFetchRequest<Trade>(entityName: "Trade")
    }

    @NSManaged public var date: Date
    @NSManaged public var quantity: Int64
    @NSManaged public var sharePrice: Double
    @NSManaged public var symbol: String
    @NSManaged public var type: Int64

}

extension Trade : Identifiable {
    
}

