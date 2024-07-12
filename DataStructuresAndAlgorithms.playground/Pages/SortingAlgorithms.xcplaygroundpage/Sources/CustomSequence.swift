//
//  CustomSequence.swift
//  SortingAlgorithmCore
//
//  Created by Aliaksandr Baranouski on 03/04/2020.
//  Copyright © 2020 personal. All rights reserved.
//

import Foundation

public struct CustomSequence<E>: CustomCollection where E: NullableObject {
 
    public typealias Element = E
    
    public typealias Index = Int
    
    public typealias SubSequence = CustomSequence
    
    public var startIndex: Int = 0
    public var endIndex: Int = 0
    
    private var storage = [E]()

    public subscript(position: Int) -> E {
        get {
            storage[position]
        }
        set(newValue) {
            
            if storage.isEmpty || position == endIndex {
                append(.dummyInstance())
            }
            else if position > endIndex {
            
                for _ in 0...storage.distance(from: endIndex, to: position) {
                    append(.dummyInstance())
                }
            }
            storage[position] = newValue
        }
    }
    
    
    public subscript(bounds: Range<Self.Index>) -> Self.SubSequence {
        get {
            
            return Self.SubSequence(startIndex: bounds.startIndex, endIndex: bounds.endIndex, storage: storage)
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
    
    public static func == (lhs: CustomSequence<E>, rhs: CustomSequence<E>) -> Bool {
        
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


public extension CustomSequence {
    
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
