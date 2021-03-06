//
//  Transaction.swift
//  Characters
//
//  Created by Syd Polk on 11/13/16.
//  Copyright (c) 2016-2017 Bone Jarring Games and Software, LLC. All rights reserved.
//

import Foundation

class Transaction: Hashable {
    public let system: String   // The game system this creature is for. Pathfinder, D&D5, etc.
    public let section: String  // The section this belongs in. Ability, Skill, Feat, etc.
    public let attribute: String   // What is changing: strength, Alertness, etc.
    public let source: String   // What generated this transaction
    public let type: String     // What kind of bonus this is
    public let value: String    // The value of the change
    public let duration: Int    // For permanent changes, this is -1. Otherwise, the number of rounds this change is good for.
    public let timestamp: NSDate    // When this change was created
    public let oid: String      // Internal identifier

    func hash(into hasher: inout Hasher) {
        hasher.combine(oid)
    }

    init(system: String, section: String, attribute: String, source: String, type: String, value: String, duration: Int) {
        self.system = system
        self.section = section
        self.attribute = attribute
        self.source = source
        self.type = type
        self.value = value
        self.duration = duration
        self.timestamp = NSDate()
        self.oid = Prefs.getNewID()
    }

    static func ==(lhs: Transaction, rhs: Transaction) -> Bool {
        return lhs.oid == rhs.oid
    }

}
