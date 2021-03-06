//
//  TestD20Bonuses.swift
//  Characters
//
//  Created by Syd Polk on 8/28/16.
//  Copyright (c) 2016 Bone Jarring Games and Software, LLC. All rights reserved.
//

import XCTest
@testable import Characters


class TestD20Bonuses: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testD20BonusInfo() {
        var info = d20BonusInfo(newPermanentValue: 1)
        XCTAssertEqual(info.value, 1)
        XCTAssertEqual(info.state, .Permanent)
        XCTAssertEqual(info.rounds, 0)
        
        var decrResult = info.decrementRounds()
        XCTAssertEqual(info.state, .Permanent)
        XCTAssertEqual(info.rounds, 0)
        XCTAssertEqual(decrResult, .Permanent)
        
        info = d20BonusInfo(newTemporaryValue: -1, withRounds: 3)
        XCTAssertEqual(info.value, -1)
        XCTAssertEqual(info.state, .Temporary)
        XCTAssertEqual(info.rounds, 3)
        
        decrResult = info.decrementRounds()
        XCTAssertEqual(info.state, .Temporary)
        XCTAssertEqual(info.rounds, 2)
        XCTAssertEqual(decrResult, .Temporary)

        decrResult = info.decrementRounds()
        decrResult = info.decrementRounds()
        XCTAssertEqual(info.state, .Expired)
        XCTAssertEqual(info.rounds, 0)
        XCTAssertEqual(decrResult, .Expired)
        
