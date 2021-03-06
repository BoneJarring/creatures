//
//  TestCreatures.swift
//  Characters
//
//  Created by Syd Polk on 6/12/15.
//  Copyright (c) 2016-2017 Bone Jarring Games and Software, LLC. All rights reserved.
//

import XCTest
import CoreData
@testable import Characters

class TestCreatures: XCTestCase {

    var creaturesController: CreaturesController? = nil
    
    override func setUp() {
        super.setUp()

        creaturesController = CreaturesController.sharedCreaturesController(true, "Testing")
        // Put setup code here. This method is called before the invocation of each test method in the class.
        creaturesController?.deleteAll()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        creaturesController?.deleteAll()
        super.tearDown()
    }
    
    func testCreatures() {
        if let controller = creaturesController {
            var creatureModel = try! controller.createCreature("TestCreature1")
            XCTAssertNotNil(creatureModel, "creature was nil in testCreate.")

            controller.logAll()

            let creatures = controller.creatures()
            let startCount = creatures.count
            creatureModel = try! controller.createCreature("TestCreature2")
            controller.logAll()
            print(creatureModel.name!)
            var indexPath = controller.indexPathFromCreature(creatureModel)
            _ = controller.indexPathFromCreature(creatureModel)

            controller.deleteCreatureAtIndexPath(indexPath!)
            controller.logAll()
            XCTAssertEqual(creatures.count, startCount, "Did not have same number of creatures at the end.")

            creatureModel = try! controller.createCreature("TestCreature3")
            try! controller.saveName("TestCreature3.1", forCreature: creatureModel)
            var name = creatureModel.name
            XCTAssertEqual(name, "TestCreature3.1", "Name operation failed.")

            try! controller.saveName(" TestCreature3.2", forCreature: creatureModel)
            name = creatureModel.name
            XCTAssertEqual(name, "TestCreature3.2", "Leading space test failed.")

            try! controller.saveName("TestCreature3.3 ", forCreature: creatureModel)
            name = creatureModel.name
            XCTAssertEqual(name, "TestCreature3.3", "Trailing space test failed.")

            try! controller.saveName(" TestCreature3.4 ", forCreature: creatureModel)
            name = creatureModel.name
            XCTAssertEqual(name, "TestCreature3.4", "Leading and trailing spaces test failed.")
            
            try! controller.saveName(" TestCreature3.5 ", forCreature: creatureModel)
            name = creatureModel.name
            XCTAssertEqual(name, "TestCreature3.5", "Leading and trailing non-breaking spaces test failed.")
            
            try! controller.saveName("\tTestCreature3.6\t", forCreature: creatureModel)
            name = creatureModel.name
            XCTAssertEqual(name, "TestCreature3.6", "Leading and trailing tabs test failed.")

            try! controller.saveName("\nTestCreature3.7\n", forCreature: creatureModel)
            name = creatureModel.name
            XCTAssertEqual(name, "TestCreature3.7", "Leading and trailing newlines test failed.")
            
            try! controller.saveName("\rTestCreature3.8\r", forCreature: creatureModel)
            name = creatureModel.name
            XCTAssertEqual(name, "TestCreature3.8", "Leading and trailing carriage returns test failed.")
            
            do {
                try controller.saveName("", forCreature: creatureModel)
                XCTFail("saveName() was supposed to return an error if name was the null string.")
            } catch CreatureModel.CreatureModelDataError.nameCannotBeNull {
                // Yay. We pass
            } catch {
                let nserror = error as NSError
                XCTFail("Some other error happened when we tried to set name to null. Error code = \(nserror.code); domain = \(nserror.domain); description = \(nserror.localizedDescription)")
            }

            do {
                try controller.saveName("  ", forCreature: creatureModel)
                XCTFail("saveName() was supposed to return an error if trimmed name was the null string.")
            } catch CreatureModel.CreatureModelDataError.nameCannotBeNull {
                // Yay. We pass
            } catch {
                let nserror = error as NSError
                XCTFail("Some other error happened when we tried to set name to null. Error code = \(nserror.code); domain = \(nserror.domain); description = \(nserror.localizedDescription)")
            }
            
            controller.deleteAll()
            var original_creature: Creature?
            original_creature = Creature(system: "Pathfinder", strength: 18, dexterity: 16, constitution: 14, intelligence: 12, wisdom: 10, charisma: 8)
            var original_creature_model: CreatureModel?
            original_creature_model = try! controller.createCreature("TestCreature4", withSystem: "Pathfinder", withCreature: original_creature)
            name = original_creature_model?.name
            original_creature_model = nil
            original_creature = nil
            original_creature = Creature(system: "Pathfinder", strength: 8, dexterity: 10, constitution: 12, intelligence: 14, wisdom: 16, charisma: 18)
            original_creature_model = try! controller.createCreature("TestCreature4.1", withSystem: "Pathfinder", withCreature: original_creature)
            
            indexPath = IndexPath(row: 0, section: 0)
            let saved_creature_model = controller.creatureFromIndexPath(indexPath!)
            let saved_name = saved_creature_model.name
            let saved_creature = saved_creature_model.creature!
            XCTAssertEqual(name, saved_name)
            XCTAssertEqual(saved_creature.abilityScoreFor(.Strength), 18)
            XCTAssertEqual(saved_creature.abilityScoreFor(.Dexterity), 16)
            XCTAssertEqual(saved_creature.abilityScoreFor(.Constitution), 14)
            XCTAssertEqual(saved_creature.abilityScoreFor(.Intelligence), 12)
            XCTAssertEqual(saved_creature.abilityScoreFor(.Wisdom), 10)
            XCTAssertEqual(saved_creature.abilityScoreFor(.Charisma), 8)
        } else {
            XCTFail("Could not get CreaturesController")
        }
    }
    
}
