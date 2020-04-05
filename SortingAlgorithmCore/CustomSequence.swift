//
//  CustomSequence.swift
//  SortingAlgorithmCore
//
//  Created by Aliaksandr Baranouski on 03/04/2020.
//  Copyright © 2020 personal. All rights reserved.
//

import Foundation

//class MyDimensionalUnit : Dimension {
//    class var unitA : MyDimensionalUnit {
//        return MyDimensionalUnit(symbol: "a", converter: UnitConverterLinear(coefficient: 1))
//    }
//    class var unitKiloA : MyDimensionalUnit {
//        return MyDimensionalUnit(symbol: "ka", converter: UnitConverterLinear(coefficient: 1_000))
//    }
//    class var unitMegaA : MyDimensionalUnit {
//        return MyDimensionalUnit(symbol: "Ma", converter: UnitConverterLinear(coefficient: 1_000_000))
//    }
//    override class func baseUnit() -> MyDimensionalUnit {
//        return MyDimensionalUnit.unitA
//    }
//}



final class DisplacementUnit: Dimension {
    
    static var cubicCentimeter = DisplacementUnit(symbol: "cc", converter: UnitConverterLinear(coefficient: 1.0))
    
    static let litr = DisplacementUnit(symbol: "l", converter: UnitConverterLinear(coefficient: 1000.0))
    
    override class func baseUnit() -> DisplacementUnit {

        //Can't understand how to avoid casting
        return DisplacementUnit.cubicCentimeter
    }
}


protocol NullObject {
    
    static func dummyInstance() -> Self
}



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

extension MiataModel: NullObject {
    
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


struct CustomSequence<E>: CustomCollection where E: NullObject {
 
    typealias Element = E
    
    typealias Index = Int
    
    typealias SubSequence = CustomSequence
    
    var startIndex: Int = 0
    var endIndex: Int = 0
    
    private var storage = [E]()
        
    subscript(position: Int) -> E {
        get {
            storage[position]
        }
        set(newValue) {
            
            if storage.isEmpty || position == endIndex {
                append(.dummyInstance())
            }
            else if position > endIndex {
            
                // Append Null object N times, where N is a diff between position and current end index
                for _ in 0...storage.distance(from: endIndex, to: position) {
                    append(.dummyInstance())
                }
            }
            storage[position] = newValue
        }
    }
    
    
//    subscript(bounds: ClosedRange<Int>) -> Slice<CustomSequence<E>> {
//
//        let range = Range(bounds)
//        return Slice<CustomSequence<E>>(base: self, bounds: range)
//    }
    
    
    subscript(bounds: Range<Self.Index>) -> Self.SubSequence {
        get {
            return SubSequence(startIndex: bounds.startIndex, endIndex: bounds.endIndex, storage: storage)
        }
        set (newValue) {
            
            var counter = 0
            for i in bounds {
                storage[i] = newValue[newValue.startIndex + counter]
                counter += 1
            }
        }
    }


    private mutating func append(_ element: E) -> Void {
    
        storage.append(element)
        endIndex += 1
    }
}


extension CustomSequence: Equatable where Element: Equatable {
    
    static func == (lhs: CustomSequence<E>, rhs: CustomSequence<E>) -> Bool {
        
        if lhs.count != rhs.count {
            return false
        }
        
        for i in 0..<lhs.count {
            
            if lhs[i] != rhs[i] {
                return false
            }
        }
        
        return true
     }
}


extension CustomSequence {
    
    static func fillWithMiatas(n: Int) -> CustomSequence<MiataModel> {
        
        var sequence = CustomSequence<MiataModel>()
        for n in 0..<n {
            
            let displacement = Double.random(in: 1600...1800)
            let vin = UUID().uuidString
            
            sequence[n] = MiataModel(vinCode: vin,
                                     dateOfmanufacture: Date(),
                                     displacementVolume: displacement)
        }
        
        return sequence
    }
}
