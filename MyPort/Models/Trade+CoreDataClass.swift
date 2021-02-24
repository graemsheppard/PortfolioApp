//
//  Trade+CoreDataClass.swift
//  MyPort
//
//  Created by Graem Sheppard on 2021-02-17.
//
//

import Foundation
import CoreData

@objc(Trade)
public class Trade: NSManagedObject {
}

public enum TradeType: Int64 {
    case Purchase = 0
    case Sale = 1
}
