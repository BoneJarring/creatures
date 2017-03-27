//
//  TransactionsModel+CoreDataProperties.swift
//  Characters
//
//  Created by Syd Polk on 12/31/16.
//
//

import Foundation
import CoreData

extension TransactionsModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TransactionsModel> {
        return NSFetchRequest<TransactionsModel>(entityName: "TransactionsModel");
    }

    @NSManaged public var attribute: String?
    @NSManaged public var duration: NSNumber?
    @NSManaged public var oid: String?
    @NSManaged public var section: String?
    @NSManaged public var source: String?
    @NSManaged public var system: String?
    @NSManaged public var timestamp: NSDate?
    @NSManaged public var type: String?
    @NSManaged public var value: String?
    @NSManaged public var creature: CreatureModel?

}
