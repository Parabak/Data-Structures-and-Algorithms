//
//  MergeSort.swift
//  SortingAlgorithmCoreTests
//
//  Created by Aliaksandr Baranouski on 03/04/2020.
//  Copyright © 2020 personal. All rights reserved.
//

import XCTest

@testable import SortingAlgorithmCore

class MergeSortTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func test_onIntegers() {
        
        let n = 1000
        var ints = Array(repeating: 0, count: n)
        ints.fillWithRandomElements(n: n, range: 0...500)
        
        let benchmark = ints.sorted()
        let output = MergeSort.sorting(sequence: ints)
        
        XCTAssert(benchmark == output)
    }
    
    
    func test_onCustomSequence() {
        
        let sequence = CustomSequence<MiataModel>.fillWithMiatas(n: 10)
        var benchmark = CustomSequence<MiataModel>()
        sequence.sorted().forEach { benchmark[benchmark.endIndex] = $0 }
        
        let output = MergeSort.sorting(sequence: sequence)
        
        XCTAssert(benchmark == output)
    }
}
