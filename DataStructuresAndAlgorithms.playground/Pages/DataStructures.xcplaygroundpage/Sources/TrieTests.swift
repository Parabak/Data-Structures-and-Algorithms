import Foundation


public struct TrieTests {

    public struct TestResult {
        let id: Int
        let duration: Double // ms
        let succeeded: Bool
    }

    struct PrefixTestCase {

        static func run(id: Int, words: [String], expectedResult: String?) -> TestResult {
            let startTime = (Date.timeIntervalSinceReferenceDate * 1000).rounded()
            let isSucceeded = findPrefix(words: words) == expectedResult
            let endTime = (Date.timeIntervalSinceReferenceDate * 1000 ).rounded()
            return .init(id: id, duration: endTime - startTime, succeeded: isSucceeded)
        }
    }

    public static func runTests() -> [TestResult] {

        var results = [TestResult]()
        results.append(
            PrefixTestCase.run(id: 1, words: ["aab", "aac", "aacghgh", "aabghgh"], expectedResult: "aacghgh")
        )

        results.append(
            PrefixTestCase.run(
                id: 2,
                words:  ["aab", "defgab", "abcde", "aabcde", "cedaaa", "bbbbbbbbbb", "jabjjjad"],
                expectedResult: "aabcde"
            )
        )

        if let dataSetURL = Bundle(for: Trie.self).url(forResource: "TestData", withExtension: "txt"),
           let dataSet = try? String(contentsOf: dataSetURL, encoding: .utf8) {

            results.append(
                PrefixTestCase.run(
                    id: 3,
                    words: dataSet.components(separatedBy: .whitespacesAndNewlines),
                    expectedResult: nil
                )
            )
        }

        return results
    }
}
