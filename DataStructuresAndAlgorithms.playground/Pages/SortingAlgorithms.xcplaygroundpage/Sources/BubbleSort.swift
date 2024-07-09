//
//  BubbleSort.swift
//  SortingAlgorithmCore
//
//  Created by Aliaksandr Baranouski on 03/04/2020.
//  Copyright © 2020 personal. All rights reserved.
//

import Foundation


public struct BubbleSort: SortingAlgorithm {

    
    public static func sorting<T, E, I, S>(sequence: T) -> T where T : CustomCollection, E : Comparable, E == T.Element, I : Strideable, I == T.Index, S : SignedInteger, S == I.Stride {
        
        if sequence.isEmpty || sequence.count == 1 {
            return sequence
        }
        
        var sorted = sequence
        
        var swapped = true
        var i = 0
        
        while swapped {
            
            swapped = false
            
            let innerLoopEnd = sorted.index(sorted.endIndex, offsetBy: (-i - 1), limitedBy: sorted.startIndex) ?? sorted.startIndex
            for j in sorted.startIndex..<innerLoopEnd {
                
                let next = sorted.index(after: j)
                
                if sorted[j] > sorted[next] {
                    
                    swap(in: &sorted, at: j, with: next)
                    swapped = true
                }
            }
            
            i += 1
        }
        

        return sorted
    }
}
