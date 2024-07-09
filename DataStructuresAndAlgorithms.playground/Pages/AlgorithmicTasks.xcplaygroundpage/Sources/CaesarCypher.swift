import Foundation


// Taken from HackerRank
extension Int {

    func increment(by increment: Int) -> Int {
        let lowercases = 97...122
        let uppercases = 65...90

        let normalisedK = increment % lowercases.count

        let isUppercaseLetter = uppercases ~= self
        let isLowercaseLetter = lowercases ~= self

        guard isUppercaseLetter || isLowercaseLetter else { return self }

        let range = isUppercaseLetter ? uppercases : lowercases

        let value = self + normalisedK
        return value > range.upperBound ? range.lowerBound + value % range.upperBound - 1 : value
    }
}

public func caesarCipher(s: String, k: Int) -> String {
    // Write your code here
    var newString = ""
    for char in s {
        guard let asciiValue = char.asciiValue else {
            newString.append(char)
            continue
        }

        let newCode = Int(asciiValue).increment(by: k)

        newString.append(Character(UnicodeScalar(newCode)!))
    }
    return newString
}

//: [Next](@next)

//Fqbfdx-Qttp-ts-ymj-Gwnlmy-Xnij-tk-Qnkj
//Always-Look-on-the-Bright-Side-of-Life
