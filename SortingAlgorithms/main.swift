//
//  main.swift
//  SortingAlgorithms
//
//  Created by Aliaksandr Baranouski on 27/03/2020.
//  Copyright © 2020 personal. All rights reserved.
//

import Foundation

//TODO: Unit tests with measurements
typealias CustomCollection = RandomAccessCollection & MutableCollection

protocol SortingAlgorithm {

    func sorting<T: CustomCollection, E: Comparable, I: Strideable, S: SignedInteger>(sequence: T) -> T where T.Element == E, T.Index == I, I.Stride == S
    
    func swap<T:CustomCollection>(in: inout T, at: T.Index, with: T.Index)
}


extension SortingAlgorithm {
    
    func swap<T>( in collection: inout T, at: T.Index, with: T.Index) where T : CustomCollection {
        
        let tmp = collection[at]
        collection[at] = collection[with]
        collection[with] = tmp
    }
}



struct BubbleSort: SortingAlgorithm {

    
    func sorting<T, E, I, S>(sequence: T) -> T where T : CustomCollection, E : Comparable, E == T.Element, I : Strideable, I == T.Index, S : SignedInteger, S == I.Stride {
        
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


struct QuickSort: SortingAlgorithm {
    
    
    func sorting<T, E, I, S>(sequence: T) -> T where T : CustomCollection, E : Comparable, E == T.Element, I : Strideable, I == T.Index, S : SignedInteger, S == I.Stride {
        
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


extension RandomAccessCollection where Element : Comparable, Index: Strideable {
    
    func middleIndex<S>() -> Index where S == Index.Stride, S: SignedInteger {
        
        let half = startIndex.distance(to: endIndex) / 2
        return startIndex.advanced(by: half)
    }
}


struct MergeSort: SortingAlgorithm {
    
    
    func sorting<T, E, I, S>(sequence: T) -> T where T : MutableCollection, T : RandomAccessCollection, E : Comparable, E == T.Element, I : Strideable, I == T.Index, S : SignedInteger, S == I.Stride {
        
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

print("starting")

let n = 10
var ints = Array(repeating: 0, count: n)
ints.fillWithRandomElements(n: n, range: 0...500)

//let sortedA = BubbleSort().sorting(sequence: ints)
//let sortedB = QuickSort().sorting(sequence: ints)
let sortedC = MergeSort().sorting(sequence: ints)

//print(BubbleSort().sorting(sequence: ints))
//print(QuickSort().sorting(sequence: ints))
//print(sortedA == sortedB)

print(sortedC)

