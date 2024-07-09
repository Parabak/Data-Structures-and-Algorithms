//
//  MergeSort.swift
//  SortingAlgorithmCore
//
//  Created by Aliaksandr Baranouski on 03/04/2020.
//  Copyright © 2020 personal. All rights reserved.
//

import Foundation


public struct MergeSort: SortingAlgorithm {

    
    public static  func sorting<T, E, I, S>(sequence: T) -> T where T : MutableCollection, T : RandomAccessCollection, E : Comparable, E == T.Element, I : Strideable, I == T.Index, S : SignedInteger, S == I.Stride {
        
        if sequence.count < 2 {
            return sequence
        }
    
        let middleIdx = sequence.middleIndex()
        let leftSorted = sorting(sequence: sequence[sequence.startIndex..<middleIdx])
        let rightSorted = sorting(sequence: sequence[middleIdx..<sequence.endIndex])
        
        var copy = sequence
        
        var leftPtr = leftSorted.startIndex
        var rightPtr = rightSorted.startIndex
        
        var left    = leftSorted.first
        var right   = rightSorted.first
        
        var counter = 0
        while leftPtr != leftSorted.endIndex || rightPtr != rightSorted.endIndex {

            func shiftIdxAndAppend(element: T.Element, from sequence: T.SubSequence, idx: T.Index) -> (T.Element?, T.Index) {

                copy[copy.index(copy.startIndex, offsetBy: counter)] = element
                let nextPtr = sequence.index(after: idx)
                let nextElement = nextPtr < sequence.endIndex ? sequence[nextPtr] : nil
                return (nextElement, nextPtr)
            }

            var shouldTakeLeft : Bool?
            if let l = left, let r = right {
                          
                shouldTakeLeft = l < r
            }
            else if let _ = left {
                
                shouldTakeLeft = true
            }
            else if let _ = right {
             
                shouldTakeLeft = false
            }
            
            guard let flag = shouldTakeLeft else { break }
            if flag {
                
                let nextPair = shiftIdxAndAppend(element: left!, from: leftSorted, idx: leftPtr)
                left = nextPair.0
                leftPtr = nextPair.1
            } else {
                
                let nextPair = shiftIdxAndAppend(element: right!, from: rightSorted, idx: rightPtr)
                right = nextPair.0
                rightPtr = nextPair.1
            }
            
            counter += 1
        }
        
        
        return copy
    }
}
