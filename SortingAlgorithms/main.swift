//
//  main.swift
//  SortingAlgorithms
//
//  Created by Aliaksandr Baranouski on 27/03/2020.
//  Copyright © 2020 personal. All rights reserved.
//

import Foundation

import SortingAlgorithmCore

print("start")

let n = 1000
var ints = Array(repeating: 0, count: n)
ints.fillWithRandomElements(n: n, range: 0...500)

let sortedA = BubbleSort.sorting(sequence: ints)
let sortedB = QuickSort.sorting(sequence: ints)
let sortedC = MergeSort.sorting(sequence: ints)

print(sortedA == sortedB && sortedB == sortedC)


print("end")

