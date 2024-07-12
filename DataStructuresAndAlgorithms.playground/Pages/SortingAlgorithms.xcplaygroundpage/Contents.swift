import Foundation
import UIKit

print("start")

let n = 1000
var ints = Array(repeating: 0, count: n)
ints.fillWithRandomElements(n: n, range: 0...500)

let sortedA = BubbleSort.sorting(sequence: ints)
let sortedB = QuickSort.sorting(sequence: ints)
let sortedC = MergeSort.sorting(sequence: ints)

print(sortedA == sortedB && sortedB == sortedC)

import XCTest

class TestObserver: NSObject, XCTestObservation {
    func testCase(_ testCase: XCTestCase,
                  didFailWithDescription description: String,
                  inFile filePath: String?,
                  atLine lineNumber: Int) {
        assertionFailure(description, line: UInt(lineNumber))
    }
}

let testObserver = TestObserver()
XCTestObservationCenter.shared.addTestObserver(testObserver)

BubbleSortTests.defaultTestSuite.run()
MergeSortTests.defaultTestSuite.run()
QuickSortTests.defaultTestSuite.run()
print("end")
