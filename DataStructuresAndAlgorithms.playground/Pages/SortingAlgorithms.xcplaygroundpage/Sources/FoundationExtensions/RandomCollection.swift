//
//  RandomCollection.swift
//  SortingAlgorithms
//
//  Created by Aliaksandr Baranouski on 27/03/2020.
//  Copyright © 2020 personal. All rights reserved.
//

import Foundation

public extension Array where Element == Int {
    
    mutating func fillWithRandomElements(n: Int, range: ClosedRange<Int>) {
        
        for i in 0..<n {
            self[i] = Int.random(in: range)
        }
     }
   
    
     func sum() -> Int {

        switch self.count {
        case 0:
            return 0
        case 1:
            return self.first!
        default:

            return (self.first ?? 0) + Array(self.dropFirst()).sum()
        }
    }
}
