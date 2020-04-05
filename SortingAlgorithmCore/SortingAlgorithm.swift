//
//  SortingAlgorithm.swift
//  SortingAlgorithmCore
//
//  Created by Aliaksandr Baranouski on 03/04/2020.
//  Copyright © 2020 personal. All rights reserved.
//

import Foundation


//TODO: Unit tests: measurements for all sorting algorithms
public typealias CustomCollection = RandomAccessCollection & MutableCollection

public protocol SortingAlgorithm {

    static func sorting<T: CustomCollection, E: Comparable, I: Strideable, S: SignedInteger>(sequence: T) -> T where T.Element == E, T.Index == I, I.Stride == S
    
    static func swap<T:CustomCollection>(in: inout T, at: T.Index, with: T.Index)
}


public extension SortingAlgorithm {
        
    static func swap<T>( in collection: inout T, at: T.Index, with: T.Index) where T : CustomCollection {
        
        let tmp = collection[at]
        collection[at] = collection[with]
        collection[with] = tmp
    }
}
