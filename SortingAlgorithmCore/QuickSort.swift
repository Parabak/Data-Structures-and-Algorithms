//
//  QuickSort.swift
//  SortingAlgorithmCore
//
//  Created by Aliaksandr Baranouski on 03/04/2020.
//  Copyright © 2020 personal. All rights reserved.
//

import Foundation


public struct QuickSort: SortingAlgorithm {
    
    
    public static func sorting<T, E, I, S>(sequence: T) -> T where T : CustomCollection, E : Comparable, E == T.Element, I : Strideable, I == T.Index, S : SignedInteger, S == I.Stride {
        
        if sequence.count < 2 {
            return sequence
        }
    
        var copy = sequence
        
        let distance = sequence.startIndex.distance(to: sequence.endIndex) / 2
        let middle = sequence.startIndex.advanced(by: distance)
        let pivot = sequence[middle]
        
        let wall = copy.partition { $0 > pivot } // pivot will be still in the middle
        let idxBeforeWall = copy.index(before: wall)
        let pivotIdx = copy.firstIndex(of: pivot)!
        swap(in: &copy, at: idxBeforeWall, with: pivotIdx)
            
        let l_buffer = copy[copy.startIndex..<idxBeforeWall]
        let r_buffer = copy[wall..<copy.endIndex]
        
        let l_sorted = sorting(sequence: l_buffer)
        let r_sorted = sorting(sequence: r_buffer)
        
        copy[l_sorted.startIndex..<l_sorted.endIndex] = l_sorted
        
        copy[l_sorted.endIndex] = pivot
        
        let nextAfterPivot = copy.index(after: l_sorted.endIndex)
        copy[nextAfterPivot..<copy.endIndex] = r_sorted
        
        return copy
    }
}
