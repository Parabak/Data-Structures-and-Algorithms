//
//  DisplacementUnit.swift
//  SortingAlgorithmCoreTests
//
//  Created by Aliaksandr Baranouski on 10/04/2020.
//  Copyright © 2020 personal. All rights reserved.
//

import Foundation


final class DisplacementUnit: Dimension {
    
    static var cubicCentimeter = DisplacementUnit(symbol: "cc", converter: UnitConverterLinear(coefficient: 1.0))
    
    static let litr = DisplacementUnit(symbol: "l", converter: UnitConverterLinear(coefficient: 1000.0))
    
    override class func baseUnit() -> DisplacementUnit {
        DisplacementUnit.cubicCentimeter
    }
}