        decrResult = info.decrementRounds()
        XCTAssertEqual(info.state, .Expired)
        XCTAssertEqual(info.rounds, 0)
        XCTAssertEqual(decrResult, .Expired)
        
    }
    
    func testD20BonusBySource() {
        var infoDict = d20BonusBySource()
        
        infoDict.addPermanent(withSource: "test1", withValue: 1)
        var netValue = infoDict.netValue()
        XCTAssertEqual(netValue, 1)
        var d20BonusState = infoDict.decrementRounds()
        XCTAssertNotEqual(d20BonusState, .Expired)
        infoDict.remove(source: "test1")
        netValue = infoDict.netValue()
        XCTAssertEqual(netValue, 0)
        d20BonusState = infoDict.decrementRounds()
        XCTAssertEqual(d20BonusState, .Expired)
        
        infoDict.addPermanent(withSource: "test1", withValue: 1)
        infoDict.addPermanent(withSource: "test2", withValue: 2)
        netValue = infoDict.netValue()
        XCTAssertEqual(netValue, 2)
        d20BonusState = infoDict.decrementRounds()
        XCTAssertNotEqual(d20BonusState, .Expired)
        infoDict.remove(source: "test1")
        netValue = infoDict.netValue()
        XCTAssertEqual(netValue, 2)
        infoDict.remove(source: "test2")
        netValue = infoDict.netValue()
        XCTAssertEqual(netValue, 0)
        d20BonusState = infoDict.decrementRounds()
        XCTAssertEqual(d20BonusState, .Expired)

        infoDict.addTemporary(withSource: "test1", withValue: 1, withRounds: 3)
        netValue = infoDict.netValue()
        XCTAssertEqual(netValue, 1)
        d20BonusState = infoDict.decrementRounds()
        XCTAssertNotEqual(d20BonusState, .Expired)
        d20BonusState = infoDict.decrementRounds()
        XCTAssertNotEqual(d20BonusState, .Expired)
        d20BonusState = infoDict.decrementRounds()
        XCTAssertEqual(d20BonusState, .Expired)
        
        infoDict.addTemporary(withSource: "test1", withValue: 1, withRounds: 2)
        infoDict.addTemporary(withSource: "test2", withValue: 2, withRounds: 1)
        infoDict.addTemporary(withSource: "test3", withValue: -1, withRounds: 3)
        netValue = infoDict.netValue()
        XCTAssertEqual(netValue, 2)
        d20BonusState = infoDict.decrementRounds()
        XCTAssertNotEqual(d20BonusState, .Expired)
        netValue = infoDict.netValue()
        XCTAssertEqual(netValue, 1)
        d20BonusState = infoDict.decrementRounds()
        XCTAssertNotEqual(d20BonusState, .Expired)
        netValue = infoDict.netValue()
        XCTAssertEqual(netValue, -1)
        d20BonusState = infoDict.decrementRounds()
        XCTAssertEqual(d20BonusState, .Expired)
        netValue = infoDict.netValue()
        XCTAssertEqual(netValue, 0)
        
        infoDict.addPermanent(withSource: "test1", withValue: 1)
        infoDict.addTemporary(withSource: "test2", withValue: 2, withRounds: 1)
        netValue = infoDict.netValue()
        XCTAssertEqual(netValue, 2)
        d20BonusState = infoDict.decrementRounds()
        XCTAssertNotEqual(d20BonusState, .Expired)
        netValue = infoDict.netValue()
        XCTAssertEqual(netValue, 1)
        d20BonusState = infoDict.decrementRounds()
        XCTAssertNotEqual(d20BonusState, .Expired)
        netValue = infoDict.netValue()
        XCTAssertEqual(netValue, 1)
        
        infoDict.addPermanent(withSource: "test1", withValue: 2)
        infoDict.addTemporary(withSource: "test2", withValue: 1, withRounds: 1)
        netValue = infoDict.netValue()
        XCTAssertEqual(netValue, 2)
        d20BonusState = infoDict.decrementRounds()
        XCTAssertNotEqual(d20BonusState, .Expired)
        netValue = infoDict.netValue()
        XCTAssertEqual(netValue, 2)
        d20BonusState = infoDict.decrementRounds()
        XCTAssertNotEqual(d20BonusState, .Expired)
        netValue = infoDict.netValue()
        XCTAssertEqual(netValue, 2)
    }
    
    func testD20Bonus() {
        var bonus = d20Bonus()
        var netValue: Int
        
        bonus.addPermanent("armor", fromSource: "Plate", withValue: 6)
        netValue = bonus.netValue("armor")
        XCTAssertEqual(netValue, 6)
        bonus.remove("armor", fromSource: "Plate")
        netValue = bonus.netValue("armor")
        XCTAssertEqual(netValue, 0)
        
        bonus.addPermanent("armor", fromSource: "Plate", withValue: 6)
        bonus.addPermanent("armor", fromSource: "Robe of Armor", withValue: 4)
        netValue = bonus.netValue("armor")
        XCTAssertEqual(netValue, 6)
        bonus.remove("armor", fromSource: "Plate")
        netValue = bonus.netValue("armor")
        XCTAssertEqual(netValue, 4)
        bonus.remove("armor", fromSource: "Robe of Armor")
        netValue = bonus.netValue("armor")
        XCTAssertEqual(netValue, 0)
        
        bonus.addTemporary("armor", fromSource: "Enhance Armor", withValue: 1, withRounds: 2)
        netValue = bonus.netValue("armor")
        XCTAssertEqual(netValue, 1)
        bonus.decrementRounds("armor")
        netValue = bonus.netValue("armor")
        XCTAssertEqual(netValue, 1)
        bonus.decrementRounds("armor")
        netValue = bonus.netValue("armor")
        XCTAssertEqual(netValue, 0)
        
        bonus.addTemporary("armor", fromSource: "Shield", withValue: 3, withRounds: 1)
        bonus.addTemporary("armor", fromSource: "Enhance Armor", withValue: 1, withRounds: 2)
        netValue = bonus.netValue("armor")
        XCTAssertEqual(netValue, 3)
        bonus.decrementRounds("armor")
        netValue = bonus.netValue("armor")
        XCTAssertEqual(netValue, 1)
        bonus.decrementRounds("armor")
        netValue = bonus.netValue("armor")
        XCTAssertEqual(netValue, 0)

        bonus.addTemporary("armor", fromSource: "Shield", withValue: 1, withRounds: 1)
        bonus.addTemporary("armor", fromSource: "Enhance Armor", withValue: 3, withRounds: 2)
        netValue = bonus.netValue("armor")
        XCTAssertEqual(netValue, 3)
        bonus.decrementRounds("armor")
        netValue = bonus.netValue("armor")
        XCTAssertEqual(netValue, 3)
        bonus.decrementRounds("armor")
        netValue = bonus.netValue("armor")
        XCTAssertEqual(netValue, 0)
        
        bonus.addPermanent("armor", fromSource: "Shield", withValue: 1)
        bonus.addTemporary("armor", fromSource: "Enhance Armor", withValue: 3, withRounds: 2)
        netValue = bonus.netValue("armor")
        XCTAssertEqual(netValue, 3)
        bonus.decrementRounds("armor")
        netValue = bonus.netValue("armor")
        XCTAssertEqual(netValue, 3)
        bonus.decrementRounds("armor")
        netValue = bonus.netValue("armor")
        XCTAssertEqual(netValue, 1)
        bonus.remove("armor", fromSource: "Shield")
        netValue = bonus.netValue("armor")
        XCTAssertEqual(netValue, 0)
        
        bonus.addPermanent("armor", fromSource: "Shield", withValue: 3)
        bonus.addTemporary("armor", fromSource: "Enhance Armor", withValue: 1, withRounds: 2)
        netValue = bonus.netValue("armor")
        XCTAssertEqual(netValue, 3)
        bonus.decrementRounds("armor")
        netValue = bonus.netValue("armor")
        XCTAssertEqual(netValue, 3)
        bonus.remove("armor", fromSource: "Shield")
        netValue = bonus.netValue("armor")
        XCTAssertEqual(netValue, 1)
        bonus.decrementRounds("armor")
        netValue = bonus.netValue("armor")
        XCTAssertEqual(netValue, 0)

        bonus.addPermanent("armor", fromSource: "Shield", withValue: 3)
        bonus.addTemporary("enhancement", fromSource: "Enhance Armor", withValue: 1, withRounds: 2)
        netValue = bonus.netValue("armor")
        XCTAssertEqual(netValue, 3)
        netValue = bonus.netValue()
        XCTAssertEqual(netValue, 4)
        bonus.decrementRounds()
        bonus.decrementRounds()
        netValue = bonus.netValue()
        XCTAssertEqual(netValue, 3)
        bonus.remove("armor", fromSource: "Shield")
        netValue = bonus.netValue()
        netValue = bonus.netValue()
        XCTAssertEqual(netValue, 0)

    }
}
