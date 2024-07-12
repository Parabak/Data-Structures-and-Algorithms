import XCTest


public class QuickSortTests: XCTestCase {

    public override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    public override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    func test_onIntegers() {

        let n = 1000
        var ints = Array(repeating: 0, count: n)
        ints.fillWithRandomElements(n: n, range: 0...500)

        let benchmark = ints.sorted()
        let output = QuickSort.sorting(sequence: ints)

        XCTAssert(benchmark == output)
    }


    func test_onCustomSequence() {

        let sequence = CustomSequence<MiataModel>.fillWithMiatas(n: 10)
        var benchmark = CustomSequence<MiataModel>.fillWithMiatas(n: 0)
        sequence.sorted().forEach { benchmark[benchmark.endIndex] = $0 }

        let output = QuickSort.sorting(sequence: sequence)

        XCTAssert(benchmark == output)
    }


    func test_PerformanceExample() {

        self.measure {
            let n = 10000
            var ints = Array(repeating: 0, count: n)
            ints.fillWithRandomElements(n: n, range: 0...500)
            _ = QuickSort.sorting(sequence: ints)
        }
    }
}
