//
//  MiataModel.swift
//  SortingAlgorithmCoreTests
//
//  Created by Aliaksandr Baranouski on 10/04/2020.
//  Copyright © 2020 personal. All rights reserved.
//

import Foundation


struct MiataModel {

    let vin: String
    let date: Date
    let displacement: Measurement<DisplacementUnit>
    
    init(vinCode: String, dateOfmanufacture: Date, displacementVolume: Double) {
        
        vin = vinCode
        date = dateOfmanufacture
        displacement = Measurement<DisplacementUnit>(value: displacementVolume, unit: DisplacementUnit.cubicCentimeter)
    }
}


extension MiataModel: NullableObject {
    
    static func dummyInstance() -> MiataModel {
        MiataModel(vinCode: "fakeOne", dateOfmanufacture: Date(), displacementVolume: 0.0)
    }
}


extension MiataModel: Equatable {
    
    static func ==(lhs: MiataModel, rhs: MiataModel) -> Bool {
        return lhs.vin == rhs.vin
    }
}


extension MiataModel: Comparable {
    static func < (lhs: MiataModel, rhs: MiataModel) -> Bool {
        return lhs.displacement < rhs.displacement
    }
}
