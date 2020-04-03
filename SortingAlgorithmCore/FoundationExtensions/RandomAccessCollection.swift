//
//  RandomAccessCollection.swift
//  SortingAlgorithmCore
//
//  Created by Aliaksandr Baranouski on 03/04/2020.
//  Copyright © 2020 personal. All rights reserved.
//

import Foundation


extension RandomAccessCollection where Element : Comparable, Index: Strideable {
    
    func middleIndex<S>() -> Index where S == Index.Stride, S: SignedInteger {
        
        let half = startIndex.distance(to: endIndex) / 2
        return startIndex.advanced(by: half)
    }
}
