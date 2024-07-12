//
//  SortingAlgorithmCoreTests.swift
//  SortingAlgorithmCoreTests
//
//  Created by Aliaksandr Baranouski on 03/04/2020.
//  Copyright © 2020 personal. All rights reserved.
//

import XCTest

class CustomSequenceTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_RandomAccessible_NoException() {

        var t = CustomSequence<MiataModel>()
        let na = MiataModel(vinCode: "vin1", dateOfmanufacture: Date(), displacementVolume: 1800)
        let nb = MiataModel(vinCode: "vin2", dateOfmanufacture: Date(), displacementVolume: 1600)
        let nc = MiataModel(vinCode: "vin3", dateOfmanufacture: Date(), displacementVolume: 2000)
        
        t[0] = na
        t[1] = nb
        t[3] = nc
    
        let test = t[2]
        XCTAssert(test == MiataModel.dummyInstance())
    }
    
    
    func testCustomSequence_rangeSubscript() {
    
        let sequence = CustomSequence<MiataModel>.fillWithMiatas(n: 10)
        let a = sequence[0..<2]
        let b = sequence[0...1]
        
        XCTAssert(a == b)
    }
    
    
    func testDisplacementUnits() {
        
        let unitCC = Measurement.init(value: 2800, unit: DisplacementUnit.cubicCentimeter)
        let unitL = Measurement.init(value: 2, unit: DisplacementUnit.litr)
        
        XCTAssert(unitCC - unitL == Measurement.init(value: 800, unit: DisplacementUnit.cubicCentimeter))
        XCTAssert(unitL < unitCC)
    }
}
